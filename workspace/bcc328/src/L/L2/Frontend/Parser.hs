{-# OPTIONS_GHC -w #-}
module L.L2.Frontend.Parser where
import L.L2.Frontend.Lexer
import L.L2.Frontend.Syntax
import Utils.Var (Var(..))
import Utils.Value (Value(..))
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.0

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 (L2)
	| HappyAbsSyn5 ([S2])
	| HappyAbsSyn6 (S2)
	| HappyAbsSyn9 (Var)
	| HappyAbsSyn10 (E2)

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Prelude.Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46 :: () => Prelude.Int -> ({-HappyReduction (Either String) = -}
	   Prelude.Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Either String) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Either String) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Either String) HappyAbsSyn)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18 :: () => ({-HappyReduction (Either String) = -}
	   Prelude.Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Either String) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Either String) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Either String) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,89) ([9216,768,1152,96,144,44,0,0,0,16384,0,0,4,0,2,16384,0,0,32768,257,0,4,1536,4,8192,0,0,0,0,24576,64,61440,4,0,0,0,0,1030,0,2048,57344,33,768,2,16480,0,2060,32768,257,0,16,512,0,3840,1,0,16384,60,9216,768,0,0,0,2,0,0,0,0,0,0,0,12288,0,1536,0,1024,0,0,6656,384,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_l2Parser","Program","Stmts","Stmt","BlockStmt","ScopedStmts","Var","Expr","DEF","IN","END","IDENT","NUMBER","PLUS","MINUS","TIMES","DIV","STRING","ASSIGN","SEMICOLON","LPAREN","RPAREN","READ","PRINT","COMMA","EOF","%eof"]
        bit_start = st Prelude.* 29
        bit_end = (st Prelude.+ 1) Prelude.* 29
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..28]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (11) = happyShift action_5
action_0 (14) = happyShift action_6
action_0 (25) = happyShift action_7
action_0 (26) = happyShift action_8
action_0 (4) = happyGoto action_9
action_0 (5) = happyGoto action_2
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (11) = happyShift action_5
action_1 (14) = happyShift action_6
action_1 (25) = happyShift action_7
action_1 (26) = happyShift action_8
action_1 (5) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (11) = happyShift action_5
action_2 (14) = happyShift action_6
action_2 (25) = happyShift action_7
action_2 (26) = happyShift action_8
action_2 (28) = happyShift action_15
action_2 (6) = happyGoto action_14
action_2 (7) = happyGoto action_4
action_2 _ = happyFail (happyExpListPerState 2)

action_3 _ = happyReduce_2

action_4 _ = happyReduce_7

action_5 (14) = happyShift action_13
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (21) = happyShift action_12
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (23) = happyShift action_11
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (23) = happyShift action_10
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (29) = happyAccept
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (14) = happyShift action_18
action_10 (15) = happyShift action_19
action_10 (23) = happyShift action_20
action_10 (10) = happyGoto action_22
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (20) = happyShift action_21
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (14) = happyShift action_18
action_12 (15) = happyShift action_19
action_12 (23) = happyShift action_20
action_12 (10) = happyGoto action_17
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (21) = happyShift action_16
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_3

action_15 _ = happyReduce_1

action_16 (14) = happyShift action_18
action_16 (15) = happyShift action_19
action_16 (23) = happyShift action_20
action_16 (10) = happyGoto action_31
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (16) = happyShift action_23
action_17 (17) = happyShift action_24
action_17 (18) = happyShift action_25
action_17 (19) = happyShift action_26
action_17 (22) = happyShift action_30
action_17 _ = happyFail (happyExpListPerState 17)

action_18 _ = happyReduce_17

action_19 _ = happyReduce_16

action_20 (14) = happyShift action_18
action_20 (15) = happyShift action_19
action_20 (23) = happyShift action_20
action_20 (10) = happyGoto action_29
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (27) = happyShift action_28
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (16) = happyShift action_23
action_22 (17) = happyShift action_24
action_22 (18) = happyShift action_25
action_22 (19) = happyShift action_26
action_22 (24) = happyShift action_27
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (14) = happyShift action_18
action_23 (15) = happyShift action_19
action_23 (23) = happyShift action_20
action_23 (10) = happyGoto action_40
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (14) = happyShift action_18
action_24 (15) = happyShift action_19
action_24 (23) = happyShift action_20
action_24 (10) = happyGoto action_39
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (14) = happyShift action_18
action_25 (15) = happyShift action_19
action_25 (23) = happyShift action_20
action_25 (10) = happyGoto action_38
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (14) = happyShift action_18
action_26 (15) = happyShift action_19
action_26 (23) = happyShift action_20
action_26 (10) = happyGoto action_37
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (22) = happyShift action_36
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (14) = happyShift action_35
action_28 (9) = happyGoto action_34
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (16) = happyShift action_23
action_29 (17) = happyShift action_24
action_29 (18) = happyShift action_25
action_29 (19) = happyShift action_26
action_29 (24) = happyShift action_33
action_29 _ = happyFail (happyExpListPerState 29)

action_30 _ = happyReduce_4

action_31 (12) = happyShift action_32
action_31 (16) = happyShift action_23
action_31 (17) = happyShift action_24
action_31 (18) = happyShift action_25
action_31 (19) = happyShift action_26
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (11) = happyShift action_5
action_32 (14) = happyShift action_6
action_32 (25) = happyShift action_7
action_32 (26) = happyShift action_8
action_32 (6) = happyGoto action_42
action_32 (7) = happyGoto action_4
action_32 (8) = happyGoto action_43
action_32 _ = happyFail (happyExpListPerState 32)

action_33 _ = happyReduce_18

action_34 (24) = happyShift action_41
action_34 _ = happyFail (happyExpListPerState 34)

action_35 _ = happyReduce_11

action_36 _ = happyReduce_6

action_37 _ = happyReduce_15

action_38 _ = happyReduce_14

action_39 (18) = happyShift action_25
action_39 (19) = happyShift action_26
action_39 _ = happyReduce_13

action_40 (18) = happyShift action_25
action_40 (19) = happyShift action_26
action_40 _ = happyReduce_12

action_41 (22) = happyShift action_46
action_41 _ = happyFail (happyExpListPerState 41)

action_42 _ = happyReduce_9

action_43 (11) = happyShift action_5
action_43 (13) = happyShift action_45
action_43 (14) = happyShift action_6
action_43 (25) = happyShift action_7
action_43 (26) = happyShift action_8
action_43 (6) = happyGoto action_44
action_43 (7) = happyGoto action_4
action_43 _ = happyFail (happyExpListPerState 43)

action_44 _ = happyReduce_10

action_45 _ = happyReduce_8

action_46 _ = happyReduce_5

happyReduce_1 = happySpecReduce_2  4 happyReduction_1
happyReduction_1 _
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (L2 happy_var_1
	)
happyReduction_1 _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 ([happy_var_1]
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_2  5 happyReduction_3
happyReduction_3 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1 ++ [happy_var_2]
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happyReduce 4 6 happyReduction_4
happyReduction_4 (_ `HappyStk`
	(HappyAbsSyn10  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token _ (TIdent happy_var_1))) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (LAssign (Var happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 7 6 happyReduction_5
happyReduction_5 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token _ (TString happy_var_3))) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (LRead happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 5 6 happyReduction_6
happyReduction_6 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (LPrint happy_var_3
	) `HappyStk` happyRest

happyReduce_7 = happySpecReduce_1  6 happyReduction_7
happyReduction_7 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happyReduce 7 7 happyReduction_8
happyReduction_8 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token _ (TIdent happy_var_2))) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Def (Var happy_var_2) happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_9 = happySpecReduce_1  8 happyReduction_9
happyReduction_9 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 ([happy_var_1]
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_2  8 happyReduction_10
happyReduction_10 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1 ++ [happy_var_2]
	)
happyReduction_10 _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  9 happyReduction_11
happyReduction_11 (HappyTerminal (Token _ (TIdent happy_var_1)))
	 =  HappyAbsSyn9
		 (Var happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  10 happyReduction_12
happyReduction_12 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (LAdd happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  10 happyReduction_13
happyReduction_13 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (LMinus happy_var_1 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  10 happyReduction_14
happyReduction_14 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (LMul happy_var_1 happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  10 happyReduction_15
happyReduction_15 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (LDiv happy_var_1 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  10 happyReduction_16
happyReduction_16 (HappyTerminal (Token _ (TNumber happy_var_1)))
	 =  HappyAbsSyn10
		 (LVal (VInt happy_var_1)
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  10 happyReduction_17
happyReduction_17 (HappyTerminal (Token _ (TIdent happy_var_1)))
	 =  HappyAbsSyn10
		 (LVar (Var happy_var_1)
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  10 happyReduction_18
happyReduction_18 _
	(HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (happy_var_2
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 29 29 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	Token _ TDef -> cont 11;
	Token _ TIn -> cont 12;
	Token _ TEnd -> cont 13;
	Token _ (TIdent happy_dollar_dollar) -> cont 14;
	Token _ (TNumber happy_dollar_dollar) -> cont 15;
	Token _ TPlus -> cont 16;
	Token _ TMinus -> cont 17;
	Token _ TTimes -> cont 18;
	Token _ TDiv -> cont 19;
	Token _ (TString happy_dollar_dollar) -> cont 20;
	Token _ TAssign -> cont 21;
	Token _ TSemicolon -> cont 22;
	Token _ TLParen -> cont 23;
	Token _ TRParen -> cont 24;
	Token _ TRead -> cont 25;
	Token _ TPrint -> cont 26;
	Token _ TComma -> cont 27;
	Token _ TEOF -> cont 28;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 29 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Either String a -> (a -> Either String b) -> Either String b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> Either String a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Either String a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> Either String a
happyError' = (\(tokens, _) -> parseError tokens)
l2Parser tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> Either String a
parseError toks = Left $ "Parse error at " ++ show toks
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
