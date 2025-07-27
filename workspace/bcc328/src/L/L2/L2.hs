{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Control.Monad.Except (runExceptT)
import qualified Data.Map as Map
import L.L2.Backend.CCodegen (cCodegen)
import L.L2.Backend.V1Codegen (v1Codegen)
import L.L2.Frontend.Lexer (Lexeme (..), Token (..), lexer)
import L.L2.Frontend.Parser
import L.L2.Frontend.Syntax (E2 (..), L2 (..), S2 (..))
import L.L2.Frontend.TypeCheck (typeCheck)
import L.L2.Interpreter.Interp (interp)
import System.Environment
import System.Exit (ExitCode (..))
import System.FilePath
import System.Process
import Utils.Pretty (Pretty (ppr), render)

main :: IO ()
main = do
  args <- getArgs
  let opts = parseOptions args
  runWithOptions opts

-- running the compiler / interpreter

runWithOptions :: [Option] -> IO ()
runWithOptions opts = case opts of
  [Lexer file] ->
    lexerOnly file
  [Parser file] ->
    parserOnly file
  [Interpret file] ->
    interpret file
  [VM file] ->
    v1Compiler file
  [C file] ->
    cCompiler file
  _ -> helpMessage

-- Implement the function to do lexical analysis for L2 programs and outputs the tokens

lexerOnly :: FilePath -> IO ()
lexerOnly file = do
  content <- readFile file
  let tokens = lexer content
  mapM_ printToken tokens
  where
    printToken (Token (line, col) lexeme) =
      putStrLn $ showLexeme lexeme ++ " Linha:" ++ show line ++ " Coluna:" ++ show col

-- Implement the function to do syntax analysis for L2 programs and outputs the syntax tree

parserOnly :: FilePath -> IO ()
parserOnly file = do
  content <- readFile file
  let tokens = lexer content
  case l2Parser tokens of
    Left err -> putStrLn err
    Right prog -> print prog -- putStrLn $ render (ppr prog)

-- Implement the whole interpreter pipeline: lexical and syntax analysis and then interpret the program

interpret :: FilePath -> IO ()
interpret arquivo = do
  entrada <- readFile arquivo
  let tokens = lexer entrada
  case l2Parser tokens of
    Left erro -> putStrLn $ "Syntax Error: " ++ erro
    Right programa -> do
      case typeCheck programa of
        Left erroSemantico -> putStrLn $ "Semantic Error: " ++ erroSemantico
        Right _ -> do
          resultado <- runExceptT $ interp entrada
          case resultado of
            Left erro -> putStrLn $ "Interpreter Error: " ++ erro
            Right () -> putStrLn "Program interpreted successfully"

-- Implement the whole compiler pipeline: lexical, syntax and semantic analysis and then generate v1 instructions from the program.

v1Compiler :: FilePath -> IO ()
v1Compiler file = do
  content <- readFile file
  let tokens = lexer content
  case l2Parser tokens of
    Left err -> putStrLn $ "Syntax Error: " ++ err
    Right prog -> case typeCheck prog of
      Left err -> putStrLn $ "Semantic Error: " ++ err
      Right prog' -> do
        let code = v1Codegen prog'
        let outputFile = replaceExtension file "v1"
        writeFile outputFile (render $ ppr code)

-- Implement the whole executable compiler, using C source and GCC.

cCompiler :: FilePath -> IO ()
cCompiler file = do
    content <- readFile file
    let tokens = lexer content
    case l2Parser tokens of
      Left err -> putStrLn $ "Syntax Error: " ++ err
      Right prog -> case typeCheck prog of
        Left err -> putStrLn $ "Semantic Error: " ++ err
        Right prog' -> do
          let cCode = cCodegen prog'
          let cFile = replaceExtension file "c"
          let execFile = dropExtension file
          writeFile cFile cCode
          exitCode <- system $ "gcc " ++ cFile ++ " -o " ++ execFile
          case exitCode of
            ExitSuccess -> putStrLn $ "Executable generated: " ++ execFile
            ExitFailure code -> putStrLn $ "GCC compilation error: code " ++ show code

-- help message

helpMessage :: IO ()
helpMessage =
  putStrLn $
    unlines
      [ "L2 language",
        "Usage: l2 [--lexer-only | --parse-only | --interpret | --help]",
        "--lexer-only: does the lexical analysis of the input program.",
        "--parse-only: does the syntax analysis of the input program.",
        "--interpret: does the syntax and semantic analysis and interpret the input program.",
        "--v1: does the syntax and semantic analysis and then generates V1 code.",
        "--c: does the syntax and semantic analysis, generates C code and uses GCC to generate an executable.",
        "--help: prints this help message."
      ]

-- parse command line arguments

data Option
  = Help
  | Lexer FilePath
  | Parser FilePath
  | Interpret FilePath
  | VM FilePath
  | C FilePath
  deriving (Eq, Show)

parseOptions :: [String] -> [Option]
parseOptions args =
  case args of
    ("--lexer-only" : arg : _) -> [Lexer arg]
    ("--parse-only" : arg : _) -> [Parser arg]
    ("--interpret" : arg : _) -> [Interpret arg]
    ("--v1" : arg : _) -> [VM arg]
    ("--c" : arg : _) -> [C arg]
    _ -> [Help]

-- show lexeme
showLexeme :: Lexeme -> String
showLexeme TDef = "Palavra reservada def"
showLexeme TIn = "Palavra reservada in"
showLexeme TEnd = "Palavra reservada end"
showLexeme (TIdent s) = "Identificador " ++ s
showLexeme (TNumber n) = "Número " ++ show n
showLexeme (TString s) = "String " ++ s
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