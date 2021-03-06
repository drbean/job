module Evaluation where 

import Model
import Interpretation
import qualified Story_Interpretation as Story
import qualified Topic_Interpretation as Topic
import Parsing
import Cats
import qualified Story_Cats as Story
import qualified Topic_Cats as Topic

import Data.Maybe
import Data.List
import Data.Tuple

lexicon :: String -> [Cat]

lexicon lexeme = maybe unknownWord id $
	find (\x -> phon (head x) == lexeme ) $
	Story.names ++ Story.nouns ++ Story.verbs ++ Story.aux ++ Story.adjs ++
	    Story.advs ++
	Topic.nouns ++ Topic.intransitives ++ Topic.transitives ++
	class_names ++ interrogatives ++
	cops ++ aux ++
	transitives ++ ditransitives ++ -- intransitives ++
	possessives ++ preps ++ determiners ++ conjuncts
	++ prons ++ reflexives
	where unknownWord = [Cat "" "" [] []]

parses :: String -> [ParseTree Cat Cat]
parses str = let ws = lexer str 
             in  [ s | catlist   <- collectCats lexicon ws, 
                       (s,[],[]) <- prsWH [] catlist  
                                 ++ prsYN  [] catlist   
                                 ++ prsTXT  [] catlist   
                                 ++ prsTAG  [] catlist
				 ]

inttuples :: [(String, [Entity] -> Bool) ]
inttuples = objects ++ relations ++ Story.objects ++ Story.relations
			    ++ Topic.objects ++ Topic.relations
infltuples = inflections ++ Topic.inflections ++ Story.inflections 

type Interp a	= String -> [a] -> Bool
int :: Interp Entity
int word = int' word inttuples infltuples where 
	int' w [] []	= error $ "'" ++ w ++ "'" ++ " has no interpretation."
	int' w [] ((infl,word):infls)	| w == infl = int' word inttuples [] 
		  			| otherwise = int' w [] infls
	int' w ((word,interp):is) infls	| w == word = interp
					| otherwise = int' w is infls

process string = map (\x -> intS x) (parses string)

singleton :: [a] -> Bool
singleton [x] = True 
singleton  _  = False 

data Constraint = C0 COP Idx
		| C1 VP Idx 
                | C2 TV Idx Idx 
                | C3 DV Idx Idx Idx
                | C4 COP Idx
		| C5 VP Idx 
                | C6 TV Idx Idx 
                | C7 DV Idx Idx Idx
                deriving Eq

instance Show Constraint where 
  show (C0 cop i)    = show (get_phon "CN" cop) ++ (' ':show i)
  show (C1 vp i)     = show (get_phon "V" vp) ++ (' ':show i)
  show (C2 tv i j)   = show (get_phon "V" tv) ++ (' ':show i) 
                              ++ (' ':show j)
  show (C3 dv i j k) = show (get_phon "V" dv) ++ (' ':show i) 
                               ++ (' ':show j) 
                               ++ (' ':show k)

  show (C4 cop i)    = '-':show (get_phon "CN" cop) ++ (' ':show i)
  show (C5 vp i)     = '-':show (get_phon "V" vp) ++ (' ':show i)
  show (C6 tv i j)   = '-':show (get_phon "V" tv) ++ (' ':show i) 
                                   ++ (' ':show j)
  show (C7 dv i j k) = '-':show (get_phon "V" dv) ++ (' ':show i) 
                                   ++ (' ':show j) 
                                   ++ (' ':show k)

maxIndex  :: Constraint -> Idx
maxIndex (C0 cop i)     = i
maxIndex (C1 vp i)     = i
maxIndex (C2 tv i j)   = max i j 
maxIndex (C3 dv i j k) = maximum [i,j,k]
maxIndex (C4 cop i)     = i
maxIndex (C5 vp i)     = i
maxIndex (C6 tv i j)   = max i j 
maxIndex (C7 dv i j k) = maximum [i,j,k]

type Context = ([(Idx,Entity)],[Constraint])
type Prop    = [Context]
type Trans   = Context -> Bool -> Prop
type Idx     = Int

