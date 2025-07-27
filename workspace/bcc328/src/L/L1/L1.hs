module Main where
import L.L1.Backend.CCodegen
import L.L1.Backend.V1Codegen
import L.L1.Interpreter.Interp
import L.L1.Frontend.Lexer 
import L.L1.Frontend.Parser (l1Parser)
import qualified L.L1.Frontend.LALRParser as LALR (lalrParser)
import L.L1.Frontend.Syntax
import Utils.Pretty
import Utils.Repl
import Utils.Value
import V.V0.Instr

import System.Environment
import System.FilePath
import System.Process 

main :: IO ()
main = do
  args <- getArgs
  let opts = parseOptions args
  runWithOptions opts 

-- Running the compiler / interpreter 
runWithOptions :: [Option] -> IO ()
runWithOptions opts = case opts of 
  [Lexer file] ->
    alexBasedLexer file
  [Recursive file] -> 
    recursiveParser file
  [LALR file] -> 
    lalrParser file 
  _ -> helpMessage

-- Implement the function to do lexical analysis for L1 programs
alexBasedLexer :: FilePath -> IO ()
alexBasedLexer file = do
  content <- readFile file
  let tokens = lexer content
  mapM_ printToken tokens
  where
    printToken (Token (line, col) lexeme) =
      putStrLn $ showLexeme lexeme ++ " Linha:" ++ show line ++ " Coluna:" ++ show col

showLexeme :: Lexeme -> String
showLexeme (TIdent s) = "Identificador " ++ s
showLexeme (TNumber n) = "Número " ++ show n
showLexeme (TString s) = "String " ++ show s
showLexeme TAssign = "Atribuição :="
showLexeme TPlus = "Operador +"
showLexeme TMinus = "Operador -"
showLexeme TTimes = "Operador *"
showLexeme TSemicolon = "Ponto e vírgula ;"
showLexeme TComma = "Vírgula ,"
showLexeme TLParen = "Parêntesis ("
showLexeme TRParen = "Parêntesis )"
showLexeme TRead = "Palavra reservada read"
showLexeme TPrint = "Palavra reservada print"
showLexeme TEOF = "Fim de arquivo"

-- Implement the function to do syntax analysis using a recursive parser
recursiveParser :: FilePath -> IO ()
recursiveParser file = do
  content <- readFile file
  case l1Parser content of
    Left err -> putStrLn err
    Right prog -> print prog

-- Implement the LALR parser 
lalrParser :: FilePath -> IO ()
lalrParser file = do
  content <- readFile file
  let tokens = lexer content
  case LALR.lalrParser tokens of
    Left err -> putStrLn err
    Right prog -> print prog

-- Help message
helpMessage :: IO ()
helpMessage 
  = putStrLn $ unlines [ "L1 language" 
                       , "Usage: l1 [--lexer-only | --recursive | --help]"
                       , "--lexer-only: does the lexical analysis of the input programming using a Alex based lexer."
                       , "--recursive: does the syntax analysis using a recursive descendent Megaparsec parser."
                       , "--lalr: does the syntax analysis using a LALR parser."
                       , "--help: prints this help message."
                       ]

-- Parse command line arguments 
data Option 
  = Help 
  | Lexer FilePath
  | Recursive FilePath
  | LALR FilePath 
  deriving (Eq, Show)

parseOptions :: [String] -> [Option]
parseOptions args = 
  case args of 
    ("--lexer-only" : arg : _) -> [Lexer arg]
    ("--recursive" : arg : _) -> [Recursive arg]
    ("--lalr" : arg : _) -> [LALR arg]
    _ -> [Help]