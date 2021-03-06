module Model where 

import Data.Tuple
import Data.List
import Data.Maybe

data Entity	= A | B | C | D | E | F | G 
            | H | I | J | K | L | M | N 
            | O | P | Q | R | S | T | U 
            | V | W | X | Y | Z 
            | AA | BB | CC | DD | EE | FF | GG 
            | HH | II | JJ | KK | LL | MM | NN 
            | OO | PP | QQ | RR | SS | TT | UU 
            | VV | WW | XX | YY | ZZ | Someone | Something | Unspec
     deriving (Eq,Show,Bounded,Enum,Ord)

entities :: [Entity]
entities	=  [minBound..maxBound] 


--alice, rex, kelley, judy, rock
--                                                :: Entity

characters :: [ (String, Entity) ]

characters = [
	( "a",	A ),
	( "b",	B ),
	( "c",	C ),
	( "d",	D ),
	( "a-ho",	H ),
	( "ellen",	E ),
	( "dr_bean",	T ),
	( "steve",	S ),
	( "european_campers",	M ),
	( "carrefour",	F ),
	( "charles",	J ),
	( "jacques",	Q ),
	( "olivier",	V ),
	( "todd",	O ),
	( "alan",	L ),
	( "david",	I ),
	( "dot",	P ),
	( "tan",	N ),
	( "cusp",	K ),
	( "slow_living",	G )

	]


adventurer	= pred1 [S,E]
teacher	= pred1 [T]
psychologist	= pred1 [A,D,T]
doctor	= pred1 [D]
office_worker	= pred1 [A,B,C,D]
ceo	= pred1 [J]
production_manager	= pred1 [Q]
salesman	= pred1 [V]
sales_manager	= pred1 [O]
customer	= pred1 [F]

order	= pred1 [Unspec]
goods	= pred1 [Unspec]
company	= pred1 [M,F,Unspec]
framework	= pred1 [K]

angry	= pred1 [Q,V]
useful	= pred1 [K]

lack_of_control	= [CC]
uncertainty	= [UU]
lack_of_support	= [SS]
pressure	= pred1 [PP]
stress	= pred1 [SS]

large	= order
brilliant	= salesman
rude	= brilliant
best	= rude

namelist = map fst characters


male, female :: OnePlacePred

male	= pred1 [S,Q,V,C,O,L,I]
female	= pred1 [E,P,N]

type OnePlacePred	= Entity -> Bool
type TwoPlacePred	= Entity -> Entity -> Bool
type ThreePlacePred	= Entity -> Entity -> Entity -> Bool

list2OnePlacePred :: [Entity] -> OnePlacePred
list2OnePlacePred xs	= \ x -> elem x xs

pred1 :: [Entity] -> OnePlacePred
pred1	= flip elem

people, things :: OnePlacePred

people	= \ x -> (male x || female x || x == Unspec)
things	= \ x -> (x == Unspec || not ( people x ) )

pred2 :: [(Entity,Entity)] -> TwoPlacePred
pred3 :: [(Entity,Entity,Entity)] -> ThreePlacePred
pred2 xs	= curry ( `elem` xs )
pred3 xs	= curry3 ( `elem` xs )
pred4 xs	= curry4 ( `elem` xs )

--(parent,child)
conflict	= [(Q,V),(Q,O),(O,V)]
supervision	= [(J,Q),(J,O),(O,V)]
isBoss	= pred1 $ map fst supervision
isWorker	= pred1 $ map snd supervision

-- stressful :: [(Entity, Entity)] -> Bool
-- stressful = \ x -> ( x `elem` [control, uncertainty, support, pressure] &&
-- 			( not $ null x ) )

-- control	= [(Unspec,Unspec)]
-- uncertainty	= [(Unspec,Unspec)]
-- support	= [(Unspec,E)]
--(pressurizer,pressured)
hotspots	= [(V,Q),(Q,O),(O,V),(V,O)]

possessions	= [(V,Unspec),(J,M),(D,M),(T,M)]
recruitment	= [(Unspec,Unspec,Unspec)]
appreciation	= []

supervisor	= pred1 $ map fst supervision
boss	= supervisor
subordinate	= pred1 $ map snd supervision
employee	= subordinate
manager = boss

