module L.L2.Backend.CCodegen where
import L.L2.Frontend.Syntax
import Utils.Value
import Utils.Var (Var)
import Utils.Pretty (render, ppr)
import Data.List (nub)

collectVars :: L2 -> [Var]
collectVars (L2 stmts) = nub $ concatMap collectVarsS2 stmts

collectVarsS2 :: S2 -> [Var]
collectVarsS2 (LAssign var _) = [var]
collectVarsS2 (LRead _ var) = [var]
collectVarsS2 (LPrint _) = []
collectVarsS2 (Def _ _ block) = concatMap collectVarsS2 block

cCodegen :: L2 -> String
cCodegen l2@(L2 stmts) = unlines
  [ "#include <stdio.h>"
  , ""
  , "int main() {"
  , unlines (map ("    " ++) (varsToC (collectVars l2)))
  , unlines (map ("    " ++) (map cStmtGen stmts))
  , "    return 0;"
  , "}"
  ]

varsToC :: [Var] -> [String]
varsToC vars = map (\var -> "int " ++ render (ppr var) ++ ";") vars

cStmtGen :: S2 -> String
cStmtGen (LAssign var e) = render (ppr var) ++ " = " ++ cExprGen e ++ ";"
cStmtGen (LRead prompt var) = unlines
  [ "printf(\"" ++ prompt ++ "\");"
  , "scanf(\"%d\", &" ++ render (ppr var) ++ ");"
  ]
cStmtGen (LPrint e) = "printf(\"%d\\n\", " ++ cExprGen e ++ ");"
cStmtGen (Def var e block) = unlines
  [ "{"
  , "    const int " ++ render (ppr var) ++ " = " ++ cExprGen e ++ ";"
  , unlines (map ("    " ++) (map cStmtGen block))
  , "}"
  ]

cExprGen :: E2 -> String
cExprGen (LVal (VInt n)) = show n
cExprGen (LVar var) = render (ppr var)
cExprGen (LAdd e1 e2) = cExprGen e1 ++ " + " ++ cExprGen e2
cExprGen (LMinus e1 e2) = cExprGen e1 ++ " - " ++ cExprGen e2
cExprGen (LMul e1 e2) = cExprGen e1 ++ " * " ++ cExprGen e2
cExprGen (LDiv e1 e2) = cExprGen e1 ++ " / " ++ cExprGen e2