module L.L2.Interpreter.Interp where 

import L.L2.Frontend.Parser (l2Parser)
import L.L2.Frontend.Lexer
import L.L2.Frontend.Syntax
import Utils.Value (Value(..), (.+.), (.-.), (.*.), (./.))
import Utils.Var
import Utils.Pretty
import Data.Map (Map)
import qualified Data.Map as Map
import Control.Monad.Except
import Control.Monad.IO.Class (liftIO)

type Env = Map Var Value

-- Ambientes: (mutáveis, imutáveis)
type InterpM a = ExceptT String IO a

interp :: String -> InterpM ()
interp content = do
  tokens <- liftEither $ Right (lexer content)
  ast <- liftEither $ l2Parser tokens
  case ast of
    L2 stmts -> do
      _ <- evalStmts (Map.empty, Map.empty) stmts
      return ()

evalStmts :: (Env, Env) -> [S2] -> InterpM (Env, Env)
evalStmts env [] = return env
evalStmts env (s:stmts) = do
  newEnv <- evalS2 env s
  evalStmts newEnv stmts

evalS2 :: (Env, Env) -> S2 -> InterpM (Env, Env)
evalS2 (mutEnv, immutEnv) (LAssign var expr) = do
  val <- liftEither $ evalE2 (mutEnv, immutEnv) expr
  return (Map.insert var val mutEnv, immutEnv)

evalS2 (mutEnv, immutEnv) (LRead prompt var) = do
  liftIO $ putStrLn prompt
  input <- liftIO getLine
  case parseValue input of
    Just val -> return (Map.insert var val mutEnv, immutEnv)
    Nothing -> throwError $ "Invalid input for read: " ++ input

evalS2 (mutEnv, immutEnv) (LPrint expr) = do
  val <- liftEither $ evalE2 (mutEnv, immutEnv) expr
  liftIO $ putStrLn $ show val  
  return (mutEnv, immutEnv)

evalS2 (mutEnv, immutEnv) (Def var expr block) = do
  val <- liftEither $ evalE2 (mutEnv, immutEnv) expr
  let immutEnv' = Map.insert var val immutEnv
  (mutEnvAfterBlock, _) <- evalStmts (mutEnv, immutEnv') block
  return (mutEnvAfterBlock, immutEnv)

evalE2 :: (Env, Env) -> E2 -> Either String Value
evalE2 _ (LVal v) = Right v
evalE2 (mutEnv, immutEnv) (LVar var) = case Map.lookup var immutEnv of
  Just val -> Right val
  Nothing -> case Map.lookup var mutEnv of
    Just val -> Right val
    Nothing -> Left $ "Undefined variable: " ++ show var
evalE2 env (LAdd e1 e2) = do
  v1 <- evalE2 env e1
  v2 <- evalE2 env e2
  v1 .+. v2
evalE2 env (LMinus e1 e2) = do
  v1 <- evalE2 env e1
  v2 <- evalE2 env e2
  v1 .-. v2
evalE2 env (LMul e1 e2) = do
  v1 <- evalE2 env e1
  v2 <- evalE2 env e2
  v1 .*. v2
evalE2 env (LDiv e1 e2) = do
  v1 <- evalE2 env e1
  v2 <- evalE2 env e2
  v1 ./. v2

-- Parse input strings to Value
parseValue :: String -> Maybe Value
parseValue s = case reads s :: [(Int, String)] of
  [(n, "")] -> Just (VInt n)
  _ -> Nothing