looking	= []
have	= pred2 $ possessions ++ supervision
		++ ( map swap $ supervision )
		++ ( map (\x->(recipient x, theme x) ) giving )
		++ ( map (\x->(agent x,J) ) working )
		++ ( map (\x->(agent x, patient x) ) recruitment )
		++ ( map (\x->(agent x, location x) ) recruitment )
knowledge	= []
acquaintances	= []
know	= pred2 $ knowledge ++ acquaintances ++ map swap acquaintances
appreciate	= pred2 appreciation
-- visit	= pred2 $ map (\x -> (patient x, recipient x) ) recruitment
interview	= pred2 $ map (\x -> (agent x, patient x) ) recruitment
-- greet	= interview
look_at	= pred2 $ looking
help	= pred2 $ supervision

curry3 :: ((a,b,c) -> d) -> a -> b -> c -> d
curry3 f x y z	= f (x,y,z)
curry4 f x y z w	= f (x,y,z,w)

agent, theme, recipient, location, instrument ::
	(Entity,Entity,Entity) -> Entity
agent (a,_,_) = a
theme (_,t,_) = t
recipient (_,_,r) = r
patient = theme
location = recipient
instrument = recipient
origin	= theme
destination = recipient

--(worker,job,site)
working	= []
volunteering = []
comms	= [ (P,Unspec,R) ]
offenses	= []
giving	= []
acceptances = []
-- (seller, item, buyer)
selling	= []
--(killer,killed,instrument)
--(putter,theme,location)
--(agent,theme,location)
looking_back	= [(Q,Unspec,Unspec)]

worker	= pred1 $ map agent working
work_where	= pred2 $ map (\x -> (agent x, location x) ) working
work_as = pred2 $ map (\x -> (agent x, theme x) ) working
volunteer_at	= pred2 $ map (\x -> (agent x, location x) ) volunteering
look_back	= pred1 $ map agent looking_back
look_back_on	= pred2 $ map (\x->(agent x, theme x) ) looking_back
said	= pred2 $ map (\x->(agent x, theme x) ) comms
asked	= pred2 $ map (\x->(agent x, recipient x) ) comms
ask_about = pred3 $ map (\x->(agent x, recipient x, theme x) ) comms
talked	= pred2 $ map (\x->(agent x, recipient x) ) comms
              ++  map (\(agent,theme,recipient)->(recipient, agent) ) comms
talk_about = pred3 $ map (\x->(agent x, recipient x, theme x) ) comms
offend_with	= pred3 offenses
offend	= pred2 $ ( map (\x -> (agent x, recipient x) ) offenses ) ++
		( map (\x -> (theme x, recipient x) ) offenses )
anger = offend

pressurize = pred2 hotspots
gave	= pred3 giving
got	= pred3 $ map (\x -> (recipient x, patient x, agent x) ) giving
sold	= pred2 $ map (\x -> (agent x, theme x) ) selling

told	= pred3 comms

recite = pred2 $ map ( \x -> (agent x, theme x) ) comms

agent4, theme4, recipient4, location4 :: (Entity,Entity,Entity,Entity) -> Entity
agent4 (a,_,_,_) = a
location4 (_,l,_,_) = l
theme4 (_,_,t,_) = t
recipient4 (_,_,_,r) = r

-- (teacher,school(location),subject,student)
schooling = [(Unspec,Unspec,V,D)]
studied = pred3 $ map ( \x -> (recipient4 x, theme4 x, location4 x) )
				schooling
studied_what = pred2 $ map (\x -> (recipient4 x, theme4 x) ) schooling
studied_where = pred2 $ map (\x -> (recipient4 x, location4 x) ) schooling
teach = pred3 $ map (\x -> (agent4 x, theme4 x, recipient4 x) ) schooling
teach_what = forgetful teach
teach_who = pred2 $ map (\x -> (agent4 x, recipient4 x) ) schooling
student = pred1 $ map recipient4 schooling

forgetful :: ThreePlacePred -> TwoPlacePred
forgetful r u v = or ( map ( r u v ) entities )
passivize :: TwoPlacePred -> OnePlacePred
passivize r	= \ x -> or ( map ( flip  r x ) entities )

passivize3 :: ThreePlacePred -> TwoPlacePred
passivize3 r	= \x y -> or ( map ( \u -> r u x y ) entities )

passivize4 r = \x y z -> or ( map (\u -> r u x y z ) entities )

self ::  (a -> a -> b) -> a -> b
self p	= \ x -> p x x 
