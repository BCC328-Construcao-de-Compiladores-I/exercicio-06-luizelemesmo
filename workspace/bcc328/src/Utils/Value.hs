module Utils.Value where 

import Utils.Pretty 

data Value 
  = VInt Int
  | VStr String
  | VBool Bool 
    deriving (Eq, Ord, Show)

instance Pretty Value where 
  ppr (VInt n) = int n
  ppr (VStr s) = doubleQuotes (text s)

(.+.) :: Value -> Value -> Either String Value 
(VInt n1) .+. (VInt n2) = Right (VInt (n1 + n2))
e1 .+. e2 = Left $ unwords ["Type error on:", pretty e1, "+", pretty e2] 

(.*.) :: Value -> Value -> Either String Value 
(VInt n1) .*. (VInt n2) = Right (VInt (n1 * n2))
e1 .*. e2 = Left $ unwords ["Type error on:", pretty e1, "*", pretty e2] 

(.-.) :: Value -> Value -> Either String Value
(VInt n1) .-. (VInt n2) = Right (VInt (n1 - n2))
e1 .-. e2 = Left $ unwords ["Type error on:", pretty e1, "-", pretty e2]

(./.) :: Value -> Value -> Either String Value
(VInt n1) ./. (VInt n2) = if n2 /= 0
  then Right (VInt (n1 `div` n2))
  else Left $ unwords ["Division by zero:", pretty (VInt n1), "/", pretty (VInt n2)]
e1 ./. e2 = Left $ unwords ["Type error on:", pretty e1, "/", pretty e2]

(.<.) :: Value -> Value -> Either String Value
(.<.) v1 v2 = case (v1, v2) of
  (VInt n1, VInt n2) -> return $ VBool (n1 < n2)
  _ -> Left "Type error in < operation"

(.=.) :: Value -> Value -> Either String Value
(.=.) v1 v2 = case (v1, v2) of
  (VInt n1, VInt n2) -> return $ VBool (n1 == n2)
  (VBool b1, VBool b2) -> return $ VBool (b1 == b2)
  _ -> Left "Type error in == operation"

vand :: Value -> Value -> Either String Value
vand v1 v2 = case (v1, v2) of
  (VBool b1, VBool b2) -> return $ VBool (b1 && b2)
  _ -> Left "Type error in && operation"

vnot :: Value -> Either String Value
vnot v = case v of
  VBool b -> return $ VBool (not b)
  _ -> Left "Type error in not operation"