size :: Context -> Int
size (c,co) = length c

lookupIdx :: Context -> Idx -> Entity 
lookupIdx ([],co)       j = error "undefined context item"
lookupIdx ((i,x):xs,co) j | i == j    = x
                           | otherwise = lookupIdx (xs,co) j

front :: (Idx,Entity) -> Context -> Context
front (i,x) (c,co) 
     | elem (i,x) c = (((i,x):(filter (/=(i,x)) c)),co)
     | otherwise    = error "item not found in context"

extend :: Context -> Entity -> Context 
extend = \ (c,co) e -> let i = length c in (((i,e):c),co)

success :: Context -> Trans -> Bool
success = \ c phi -> phi c True /= []

cutoff :: [Context] -> Idx -> [Context]
cutoff []          i = []
cutoff ((c,co):cs) i = (cutoffc c i,cutoffco co i)
                      :(cutoff cs i) 
  where 
     cutoffc []         i             = []
     cutoffc ((j,x):xs) i | j >= i    = cutoffc xs i
                          | otherwise = (j,x):(cutoffc xs i)
     cutoffco []        i             = []
     cutoffco (co:cos)  i 
                   | maxIndex co >= i = cutoffco cos i
                   | otherwise        = co:(cutoffco cos i)

neg :: Trans -> Trans
neg = \ phi c b -> if b then phi c False
                         else cutoff (phi c True) (size c)

