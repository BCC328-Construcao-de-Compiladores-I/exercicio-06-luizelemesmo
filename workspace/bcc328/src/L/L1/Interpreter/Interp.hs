module L.L1.Interpreter.Interp where 

import L.L1.Frontend.Parser (l1Parser)
import L.L1.Frontend.Syntax
import Utils.Value (Value(..), (.+.), (.-.), (.*.), (./.))
import Utils.Var
import Utils.Pretty
import Data.Map (Map)
import qualified Data.Map as Map
import Control.Monad.Except
import Control.Monad.IO.Class (liftIO)

type Env = Map Var Value

interp :: String -> IO (Either String Env)
interp content = runExceptT $ do
  ast <- liftEither $ l1Parser content
  case ast of
    L1 stmts -> evalStmts Map.empty stmts

evalStmts :: Env -> [S1] -> ExceptT String IO Env
evalStmts env [] = return env
evalStmts env (s:stmts) = do
  newEnv <- evalS1 env s
  evalStmts newEnv stmts

evalS1 :: Env -> S1 -> ExceptT String IO Env
evalS1 env (LAssign var expr) = do
  val <- liftEither $ evalE1 env expr
  return $ Map.insert var val env
evalS1 env (LRead prompt var) = do
  liftIO $ putStrLn prompt
  input <- liftIO getLine
  case parseValue input of
    Just val -> return $ Map.insert var val env
    Nothing -> throwError $ "Invalid input for read: " ++ input
evalS1 env (LPrint prompt expr) = do
  val <- liftEither $ evalE1 env expr
  liftIO $ putStrLn $ prompt ++ " " ++ pretty val
  return env

evalE1 :: Env -> E1 -> Either String Value
evalE1 env (LVal v) = Right v
evalE1 env (LVar var) = case Map.lookup var env of
  Just val -> Right val
  Nothing -> Left $ "Undefined variable: " ++ show var
evalE1 env (LAdd e1 e2) = do
  v1 <- evalE1 env e1
  v2 <- evalE1 env e2
  v1 .+. v2
evalE1 env (LMinus e1 e2) = do
  v1 <- evalE1 env e1
  v2 <- evalE1 env e2
  v1 .-. v2
evalE1 env (LMul e1 e2) = do
  v1 <- evalE1 env e1
  v2 <- evalE1 env e2
  v1 .*. v2
evalE1 env (LDiv e1 e2) = do
  v1 <- evalE1 env e1
  v2 <- evalE1 env e2
  v1 ./. v2

-- Parse input strings to Value
parseValue :: String -> Maybe Value
parseValue s = case reads s :: [(Int, String)] of
  [(n, "")] -> Just (VInt n)
  _ -> Nothing