{
{-# OPTIONS_GHC -Wno-name-shadowing #-}
module L.L2.Frontend.Lexer (Token (..), Lexeme (..), lexer) where 
}

%wrapper "posn"

$letter = [a-zA-Z]
$digit = [0-9]
$white = [\ \t\n\r]

@ident = $letter [$letter $digit]*
@number = $digit+
@string = \" [^\"]* \"

tokens :-
  $white+          ;
  "//" [^\n]*      ;
  "def"            { simpleToken TDef }
  "in"             { simpleToken TIn }
  "end"            { simpleToken TEnd }
  "read"           { simpleToken TRead } 
  "print"          { simpleToken TPrint } 
  ":="             { simpleToken TAssign } 
  "+"              { simpleToken TPlus } 
  "-"              { simpleToken TMinus } 
  "/"              { simpleToken TDiv } 
  "*"              { simpleToken TTimes } 
  ";"              { simpleToken TSemicolon } 
  ","              { simpleToken TComma } 
  "("              { simpleToken TLParen } 
  ")"              { simpleToken TRParen }                       
  @string          { mkString } 
  @number          { mkNumber }
  @ident           { mkIdent } 

{
data Token = Token { pos :: (Int, Int), lexeme :: Lexeme } deriving (Eq, Ord, Show)

data Lexeme
  = TDef
  | TIn
  | TEnd
  | TIdent String
  | TNumber Int
  | TString String
  | TAssign
  | TPlus
  | TMinus
  | TDiv
  | TTimes
  | TSemicolon
  | TComma
  | TLParen
  | TRParen
  | TRead
  | TPrint
  | TEOF
  deriving (Eq, Ord, Show)

position :: AlexPosn -> (Int, Int)
position (AlexPn _ x y) = (x, y)

mkNumber :: AlexPosn -> String -> Token
mkNumber p s = Token (position p) (TNumber (read s))

mkString :: AlexPosn -> String -> Token
mkString p s = Token (position p) (TString (init (drop 1 s)))

mkIdent :: AlexPosn -> String -> Token
mkIdent p s = Token (position p) (TIdent s)

simpleToken :: Lexeme -> AlexPosn -> String -> Token
simpleToken lx p _ = Token (position p) lx

lexer :: String -> [Token]
lexer = alexScanTokens
}