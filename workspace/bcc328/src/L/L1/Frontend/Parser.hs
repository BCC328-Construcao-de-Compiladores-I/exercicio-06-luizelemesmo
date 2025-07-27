module L.L1.Frontend.Parser where 

import Control.Applicative
import Control.Monad.Combinators.Expr
import Data.Void (Void)
import Data.Maybe (fromMaybe)
import Text.Megaparsec
import Text.Megaparsec.Char
import qualified Text.Megaparsec.Char.Lexer as L
import L.L1.Frontend.Syntax
import Utils.Var (Var(..)) -- Assuming Var is a wrapper around String
import Utils.Value (Value(..)) -- Assuming Value includes VInt for integers

-- Definition of a type for parsers
type Parser = Parsec Void String

-- Definition of a type for parser errors
type ParserError = ParseErrorBundle String Void

-- Space consumer for whitespace and comments
slexer :: Parser ()
slexer = L.space space1 (L.skipLineComment "//") (L.skipBlockComment "/*" "*/")

lexerLexeme :: Parser a -> Parser a
lexerLexeme = L.lexeme slexer

symbol :: String -> Parser String
symbol = L.symbol slexer

parserParens :: Parser a -> Parser a
parserParens = between (symbol "(") (symbol ")")

-- Basic parsers
pInteger :: Parser Value
pInteger = VInt <$> lexerLexeme L.decimal -- Assuming Value has a VInt constructor

pIdent :: Parser Var
pIdent = Var <$> lexerLexeme ((:) <$> letterChar <*> Text.Megaparsec.many alphaNumChar) -- Assuming Var is a wrapper around String

pString :: Parser String
pString = lexerLexeme (between (Text.Megaparsec.Char.char '"') (Text.Megaparsec.Char.char '"') (Text.Megaparsec.many (satisfy (/= '"'))))

reserved :: String -> Parser ()
reserved w = string w *> notFollowedBy alphaNumChar *> slexer

-- Expression parser
pFactor :: Parser E1
pFactor = choice [ LVal <$> pInteger
                 , LVar <$> pIdent
                 , parserParens pExpr
                 ]

binary :: String -> (E1 -> E1 -> E1) -> Operator Parser E1
binary name f = InfixL (f <$ symbol name)

optable :: [[Operator Parser E1]]
optable = [ [binary "*" LMul, binary "/" LDiv]
          , [binary "+" LAdd, binary "-" LMinus]
          ]

pExpr :: Parser E1
pExpr = makeExprParser pFactor optable

-- Statement parsers
pAssignStmt :: Parser S1
pAssignStmt = do
  var <- pIdent
  _ <- symbol ":="
  expr <- pExpr
  _ <- symbol ";"
  return $ LAssign var expr

pReadStmt :: Parser S1
pReadStmt = do
  _ <- reserved "read"
  _ <- symbol "("
  mStr <- optional (pString <* symbol ",")
  var <- pIdent
  _ <- symbol ")"
  _ <- symbol ";"
  let str = Data.Maybe.fromMaybe "" mStr
  return $ LRead str var

pPrintStmt :: Parser S1
pPrintStmt = do
  _ <- reserved "print"
  _ <- symbol "("
  mStr <- optional (pString <* symbol "+")
  expr <- pExpr
  _ <- symbol ")"
  _ <- symbol ";"
  let str = Data.Maybe.fromMaybe "" mStr
  return $ LPrint str expr

pStmt :: Parser S1
pStmt = choice [pReadStmt, pPrintStmt, pAssignStmt]

-- Program parser
pProgram :: Parser L1
pProgram = do
  stmts <- Text.Megaparsec.many pStmt
  slexer
  eof
  return $ L1 stmts

-- Main parser function
l1Parser :: String -> Either String L1
l1Parser input = case runParser pProgram "" input of
  Left err -> Left (errorBundlePretty err)
  Right prog -> Right prog