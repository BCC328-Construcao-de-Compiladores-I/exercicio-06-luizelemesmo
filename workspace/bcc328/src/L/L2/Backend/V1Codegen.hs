module L.L2.Backend.V1Codegen where

import L.L2.Frontend.Syntax
import V.V1.Instr
import Utils.Value

v1Codegen :: L2 -> Code
v1Codegen (L2 stmts) = concatMap codegenS2 stmts ++ [Halt]

codegenS2 :: S2 -> Code
codegenS2 (Def var expr stmts) = codegenE2 expr ++ [Store var] ++ concatMap codegenS2 stmts
codegenS2 (LRead _ var) = [Input, Store var]
codegenS2 (LPrint expr) = codegenE2 expr ++ [Print]
codegenS2 (LAssign var expr) = codegenE2 expr ++ [Store var]

codegenE2 :: E2 -> Code
codegenE2 (LVal v) = [Push v]
codegenE2 (LVar var) = [Load var]
codegenE2 (LAdd e1 e2) = codegenE2 e1 ++ codegenE2 e2 ++ [Add]
codegenE2 (LMinus e1 e2) = codegenE2 e1 ++ codegenE2 e2 ++ [Sub]
codegenE2 (LDiv e1 e2) = codegenE2 e1 ++ codegenE2 e2 ++ [Div]