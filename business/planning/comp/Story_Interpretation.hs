module Story_Interpretation where 

import Model

objects :: [(String, [Entity] -> Bool)]
objects = [
	( "good_idea",	\[x] -> predid1 "good_idea" x	)
	, ( "teacher",	\[x]	-> predid1 "teacher" x )
	, ( "student",	\[x]	-> predid1 "student" x	)
	, ( "group",	\[x]	-> predid1 "group" x	)
	, ( "member",	\[x]	-> predid1 "member" x	)
	, ( "loser",	\[x]	-> predid1 "loser" x	)
	, ( "winner",	\[x]	-> predid1 "winner" x	)


	, ( "board",	\[x]	-> predid1 "board" x	)
	, ( "english",	\[x]	-> predid1 "english" x	)
	, ( "question",	\[x]	-> predid1 "question" x	)
	, ( "answer",	\[x]	-> predid1 "answer" x	)

	, ( "activity",	\[x]	-> predid1 "activity" x	)
	, ( "compcomp_activity",	\[x]	-> predid1 "compcomp_activity" x	)
	, ( "ingredients_for_success",	\[x]	-> predid1 "ingredients_for_success" x	)
	, ( "framework",	\[x]	-> predid1 "framework" x	)

	, ( "clear_and_simple_idea",	\[x]	-> predid1 "clear_and_simple_idea" x	)
	, ( "autonomy",	\[x]	-> predid1 "autonomy" x	)
	, ( "ownership",	\[x]	-> predid1 "ownership" x	)
	, ( "innovation",	\[x]	-> predid1 "innovation" x	)
	
	, ( "innovative",	\[x]	-> predid1 "innovative" x	)
	

	]

inflections :: [(String, String)]
inflections = [
	( "offer_to_ask",	"offered_to_ask" )
	, ( "went",	"go" )
	, ( "liked",	"like" )
	, ( "asked",	"ask" )
	, ( "talk",      "talked" )
	, ( "want_to_answer",	"wanted_to_answer" )
	, ( "sold",	"sell" )
	, ( "want_to_sell",	"wanted_to_sell" )
	, ( "want_to_ask",	"wanted_to_ask" )
	, ( "want_to_talk",	"wanted_to_talk" )
	, ( "want_to_look",	"wanted_to_look" )
	, ( "want_to_have",	"wanted_to_have" )
	, ( "answered",	"answer" )
	, ("students",	"student" )
	, ("groups",	"group") 
	, ("members",	"member" )
	, ("losers",	"loser" )
	, ("winners",	"winner" )
	, ("activities",	"activity" )

	, ("questions",	"question") 
	, ("answers",	"answer" )
	, ("ingredient_for_success",	"ingredients_for_success" )
	, ("clear_and_simple_ideas",	"clear_and_simple_idea" )





 ]

relations :: [(String, [Entity] -> Bool)]
relations = [
	( "useful",	\[x]	-> predid1 "useful" x )
	, ( "old",	\[x]	-> predid1 "old" x	)
	, ( "true",	\[x] -> predid1 "true" x	)
	, ( "false",	\[x] -> predid1 "false" x	)
	, ( "good",	\[x] -> predid1 "good" x	)
	, ( "successful",	\[x] -> predid1 "successful" x	)
	, ( "unsuccessful",	\[x] -> predid1 "unsuccessful" x	)
	, ( "go",	\[x,y]	-> predid2 "go" y x	)
	, ( "like",	\[x,y]	-> predid2 "like" y x	)
	, ( "finish",	\[x,y,z] -> predid3 "finish" z y x	)
	, ( "answer",	\args -> case args of
		[x,y,z,w] -> predid4 "answer" w z y x
		[x,y,z] -> (forgetful4 . predid4) "answer" z y x
		[x,y] -> (forgetful3 . forgetful4 . predid4) "answer" y x
		[x] -> (forgetful2 . forgetful3 . forgetful4 . predid4) "answer" x )
	, ( "have_to_answer",	\args -> case args of
		[x,y,z] -> predid3 "have_to_answer" z y x )

	, ( "ask", \args -> case args of 
		[x,y,z,w] -> predid4 "ask" w z y x
		[x,y,z] -> (forgetful4 . predid4) "ask" z y x
		[x,y] -> (forgetful3 .forgetful4 . predid4) "ask" y x
		[x] -> (forgetful2 . forgetful3 . forgetful4 . predid4) "ask" x )
	, ( "have_to_ask",	\args -> case args of
		[x,y,z,w] -> predid4 "have_to_ask" w z y x
		[x,y,z] -> (forgetful4 . predid4) "have_to_ask" z y x )
	, ( "like_to_ask",	\args -> case args of
		[x,y,z] -> predid3 "like_to_ask" z y x )

	, ( "wanted_to_answer", \args -> case args of 
		[x] -> (forgetful2 . forgetful3 . forgetful4 . predid4) "wanted_to_answer" x
		[x,y] -> (forgetful3 . forgetful4 . predid4) "wanted_to_answer" y x
		[x,y,z] -> (forgetful4 . predid4) "wanted_to_answer" z y x
		[x,y,z,w] -> predid4 "wanted_to_answer" w z y x )

	, ( "sell", \args -> case args of 
		[x,y] -> (forgetful3 . forgetful4 . predid4) "sell" y x
		[x,y,z] -> (forgetful4 . predid4) "sell" z y x
		[x,y,z,w] -> predid4 "sell" w z y x )
	, ( "help", \args -> case args of 
		[x,y] -> predid2 "help" y x )
	, ( "wanted_to_help", \args -> case args of 
		[x,y,z] -> predid3 "wanted_to_help" z y x )
	, ( "make", \args -> case args of 
		[x,y] -> (forgetful3 . predid3) "make" y x
		[x,y,z] -> predid3 "make" z y x )
	, ( "wanted_to_make", \args -> case args of 
		[x,y,z,w] -> predid4 "wanted_to_make" w z y x
		[x,y,z] -> (forgetful4 . predid4) "wanted_to_make" z y x)
	, ( "wanted_to_ask", \args -> case args of 
		[x] -> (forgetful2 . forgetful3 . forgetful4 . predid4) "wanted_to_ask" x
		[x,y] -> (forgetful3 . forgetful4 . predid4) "wanted_to_ask" y x
		[x,y,z] -> (forgetful4 . predid4) "wanted_to_ask" z y x
		[x,y,z,w] -> predid4 "wanted_to_ask" w z y x )
	, ( "wanted_to_talk", \args -> case args of 
		[x] -> (forgetful2 . forgetful3 . forgetful4 . predid4) "wanted_to_talk" x
		[x,y] -> (forgetful3 . forgetful4 . predid4) "wanted_to_talk" y x
		[x,y,z] -> (forgetful4 . predid4) "wanted_to_talk" z y x
		[x,y,z,w] -> predid4 "wanted_to_talk" w z y x )
	, ( "talked", \args -> case args of
		[x,y,z] -> predid3 "talk_with_about" z y x
		[x,y]    -> (forgetful3 . predid3) "talk_with_about" y x)

	]

