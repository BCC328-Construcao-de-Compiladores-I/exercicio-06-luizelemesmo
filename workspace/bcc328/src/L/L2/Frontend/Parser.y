{
module L.L2.Frontend.Parser where
import L.L2.Frontend.Lexer
import L.L2.Frontend.Syntax
import Utils.Var (Var(..))
import Utils.Value (Value(..))
}

%name l2Parser
%tokentype { Token }
%error { parseError }
%monad { Either String }

%token
  DEF       { Token _ TDef }
  IN        { Token _ TIn }
  END       { Token _ TEnd }
  IDENT     { Token _ (TIdent $$) }
  NUMBER    { Token _ (TNumber $$) }
  PLUS      { Token _ TPlus }
  MINUS     { Token _ TMinus }
  TIMES     { Token _ TTimes }
  DIV       { Token _ TDiv }
  STRING    { Token _ (TString $$) }
  ASSIGN    { Token _ TAssign }
  SEMICOLON { Token _ TSemicolon }
  LPAREN    { Token _ TLParen }
  RPAREN    { Token _ TRParen }
  READ      { Token _ TRead }
  PRINT     { Token _ TPrint }
  COMMA     { Token _ TComma }
  EOF       { Token _ TEOF }

%left LPAREN RPAREN
%left PLUS MINUS
%left TIMES DIV

%%

Program :: { L2 }
Program : Stmts EOF { L2 $1 } 

Stmts :: { [S2] }
Stmts : Stmt { [$1] }
      | Stmts Stmt { $1 ++ [$2] }

Stmt :: { S2 }
Stmt : IDENT ASSIGN Expr SEMICOLON { LAssign (Var $1) $3 }
     | READ LPAREN STRING COMMA Var RPAREN SEMICOLON { LRead $3 $5 }
     | PRINT LPAREN Expr RPAREN SEMICOLON { LPrint $3 }
     | BlockStmt { $1 }

BlockStmt :: { S2 }
BlockStmt : DEF IDENT ASSIGN Expr IN ScopedStmts END { Def (Var $2) $4 $6 } 

ScopedStmts :: { [S2] }
ScopedStmts : Stmt { [$1] }
            | ScopedStmts Stmt { $1 ++ [$2] }

Var :: { Var }
Var : IDENT { Var $1 }

Expr :: { E2 }
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