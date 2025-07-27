{
module L.L1.Frontend.LALRParser where

import L.L1.Frontend.Syntax
import L.L1.Frontend.Lexer
import Utils.Var (Var(..))
import Utils.Value (Value(..))
}

%name lalrParser
%tokentype { Token }
%error { parseError }
%monad { Either String }

%token
  IDENT     { Token _ (TIdent $$) }
  NUMBER    { Token _ (TNumber $$) }
  STRING    { Token _ (TString $$) }
  PLUS      { Token _ TPlus }
  MINUS     { Token _ TMinus }
  TIMES     { Token _ TTimes }
  DIV       { Token _ TDiv }
  ASSIGN    { Token _ TAssign }
  SEMICOLON { Token _ TSemicolon }
  COMMA     { Token _ TComma }
  LPAREN    { Token _ TLParen }
  RPAREN    { Token _ TRParen }
  READ      { Token _ TRead }
  PRINT     { Token _ TPrint }
  EOF       { Token _ TEOF }

%left PLUS MINUS
%left TIMES DIV

%%

Program :: { L1 }
Program : Stmts { L1 (reverse $1) }

Stmts :: { [S1] }
Stmts : Stmts Stmt { $2 : $1 }
      | { [] }

Stmt :: { S1 }
Stmt : IDENT ASSIGN Expr SEMICOLON { LAssign (Var $1) $3 }
     | IDENT ASSIGN Expr { LAssign (Var $1) $3 }
     | READ LPAREN OptString Var RPAREN SEMICOLON { LRead $3 $4 }
     | READ LPAREN OptString Var RPAREN { LRead $3 $4 }
     | PRINT LPAREN STRING PLUS Expr RPAREN SEMICOLON { LPrint $3 $5 }
     | PRINT LPAREN STRING PLUS Expr RPAREN { LPrint $3 $5 }
     | PRINT LPAREN Expr RPAREN SEMICOLON { LPrint "" $3 }
     | PRINT LPAREN Expr RPAREN { LPrint "" $3 }

OptString :: { String }
OptString : STRING COMMA { $1 }
          | { "" }

Var :: { Var }
Var : IDENT { Var $1 }

Expr :: { E1 }
Expr : Expr PLUS Expr { LAdd $1 $3 }
     | Expr MINUS Expr { LMinus $1 $3 }
     | Expr TIMES Expr { LMul $1 $3 }
     | Expr DIV Expr { LDiv $1 $3 }
     | NUMBER { LVal (VInt $1) }
     | IDENT { LVar (Var $1) }
     | LPAREN Expr RPAREN { $2 }

{
parseError :: [Token] -> Either String a
parseError toks = Left $ "Parse error at " ++ show toks
}