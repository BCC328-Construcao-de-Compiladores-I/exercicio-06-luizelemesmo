module L.L2.Frontend.TypeCheck where

import Control.Monad (unless, when)
import Control.Monad.Except
import Control.Monad.Identity
import Control.Monad.State
import Control.Monad.Writer
import Data.List ((\\))
import L.L2.Frontend.Syntax
import Utils.Var
import Utils.Value (Value (..))

typeCheck :: L2 -> Either String L2
typeCheck prog = case runTcM initTcEnv (checkL2 prog) of
    ((Left err, _), _) -> Left err
    ((Right _, _), _) -> Right prog

-- Monad infrastructure
type TcM a = ExceptT String (WriterT [String] (StateT TcEnv Identity)) a

data TcEnv = TcEnv
  { mutContext :: [Var] -- mutable variables
  , immutContext :: [Var] -- immutable variables
  }

initTcEnv :: TcEnv
initTcEnv = TcEnv [] []

insertMutVar :: Var -> TcM ()
insertMutVar v = modify (\env -> env { mutContext = v : mutContext env })

insertImmutVar :: Var -> TcM ()
insertImmutVar v = modify (\env -> env { immutContext = v : immutContext env })

removeMutVar :: Var -> TcM ()
removeMutVar v = modify (\env -> env { mutContext = mutContext env \\ [v] })

removeImmutVar :: Var -> TcM ()
removeImmutVar v = modify (\env -> env { immutContext = immutContext env \\ [v] })

runTcM :: TcEnv -> TcM a -> (((Either String a), [String]), TcEnv)
runTcM env m = runIdentity (runStateT (runWriterT (runExceptT m)) env)

checkL2 :: L2 -> TcM ()
checkL2 (L2 stmts) = mapM_ checkS2 stmts

checkS2 :: S2 -> TcM ()
checkS2 (Def var expr stmts) = do
  checkE2 expr
  insertImmutVar var
  mapM_ checkS2 stmts
  removeImmutVar var
checkS2 (LRead _ var) = do
  env <- get
  when (var `elem` immutContext env) $
    throwError $ "Cannot assign to immutable variable: " ++ show var
  insertMutVar var -- Implicitly declare mutable variable
  return ()
checkS2 (LPrint expr) = checkE2 expr
checkS2 (LAssign var expr) = do
  env <- get
  when (var `elem` immutContext env) $
    throwError $ "Cannot assign to immutable variable: " ++ show var
  insertMutVar var -- Implicitly declare mutable variable
  checkE2 expr

checkE2 :: E2 -> TcM ()
checkE2 (LVal _) = return ()
checkE2 (LVar var) = do
  env <- get
  unless (var `elem` mutContext env || var `elem` immutContext env) $
    throwError $ "Variable " ++ show var ++ " not in scope"
checkE2 (LAdd e1 e2) = checkE2 e1 >> checkE2 e2
checkE2 (LMinus e1 e2) = checkE2 e1 >> checkE2 e2
checkE2 (LDiv e1 e2) = checkE2 e1 >> checkE2 e2
checkE2 (LMul e1 e2) = checkE2 e1 >> checkE2 e2