conj :: Trans -> Trans -> Trans 
conj = \ phi psi c b -> if b 
      then concat [ psi c' True | c' <- phi c True ] 
      else if any (\c' -> psi c' True /= []) (phi c True)
           then []
           else if   (phi c True) == [] then (phi c False)
                else nub (cutoff (concat [psi c' False  | 
                                          c' <- phi c True]) 
                                 (size c))

impl ::  Trans -> Trans -> Trans 
impl = \ phi psi ->  neg (phi `conj` (neg psi))

exists :: Trans
exists = \ c b -> if   b 
                   then [ (extend c e) | e <- entities ]
                   else []

blowupPred :: String -> Idx -> Trans
blowupPred = \ word i c  b -> 
     let 
         e  = lookupIdx c i 
         c' = front (i,e) c
	 pred = int word
     in  
         if  b 
         then if   pred [e]
              then [c'] 
              else []
         else if   pred [e]
              then [] 
              else [c']

blowupCOP :: VP -> String -> Idx -> Trans
blowupCOP = \ cop word s con b -> 
         let 
             e       = lookupIdx con s
             (con',cos) = front (s,e) con
             co       = C0 cop s
             co'      = C4 cop s
             pred = int word
         in  
             if   b 
             then if   pred [e]
                  then [(con',co:cos)] 
                  else []
             else if   pred [e]
                  then [] 
                  else [(con',co':cos)]

blowupIV :: VP -> String -> Idx -> Trans
blowupIV = \ vp word i c b -> 
         let 
             e        = lookupIdx c i 
             (c',cos) = front (i,e) c
             co       = C1 vp i
             co'      = C5 vp i
             pred = int word
         in  
             if   b 
             then if   pred [e]
                  then [(c',co:cos)] 
                  else []
             else if   pred [e]
                  then [] 
                  else [(c',co':cos)]

blowupTV :: TV -> String -> Idx -> Idx -> Trans
blowupTV = \ tv word subj obj c b -> 
        let 
            e1       = lookupIdx c subj
            e2       = lookupIdx c obj 
            (c',cos) = front (subj,e1) (front (obj,e2) c)
            co       = C2 tv subj obj
            co'      = C6 tv subj obj
            pred = int word
        in  
            if   b 
            then if   pred [e1, e2]
                 then [(c',co:cos)] 
                 else []
            else if pred [e1, e2]
                 then [] 
                 else [(c',co':cos)]

blowupDV :: DV  -> String -> 
            Idx -> Idx -> Idx -> Trans
blowupDV = \ dv word subj iobj dobj c b -> 
        let 
            e1       = lookupIdx c subj
            e2       = lookupIdx c iobj 
            e3       = lookupIdx c dobj 
            (c',cos) = front (subj,e1) 
                      (front (iobj,e2)
                      (front (dobj,e3) c))
            co       = C3 dv subj iobj dobj
            co'      = C7 dv subj iobj dobj
            pred = int word
        in  
            if   b 
            then if   pred [e1, e2, e3]
                 then [(c',co:cos)] 
                 else []
            else if   pred [e1, e2, e3]
                 then [] 
                 else [(c',co':cos)]

resolveMASC :: Context -> [Idx]
resolveMASC (c,co)  = resolveMASC' c where
  resolveMASC' []                     = [] 
  resolveMASC' ((i,e):xs) | predid1 "male" e    = i : resolveMASC' xs
                          | otherwise = resolveMASC' xs

resolveFEM :: Context -> [Idx]
resolveFEM (c,co)  = resolveFEM' c where
  resolveFEM' []                     = [] 
  resolveFEM' ((i,x):xs) | predid1 "female" x  = i : resolveFEM' xs
                         | otherwise = resolveFEM' xs

resolveNEU :: Context -> [Idx]
resolveNEU (c,co)  = resolveNEU' c where
  resolveNEU'  []                     = [] 
  resolveNEU'  ((i,x):xs) | thing x   = i : resolveNEU' xs
                          | otherwise = resolveNEU' xs

resolveNAME :: Entity -> Context -> (Idx,Context)
resolveNAME x c | i /= -1   = (i,c)
                | otherwise = (j,extend c x)
  where i                                 = index x c 
        j                                 = size c 
        index x ([],co)                   = -1
        index x ((i,y):xs,co) | x == y    = i 
                              | otherwise = index x (xs,co)

coref, nonCoref :: (Idx -> Idx -> Trans) -> Idx -> Idx -> Trans
nonCoref = \ p i j c b -> if   i /= j 
                          then (p i j c b) 
                          else []
coref = \ p i j c b -> if   i == j 
                          then (p i j c b) 
                          else []

nonCoref2 :: (Idx -> Idx -> Idx -> Trans) ->
              Idx -> Idx -> Idx -> Trans
nonCoref2 = \ p i j k c b -> if   i /= j && j /= k && i /= k 
                             then (p i j k c b) 
                             else []

ided :: String -> Entity
ided name = ided' name characters where
	ided' name [] = error $ "No \"" ++ name ++ "\" in characters."
	ided' name ((n,entity):cs) | n == name = entity
                                   | otherwise = ided' name cs

anonyn :: String -> Entity
anonyn name = anonyn' name classes where
	anonyn' name [] = error $ "No \"" ++ name ++ "\" in classes."
	anonyn' name (c:cs) | c == name = firstMember name onePlacers
                             | otherwise = anonyn' name cs
	firstMember name [] = error $ "No \"" ++ name ++ "\" in onePlacers."
	firstMember name ((s,pred):ss)
		| s == name = head $ filter pred entities
		| otherwise = firstMember name ss

type TagQ = ParseTree Cat Cat
intTAG :: TagQ -> Trans
intTAG t = intS (subtree t [0])

type Sent = ParseTree Cat Cat
intS :: Sent -> Trans
intS (Branch (Cat _ "YN" _ _) [aux,s]) = case (catLabel (t2c aux)) of
	"AUX" -> intS s
	"COP" -> intS s
--intS (If   s1 s2) = (intS s1) `impl` (intS s2)
intS (Branch (Cat _ "TXT" _ _) [s1,Leaf (Cat _ "CONJ" _ _), s2])
	= (intS s1) `conj` (intS s2)
intS (Branch (Cat _ "S" _ _) [np,vp]) = (intNP np) (intVP vp)

type NP = ParseTree Cat Cat
intNP :: NP -> (Idx -> Trans) -> Trans
intNP (Leaf (Cat "he"  "NP" [Masc,Sg,Thrd,Nom,Pers]  []))
    = \p c b -> concat [p i c b | i <- resolveMASC c]
intNP (Leaf (Cat "she"  "NP" [Fem,Sg,Thrd,Nom,Pers]  []))
    = \p c b -> concat [p i c b | i <- resolveFEM  c]
intNP (Leaf (Cat "it"  "NP" [Pers,Thrd,Sg,Neutr]     []))
    = \p c b -> concat [p i c b | i <- resolveNEU  c]
intNP (Leaf (Cat "they"  "NP" [Pl,Thrd,Nom,Pers]  []))
    = \p c b -> concat [p i c b | i <- resolveMASC c]
intNP (Leaf (Cat name "NP" _ _))
        | name `elem` namelist = \p c -> 
                    let (i,c') = resolveNAME (ided name) c
                    in  p i c'
        | otherwise = \p c ->
                    let (i,c') = resolveNAME (anonyn name) c
		    in p i c'
-- intNP (PRO i)       = \ p c ->  p i c 
intNP (Branch (Cat _ "NP" _ _) [det,cn]) = (intDET det) (intCN cn) 
intNP (Branch (Cat _ "NP" _ _) [det,Leaf (Cat a "ADJ" _ _),cn]) = 
    \psi c -> let i = size c in
	(exists `conj` intCN cn i `conj` blowupPred a i `conj`
	(intDET det) (intCN cn) psi) c
intNP (Branch (Cat _ "NP" _ _) [np,Leaf (Cat "'s" "APOS" _ _),cn]) =
    \psi c -> let i = size c in 
                (exists `conj` (intCN cn i) `conj` (intNP np (\x -> blowupTV have "have" x i)) `conj` (psi i)) c
	    where have =  Leaf (Cat "have" "V" [] [])

type PP = ParseTree Cat Cat
intPP :: PP -> (Idx -> Trans) -> Trans
intPP (Branch (Cat "because_of" "PP" _ _) [prep,np]) = intNP np
intPP (Branch (Cat _ "PP" _ _) [prep,np]) = intNP np

type VP = ParseTree Cat Cat

intVP :: VP -> Idx -> Trans
intVP (Branch (Cat _ "VP" _ _) 
                [Leaf (Cat "did" "AUX" _ []),vp]) = intVP vp 
intVP (Branch (Cat _ "VP" _ _) 
                [Leaf (Cat "didn't" "AUX" _ []),vp]) = \s -> neg (intVP vp s)
intVP (Branch (Cat _ "VP" _ _) 
                [Leaf (Cat "#" "AUX" _ []),vp]) = intVP vp 

intVP vp@(Branch (Cat _ "VP" _ _) [Leaf cop@(Cat _ "COP" _ _),
    Branch (Cat "_" "COMP" [] []) [comp]])
	| (elem Ng (fs cop)) = case (catLabel (t2c comp)) of
	    "ADJ" -> \s -> neg (intCOMP comp (\c -> intCOP vp (get_phon "ADJ" vp) s))
	    "NP" -> \s -> neg (intCOMP comp (\c -> intCOP vp (get_phon "CN" vp) s ))
	| otherwise = case (catLabel (t2c comp)) of
	    "ADJ" -> \s -> intCOMP comp (\c -> intCOP vp (get_phon "ADJ" vp) s )
	    "NP" -> \s -> intCOMP comp (\c -> intCOP vp (get_phon "CN" vp) s )
	    "PP" -> \s -> intCOMP comp (\c -> intCOP vp (get_phon "CN" vp) s )
intVP iv@(Branch (Cat _ "VP" _ _) [Leaf (Cat name "V" _ _)]) = 
    \s -> intIV iv s
intVP tv@(Branch (Cat _ "VP" _ _) [Leaf (Cat name "V" _ [_]),obj1]) =
	case (catLabel ( t2c obj1 )) of
		"NP" -> \ s -> intNP  obj1 (\ o -> nonCoref (intTV tv) s o) 
		"PP" -> \ s -> intPP  obj1 (\ o -> nonCoref (intTV tv) s o) 
-- intVP (VP2 tv refl)    = self (intTV tv)
intVP dv@(Branch (Cat _ "VP" _ _) [Leaf (Cat name "V" _ [_,_]),obj1,obj2]) =
	case (catLabel (t2c obj1)) of 
		"NP" -> case (catLabel (t2c obj2)) of 
			"NP" -> \ s -> intNP obj1 (\ io -> intNP obj2 (\ o  -> 
				 nonCoref2 (intDV dv) s io o))
			"PP" -> \ s -> intNP obj1 (\ io -> intPP obj2 (\ o  -> 
				 nonCoref2 (intDV dv) s io o))
		"PP" -> case (catLabel (t2c obj2)) of 
			"NP" -> \ s -> intPP obj1 (\ io -> intNP obj2 (\ o  -> 
				 nonCoref2 (intDV dv) s io o))
			"PP" -> \ s -> intPP obj1 (\ io -> intPP obj2 (\ o  -> 
				 nonCoref2 (intDV dv) s io o))
intVP (Branch (Cat _ "AT" _ _)
    [Leaf (Cat att "VP" _ _), Leaf (Cat "to" "TO" [ToInf] []),
       (Branch (Cat _ "VP" _ _) [Leaf (Cat act "VP" _ _)])]) =
       	\s -> blowupPred (att++"_to_"++act) s
intVP at@(Branch (Cat _ "AT" _ _)
    [Leaf (Cat att "VP" _ _), Leaf (Cat "to" "TO" [ToInf] []),
       (Branch (Cat _ "VP" _ _) [Leaf (Cat act "VP" _ _),obj])]) =
	   case(catLabel (t2c obj)) of
	"NP" -> \s -> intNP obj (\o -> nonCoref (intAT at) s o)
	"PP" -> \s -> intPP obj (\o -> nonCoref (intAT at) s o)
--intVP (VP4 dv refl np) = self (\ s io -> intNP np (\ o -> 
--                                         intDV dv s io o))
--intVP (VP5 _not inf)   = \ s -> neg (intINF inf s)

intVP _ = undefined

type COP = ParseTree Cat Cat
intCOP :: COP -> Phon -> Idx -> Trans
intCOP cop@(Branch (Cat _ "VP" _ _) [Leaf (Cat _ "COP" _ [_]),comp])
	= blowupCOP cop

intCOMP comp = case (catLabel (t2c comp)) of 
	"NP" -> intNP comp 
	"ADJ" -> intADJ comp
	-- "ADJ" -> \s -> blowupPred (phon (t2c comp)) s
	"PP" -> intPP comp

intADJ (Leaf (Cat name "ADJ" _ _)) = \psi c -> let i = size c in
    (exists `conj` (blowupPred name i) `conj` psi i) c

type IV = ParseTree Cat Cat
intIV :: IV -> Idx -> Trans
intIV iv@(Branch (Cat _ "VP" _ _) [Leaf (Cat name "V" _ _)])
	= blowupIV iv name

type TV = ParseTree Cat Cat
intTV :: TV -> Idx -> Idx -> Trans
intTV tv@(Branch (Cat _ "VP" _ _) [Leaf (Cat name "V" _ [_]),obj1])
	= blowupTV tv name

type DV = ParseTree Cat Cat
intDV :: DV -> Idx -> Idx -> Idx -> Trans
intDV dv@(Branch (Cat _ "VP" _ _) [Leaf (Cat name "V" _ [_,_]),obj1,obj2])
	= blowupDV dv name

type AT = ParseTree Cat Cat
intAT :: AT -> Idx -> Idx -> Trans
intAT at@(Branch (Cat _ "AT" _ _)
	[Leaf (Cat att "VP" _ _), Leaf (Cat "to" "TO" [ToInf] []),
       (Branch (Cat _ "VP" _ _) [Leaf (Cat act "VP" _ _),obj])]) = 
       blowupTV at (att++"_to_"++act)

--intINF :: INF -> Idx -> Trans
--intINF Laugh               = intVP Laughed
--intINF Cheer               = intVP Cheered
--intINF Shudder             = intVP Shuddered 
--intINF (INF1 tinf np)      = \ s -> intNP np  (\ o -> 
--                                    intTINF tinf s o)
--intINF (INF2 dinf np1 np2) = \ s -> intNP np1 (\ io -> 
--                                    intNP np2 (\ o  -> 
--                                    intDINF dinf s io o))
--
--intTINF :: TINF -> Idx -> Idx -> Trans
--intTINF Love   = intTV Loved
--intTINF Admire = intTV Admired
--intTINF Help   = intTV Helped
--intTINF Defeat = intTV Defeated
--
--intDINF :: DINF -> Idx -> Idx -> Idx -> Trans
--intDINF Give   = intDV Gave

type CN = ParseTree Cat Cat
intCN :: CN -> Idx -> Trans
intCN (Leaf   (Cat name "CN" _ _))     = blowupPred name
intCN (Branch (Cat _    "RCN" _ _) [cn,rel]) = case rel of
    (Branch (Cat _ "MOD" _ _) [Leaf (Cat _ "REL"  _ _), Branch (Cat _ "S" _ _) [np,vp]])
	-> case ( phon (t2c np), catLabel (t2c vp) ) of
	    ("#",_) -> \i -> conj (intCN cn i) (intVP vp i)
    (Branch (Cat _ "MOD" _ _) [Branch (Cat _ "PP" _ _) [prep,np]])
    	-> case (phon (t2c prep)) of
	    "with" -> \owner -> (intNP np (\object-> conj (intCN cn owner) (blowupTV have "had" owner object))) 
	    "in" -> intCN cn
	    where have =  Leaf (Cat "have" "V" [] [])
intCN (Branch (Cat _ "RCN" _ _) [cn,ofpos,np]) =
    \object -> (intNP np (\owner -> conj (intCN cn object)
					(blowupTV have "had" owner object)))
	    where have =  Leaf (Cat "have" "V" [] [])

unique :: Idx -> Trans -> Trans
unique i phi c b = 
 if b == singleton xs then [c] else [] 
   where xs = [ x | x <- entities, success (extend c x) phi ]

type DET = ParseTree Cat Cat
intDET :: DET -> (Idx -> Trans) 
              -> (Idx -> Trans) -> Trans
intDET (Leaf (Cat "some" "DET" _ _))	= \ phi psi c -> let i = size c in 
                (exists `conj` (phi i) `conj` (psi i)) c
intDET (Leaf (Cat "a" "DET" _ _))	= \ phi psi c -> let i = size c in 
                (exists `conj` (phi i) `conj` (psi i)) c
intDET (Leaf (Cat "zero" "DET" _ _))	= \ phi psi c -> let i = size c in 
                (exists `conj` (phi i) `conj` (psi i)) c
intDET (Leaf (Cat "every" "DET" _ _))	= \ phi psi c -> let i = size c in 
               (impl (exists `conj` (phi i)) 
                      (psi i)) c
intDET (Leaf (Cat "no" "DET" _ _))    = \ phi psi c -> let i = size c in 
               (impl (exists `conj` (phi i)) 
                      (neg (psi i))) c
intDET (Leaf (Cat "the" "DET" _ _)) = \ phi psi c -> let i = size c in 
               (conj (unique i (phi i)) 
                       exists `conj` (phi i) 
                               `conj` (psi i)) c

convert :: [Entity] -> Context
convert c = (convert' c (length c - 1),[]) 
       where convert' []     i = []
             convert' (x:xs) i = (i,x):(convert' xs (i-1))

eval :: Maybe Sent -> Prop
eval (Just s) = intS s (convert context) True

evalTAG :: Maybe TagQ -> Prop
evalTAG (Just t) = intTAG t (convert context) True

evalFresh :: Maybe Sent -> Prop
evalFresh (Just s) = intS s ([],[]) True

handler core tests = putStr $ unlines $ map (\(x,y) -> x++show y) $ zip (map (++"\t") tests ) ( map (\string -> map (\x -> core ( Just x) ) (parses string)) tests )
-- evals = handler eval

-- vim: set ts=8 sts=4 sw=4 noet:
