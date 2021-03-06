module Tests where

import LogicalForm
import Parsing

dave	= [
	"Dave was a student in Minghsin University."
	, "Dave was 21."
	, "Dave's mother was nice."
	, "Dave had a father."
	, "Did Dave have a father."
	, "Dave's father was good."
	, "Dave was busy."
	, "Dave had a brother."
	, "Dave had a brother who was a student."
	, "Dave liked making friends."
	]

shane	= [
	"Shane was 21."
	, "Shane lived in Hukou."
	, "Shane worked in Gemitek."
	, "Shane had a father."
	, "Shane liked basketball."
	, "Shane liked singing."
	, "Shane liked Jeremy Lin."
	, "Shane was Christian"
	, "Shane was a Christian"
	, "Jeremy Lin was Christian"
	, "Jeremy Lin was a Christian"
	, "Shane liked singing."
	, "Shane liked Hsiao Ching-teng."
	]

neil	= [
	"Neil was 27"
	, "Neil was born in Nantou"
	, "Neil was a student in Minghsin University."
	, "Neil was a non-commissioned officer."
	, "Neil had sisters."
	, "Neil liked jogging."
	, "Neil liked swimming."
	, "Neil was in the military"
	, "Neil was a non-commissioned officer in the military."
	]

kelly	= [
	"Kelly was born in Hsinchu."
	, "Kelly had a sister."
	, "Kelly was a student in Minghsin University."
	, "Kelly worked in Lextar."
	, "Kelly liked Japanese."
	, "Kelly liked watching TV."
	, "Kelly liked playing the piano."
	, "Kelly was a dietitian."
	, "Kelly wanted to work as a dietitian."
	]

mindy	= [
	"Mindy was born in Hsinchu."
	, "Mindy was reserved."
	, "Mindy had a mother."
	, "Mindy studied in Minghsin University."
	, "Mindy liked Japanese."
	, "Mindy liked listening to music."
	, "Mindy liked pizza."
	, "Mindy liked going to the movies."
	, "Mindy wanted to work as a Japanese interpreter."
	, "Mindy liked the song, Memory."
	, "Mindy liked the TV program, Discovery."
	]
yn_tests = cindy ++ studies ++ jeff ++ residents ++ likes ++ work ++ birth

tag = [
	"Kelly had, didn't she?"
	, "Kelly had sisters, didn't she?"
	, "Mindy had sisters, didn't she?"
	, "Mindy did have sisters, didn't she?"
	, "Mindy didn't have sisters, did she?"
	-- , "Did Mindy have sisters?"
	-- , "Did Kelly like playing the piano?"
	-- , "Did Shane live in Hsinchu?"
	, "Kelly liked playing_the_piano, didn't she?"
	, "Mindy liked playing_the_piano, didn't she?"
	, "Neil liked jogging, didn't he?"
	, "Dave liked cats, didn't she?"
	, "Neil lived in Hsinchu, didn't he?"
	, "Shane lived in Hsinchu, didn't he?"
	, "Shane lived in Hukou, didn't he?"
	, "Neil was a design_assistant, wasn't he?"
	, "Mi Mi was Dave's cat, wasn't it?"
	, "Shane 's father was a truck_driver, wasn't he?"
	, "Dave's father was a truck_driver, wasn't he?"
	, "Shane was born in Hukou, wasn't he?"
	, "Shane 's mother was a career_woman, wasn't she?"
	, "Shane 's grandmother was a farmer, wasn't she?"
	, "Neil was born in Nantou, wasn't she?"
	, "Mindy was born in Nantou, wasn't she?"
	, "Neil was born in Hukou, wasn't he?"
	, "Kelly was born in Hukou, wasn't she?"
	, "Shane was born in Nantou, wasn't he?"
	, "Was Shane born in Nantou, wasn't he?"
	, "Shane was born in Nantou, wasn't Shane?"
	, "Shane was born in Nantou, wasn't she?"
	, "Shane was born in 1994, wasn't he?"
	]

hobbies_wh = [
	"What was Alex's hobby?"
	, "Whose hobby was drawing?"
	]

hobbies_yn = [
	"Was Rena's hobby listening to music?"
	, "Did Rena have a hobby?"
	]

vicky = [
	"Vicky's mother was a babysitter."
	,"Vicky's mother was a teacher."
	-- ,"Vicky's mother taught children."
	, "Vicky had some sisters."
	, "Vicky's sisters were students."
	, "Vicky liked shopping."
	-- , "Vicky had some hobbies."
	-- , "Vicky's hobby was exercising."
	, "Vicky liked reading."
	, "Vicky went out with friends on weekends."
	, "Vicky worked at a drug_store."
	]

cindy = [
	"Cindy was born in Jiayi."
	, "Cindy had a mother."
	, "Cindy liked playing the piano."
	, "Cindy liked listening to music."
	, "Cindy was 24."
	]

jeff	= [
	"Jeff liked basketball."
	, "Jeff had a father."
	, "Jeff's mother was a career woman."
	, "Jeff's brothers and sisters were students."
	, "Jeff's brothers and sisters were students in Minghsin University."
	]

residents	= [
	"Rena lived in Hsinchu."
	, "Alex lived in Hsinchu."
	, "Shane lived in Hukou."
	]

likes	= [
	"Rena liked America."
	, "Rena liked cats."
	, "Rena liked Hello Kitty."
	, "Did Rena like the color pink."
	, "Did Jeff like the color pink."
	]

work	= [
	"Rena worked in America."
	, "Rena wanted to work in America."
	, "Rena wanted to work in Hsinchu."
	, "Did Rena work in America."
	, "Did Rena want to work in America."
	, "Rena did want to work in America."
	, "Alex was a design assistant."
	]

birth	= [
	"Mindy was born in Hsinchu."
	, "Neil wasn't born in Hsinchu."
	, "Was Mindy born in Hsinchu?"
	, "Wasn't Neil born in Hsinchu?"
	-- , "Was Jeff born in 1963?"
	-- , "Jeff was born in 1963."
	-- , "Jeff was born in Taiwan in 1963."
	, "Kelly born in Hsinchu."
	, "Did Neil born in Hsinchu?"
	, "Neil didn't born in Hsinchu."
	, "Mindy was born in Taiwan"
	]

birth_wh	= [
	"Where was Mindy born?"
	, "Who was born in Hsinchu?"
	, "Who wasn't born in Hsinchu?"
	]

birth_tag	= [
	"Mindy was born in Hsinchu, wasn't she?"
	, "Neil was born in Hsinchu, wasn't he?"
	, "Neil wasn't born in Hsinchu, was he?"
	, "Neil was born in America, wasn't he?"
	-- , "Neil wasn't born in Hsinchu, was Neil?"
	-- "Neil was born in Hsinchu in 1963, wasn't he?"
	]

passive_whs	= birth_wh ++ studies_wh

passive_parse	=  map ( birth_wh !! ) [0,2] ++ map ( birth !! ) [1,2] ++ map ( birth_tag !! ) [0,2]
	
-- passive_trans	=  (handler transWH $ map ( birth_wh !! ) [0,2]) ++ (handler transTXT $ map ( birth !! ) [1,2]) ++ (handler transTAG $ map ( birth_tag !! ) [0,2])
	
haves =	[
	"Did Dave have a farmer?"
	, "Did Dave have a basketball?"
	, "Did Dave have a mother in Hsinchu?"
	, "Did Dave have a mother in Nantou?"
	, "Did Shane have a mother in Nantou?"
	, "Did Shane have a sister in Nantou?"
	, "Did Shane have a sister in Hsinchu?"
	, "Dave had a mother?"
	, "Some students had a mother?"
	, "Was a sister who Dave had a student?"
	, "Was Dave's sister a student?"
	, "Did Shane have a sister who was a student?"
	, "Did Shane have a sister?"
	]
have_whs = [
	"Who had a mother in Hsinchu?"
	, "Who had a mother in Nantou?"
	, "Who had a sister?"
	-- , "Who had a job?"
	]

studies_wh	= [
	"What did Neil study?"
	, "When did Neil study Applied Foreign Languages?"
	, "When was Applied Foreign Languages studied?"
	, "Where did Neil study Applied Foreign Languages?"
	, "Who was Applied Foreign Languages studied by?"
	]

studies	= [
	"Alex studied English in Minghsin University."
	, "Jeff studied in Minghsin University Applied Foreign Languages."
	-- , "Jeff's siblings studied in Minghsin University."
	, "Rena studied English."
	, "Rena studied Applied Foreign Languages."
	, "Was Applied Foreign Languages studied in 1994?"
	, "Applied Foreign Languages studied in 1994."
	, "Jeff studied Applied Foreign Languages in 1994."
	, "Jeff studied Applied Foreign Languages."
	, "Applied Foreign Languages was studied by Jeff in 1994."
	, "Applied Foreign Languages was studied in Jeff by 1994."
	, "Applied Foreign Languages was studied in 1994 by Jeff."
	, "Applied Foreign Languages wasn't studied in 1994 by Jeff."
	, "Wasn't Applied Foreign Languages studied in 1994 by Jeff?"
	]

comp_wh = [
	"Whose grandmother was a farmer?"
	, "Who was a student of Minghsin University"
	, "Who was a student of Minghsin University"
	, "Who was a woman who was born in Hsinchu?" -- long
	, "Who was the woman who was born in Hsinchu?" -- excessively long
	]

comp_tests = [
	"Dr Bean was a teacher."
	, "Was Shane a teacher?"
	, "Was Shane a student?"
	, "Was Shane a student in Minghsin University?"
	, "Was Shane a student of Minghsin University?"
	, "Was Shane the student in Minghsin University?"
	, "Dr Bean was an teacher."
	, "Dr Bean was in Hsinchu."
	, "Dr Bean was a teacher in Hsinchu."
	, "Dr Bean was a person."
	, "Dr Bean wasn't an person."
	, "Shane wasn't a person."
	, "Wasn't Dr Bean a person?"
	, "Wasn't Shane a person?"
	, "Wasn't Minghsin University a person?"
	, "Wasn't Mindy a teacher"
	]

relatives = [
	"Who was a man who was a teacher?"
	, "Who was the man who was a teacher?"
	, "Who was a man who was a student?"
	, "Who was the man who was a student?"
	]
