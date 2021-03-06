module Story_Cats where

import Parsing

names, nouns, verbs, aux, adjs, advs :: Lexset

names = [
	[Cat "pepsi" "NP" [Thrd,Neutr,Sg] []]
	, [Cat "punjabi_farmers" "NP" [Thrd,MascOrFem,Pl] []]
	, [Cat "the_punjabi_government"	"NP" [Thrd,Neutr,Sg] []]
	]

nouns = [
	 [Cat "oranges"	"CN" [Thrd,Neutr,Pl] []]
	 , [Cat "citrus_fruit"	"CN" [Thrd,Neutr,Pl] []]
	 , [Cat "land"	"NP" [Thrd,Neutr,Sg] [],
	 	Cat "land"	"CN" [Thrd,Neutr,Sg] []]
	 , [Cat "experiment"	"CN" [Thrd,Neutr,Sg] []]
	 , [Cat "good_idea"	"CN" [Thrd,Neutr,Sg] []]
	 , [Cat "a_good_price"	"NP" [Thrd,Neutr,Sg] []]
	]

verbs = [
	[Cat "helped"	"VP" [Tense] [],
		Cat "helped"	"VP" [Tense] [Cat "_" "NP" [AccOrDat] []]],
	[Cat "help"	"VP" [Infl] [],
		Cat "help"	"VP" [Infl] [Cat "_" "NP" [AccOrDat] []]],
	[Cat "grew"	"VP" [Tense] [Cat "_" "NP" [AccOrDat] []]],
	[Cat "grow"	"VP" [Infl] [Cat "_" "NP" [AccOrDat] []]],
	[Cat "bought"	"VP" [Tense] [],
		Cat "bought"	"VP" [Tense] [Cat "_" "NP" [AccOrDat] []],
		Cat "bought"	"VP" [Tense] [Cat "_" "PP" [From] []],
		Cat "bought"	"VP" [Tense] [Cat "_" "NP" [AccOrDat] [],
						Cat "_" "PP" [From] []]],
	[Cat "buy"	"VP" [Infl] [],
		Cat "buy"	"VP" [Infl] [Cat "_" "NP" [AccOrDat] []],
		Cat "buy"	"VP" [Infl] [ Cat "_" "PP" [From] []],
		Cat "buy"	"VP" [Infl] [Cat "_" "NP" [AccOrDat] [],
						Cat "_" "PP" [From] []]],
	[Cat "sold"	"VP" [Tense] [Cat "_" "NP" [AccOrDat] []],
		Cat "sold"	"VP" [Tense] [Cat "_" "NP" [AccOrDat] [],
						Cat "_" "PP" [To] []]],
	[Cat "sell"	"VP" [Infl] [Cat "_" "NP" [AccOrDat] []],
		Cat "sell"	"VP" [Infl] [Cat "_" "NP" [AccOrDat] [],
						Cat "_" "PP" [To] []]],
	[Cat "paid"	"VP" [Tense] [],
		Cat "paid"	"VP" [Tense] [Cat "_" "NP" [AccOrDat] []],
		Cat "paid" "VP" [Tense]  [Cat "_" "NP" [AccOrDat] [],
                                                Cat "_" "NP" [AccOrDat] []],
		Cat "paid" "VP" [Tense]  [Cat "_" "NP" [AccOrDat] [],
                                                Cat "_" "PP" [For] []],
		Cat "paid" "VP" [Tense]  [Cat "_" "NP" [AccOrDat] [],
                                                Cat "_" "NP" [AccOrDat] [],
                                                Cat "_" "PP" [For] []]],
	[Cat "pay"	"VP" [Infl] [],
		Cat "pay"	"VP" [Infl] [Cat "_" "NP" [AccOrDat] []],
		Cat "pay" "VP" [Infl]  [Cat "_" "NP" [AccOrDat] [],
                                                Cat "_" "NP" [AccOrDat] []],
		Cat "pay" "VP" [Infl]  [Cat "_" "NP" [AccOrDat] [],
                                                Cat "_" "PP" [For] []],
		Cat "pay" "VP" [Infl]  [Cat "_" "NP" [AccOrDat] [],
                                                Cat "_" "NP" [AccOrDat] [],
                                                Cat "_" "PP" [For] []]]

	]

aux = [
	]

adjs = [
	[Cat "successful"	"ADJ" [] []]
	, [Cat "unsuccessful"	"ADJ" [] []]
	]

advs = [
	-- [Cat "slowly"	"ADV" [] []]
	]
