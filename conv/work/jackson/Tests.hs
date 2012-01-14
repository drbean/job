module Tests where

import LogicalForm
import Parsing

test_text = [
	"Queen's daughter spoke English.",
	-- "Queen's daughter's brother spoke English.",
	"Queen's daughter had a brother and a brother spoke English.",
	"Queen's daughter knew English and a supervisor spoke English.",
	"Queen's daughter spoke English but a supervisor didn't speak English.",
	"Queen talked to a supervisor and a supervisor talked to Queen's daughter.",
	"Queen talked to a supervisor and a supervisor talked to Debra \
	\and Debra talked to Queen.",
	"Queen looked back on her daughter's upbringing. \
	\Queen talked to a supervisor. \
	\Queen's daughter asked a supervisor about the Dominican Republic."
	]

comp_test = [
	"Queen was older.",
	"Queen was homeless.",
	"Queen was a mother.",
	"Queen was Jennifer's mother.",
	"Queen was a homeless woman.",
	"Queen was a man.",
	"Queen was a woman.",
	"Queen was a visitor.",
	"A man was a visitor.",
	"A woman was a visitor.",
	"The woman was a visitor.",
	"A homeless woman was Queen.",
	"The homeless woman was Queen.",
	"Jennifer was the black woman's mother.",
	"Jennifer was the black woman's daughter.",
	"Jennifer was a black woman's daughter.",
	"Jennifer was a homeless woman's daughter.",
	"Jennifer was a homeless woman's supervisor.",
	"Tanya was the homeless women's supervisor.",
	"Debra was the homeless women's supervisor.",
	"Debra was a homeless woman's supervisor.",
	"Debra was the black woman's supervisor.",
	"Debra was a black woman's supervisor.",
	"Debra was Queen's supervisor.",
	"Tanya was Queen's supervisor.",
	"Tanya was Ann's supervisor.",
	"Jennifer was Queen's daughter.",
	"Jennifer was Debra's daughter.",
	"Queen was Debra's daughter.",
	"Queen was Debra's mother.",
	"Queen was Jennifer's mother"
	]

test_possessives = [
	"Jennifer's mother looked back.",
	"Queen's supervisor talked to the daughter.",
	"Queen's daughter got Jennifer's birthday card.",
	"Did Jennifer's mother give a birthday card to the black woman's daughter?",
	"Did Jennifer's mother give a birthday card to a black woman's daughter?",
	"Did Debra talk to Jennifer?",
	"The daughter of Queen talked to Debra.",
	"Did the supervisor of Queen talk to Jennifer?",
	"Did a supervisor of Queen talk to Jennifer?",
	"Did the supervisor of a black woman talk to Queen's daughter?",
	"Did the supervisor of the black woman have money?",
	"Did a supervisor of a homeless woman have money?",
	"Did the supervisors of the homeless women have money?",
	"Did the mother of Jennifer have money?",
	"Did the daughter of Queen have money?",
	"Did the daughter of the black woman have money?",
	"Did the daughter of Queen talk to Debra?"
	]
haves = [
	-- "The lotion had a beautiful smell",
	"Did Queen have Jennifer's father?",
	"Did Queen have a husband?",
	"Did Queen have a mother?",
	"Did Queen have a daughter?",
	"Did Queen's father have a mother?",
	"Did Debra have a job?",
	"Did Debra have some job?",
	"Did Debra have money?",
	"Did Queen's father have money?",
	"Did Debra have money?",
	"Did Ann have a parent?",
	"Did Ann have some parents?",
	"Did Ann have parents?",
	"Did Ann's father have a parent?",
	"Did Ann's father have some parents?",
	"Did Ann's father have parents?",
	"Did Ann have work?",
	"Did Debra work?",
	"Did Debra have work?",
	"Did Debra have a job?",
	"Did Queen have work?",
	"Did Queen have a job?",
	"Did Queen's father have work?",
	"Did a supervisor have a job?",
	"Did a supervisor have a woman's job?",
	"Did a supervisor have Queen's job?",
	"Did a supervisor have a mother?",
	"Did a supervisor have a daughter?",
	-- "Did a job have a salary?",
	"Did a homeless woman have money?",
	"Did a homeless woman have some money?",
	"Did a homeless woman's daughter have some money?",
	"Did a homeless woman's daughter have a birthday card?",
	"Did the daughter have some money?",
	"Did the daughter have no money?",
	"Debra's daughter had many jobs in the State of Colorado.",
	"Did the parent have some language?",
	"Did the parent have no language?",
	"Did the State of Colorado have money?",
	"Did the Gathering Place have money?",
	"Did the job have money?",
	"Did Queen's daughter have money?",
	"Did a supervisor have a parent?",
	"Did a supervisor have some parents?",
	"Did a supervisor have parents?",
	"Did the job have a parent?",
	"Did the job have some parents?",
	"Did the job have parents?",
	"Did a supervisor have a worker?",
	"Did Queen's daughter have a worker?",
	"Did the job have a worker?",
	"Did someone have a worker?"
	]

ungrammatical = [
	"Did Debra worked?",
	"Queen work?",
	"Man worked.",
	"Some man work.",
	"No worked.",
	"No-one work.",
	"Did Debra taught?",
	"Debra teach Queen.",
	"Queen taught.",
	"Did Queen's daughter looked back?",
	"A supervisor look back?",
	"Man looked back.",
	"Some man work.",
	"No looked back.",
	"No-one work.",
	"Did Queen's daughter taught?",
	"Queen's daughter teach a supervisor.",
	"A supervisor raised."
	]

intransitives = [
	"Debra worked",
	"Did Debra work?",
	"Queen's father worked.",
	"A woman's father worked.",
	"Did Queen's father work?",
	"Did a woman's father work?",
	"A man worked.",
	"Some man worked.",
	"No one worked.",
	"No-one worked.",
	"Everybody worked.",
	"Everyone worked.",
	"Many persons worked.",
	"No person worked.",
	"Did the man work?",
	"Did some man work?",
	"Did some men work?",
	"Did some woman work?",
	"Did some women work?",
	"Most women worked.",
	"Most women didn't work.",
	"Several women worked.",
	"Several women didn't work.",
	"Many women worked.",
	"Many women didn't work.",
	"All women worked.",
	"No woman worked.",
	"Most men worked.",
	"Most men didn't work.",
	"Several men worked.",
	"Several men didn't work.",
	"Many men worked.",
	"Many men didn't work.",
	"All men worked.",
	"No man worked.",
	"Did Queen work for the State of Colorado?",
	"Did Debra work for the State of Colorado?",
	"Did Debra work at a shelter?",
	"Did Queen's father work for the State of Colorado?",
	"Queen's daughter got married.",
	"Did Queen's daughter cry?",
	"Did the supervisor cry?",
	"Did Queen's father cry?",
	"A man cried.",
	"Some man cried.",
	"No one cried.",
	"No-one cried.",
	"Everybody cried.",
	"Everyone cried.",
	"Many persons cried.",
	"No person cried.",
	"Did the man cry?",
	"Did some man cry?",
	"Did some men cry?",
	"Did some woman cry?",
	"Did some women cry?",
	"Most persons cried.",
	"Most men cried.",
	"Most men didn't cry.",
	"Several men cried.",
	"Several men didn't cry.",
	"Several persons cried.",
	"Several persons didn't cry.",
	"Did Queen's daughter look back?",
	"Did a supervisor look back?",
	"Did Queen look back?",
	"A man looked back.",
	"Some man looked back.",
	"No one looked back.",
	"No-one looked back.",
	"Everybody looked back.",
	"Everyone looked back.",
	"Many persons looked back.",
	"No person looked back.",
	"Did the man look back?",
	"Did the girl look back?",
	"Did some man look back?",
	"Did some men look back?",
	"Did some woman look back?",
	"Did some women look back?",
	"Most men looked back.",
	"Most men didn't look back.",
	"Several men looked back.",
	"Several men didn't look back.",
	"Many men looked back.",
	"Many men didn't work.",
	"All men looked back.",
	"No man looked back."
	]

transitives = [
	"Did Debra study?",
	"Did Debra study IT?",
	"Debra studied information technology.",
	"Queen studied information technology.",
	"Queen studied information technology in the Dominican Republic.",
	"Queen studied information technology at Boston University",
	"Did Queen go to Boston University.",
	"Some woman went to Boston University.",
	"Some man went to Boston University.",
	"Some boy went to Boston University.",
	"Some man raised Queen.",
	"A man raised Debra",
	"Some woman told a story.",
	"Did a supervisor work in the Dominican Republic?",
	"Did a supervisor work in the company?",
	"A supervisor worked on the company.",
	"A supervisor worked at the company.",
	"Did a supervisor work at a shelter?",
	"A supervisor worked on a shelter.",
	"A supervisor worked in a shelter.",
	"A supervisor worked as a language.",
	"Did the job work at a shelter?",
	"The job worked on a shelter.",
	"The job worked in a shelter.",
	"Did the job disappoint a supervisor?",
	"Did Queen's daughter study information technology?",
	"Queen's daughter studied information technology.",
	"A supervisor studied information technology.",
	"Did a supervisor study in the United States?",
	"A supervisor studied information technology at a shelter.",
	"A supervisor studied information technology at school",
	"Did a supervisor go to school.",
	"Some woman went to school.",
	"Some man went to school.",
	"Some boy went to school.",
	"Some man raised a supervisor.",
	"A man raised Queen's daughter",
	"Some woman told a story.",
	"Did a supervisor come from the Dominican Republic?",
	"Did Queen immigrate?",
	"Did a supervisor immigrate to the United States?",
	"Did Queen go to the United States?",
	"Did Queen come from the Dominican Republic?",
	"Did Queen's daughter come to the United States?"
	]

ditransitive_tests = [
	"Queen told a story.",
	"Queen told Queen's father a story.",
	"Queen told a story to Queen's daughter.",
	"Queen told a story to Debra",
	"Queen gave some job to Debra.",
	"Did Queen give some job to Debra.",
	"Did Queen give the job to Debra?",
	"Did Queen give the job to someone?",
	"Queen gave several job to Debra.",
	"Did someone give something to Debra?",
	"A woman gave the job to Debra.",
	"A woman gave the job to someone.",
	"A woman gave something to someone.",
	"Someone gave something to someone.",
	"Queen gave Debra some job.",
	"Did Queen give Debra some job?",
	"Did Queen give Debra the job?",
	"Did Queen give someone the job?",
	"Queen gave Debra several job.",
	"Did someone give Debra something?",
	"A man gave Debra the job.",
	"A boy gave Debra the job.",
	"Tanya gave Debra the dress.",
	"A man gave someone the job.",
	"A man gave someone something.",
	"Someone gave someone something.",
	"A supervisor told a story.",
	"A supervisor told the job a story.",
	"A supervisor told a story to the job.",
	"A supervisor told a story to Queen's daughter",
	"A supervisor gave some language to Queen's son.",
	"Did a supervisor give some language to Queen's son.",
	"Did a supervisor give the language to Queen's daughter?",
	"Did a supervisor give the language to someone?",
	"A supervisor gave several language to Queen's son.",
	"Did someone give something to Queen's daughter?",
	"A woman gave the language to Queen's son.",
	"A woman gave the language to someone.",
	"A woman gave something to someone.",
	"Someone gave something to someone.",
	"A supervisor gave Queen's daughter some language.",
	"Did a supervisor give Queen's daughter some language?",
	"Did a supervisor give Queen's daughter the language?",
	"Did a supervisor give someone the language?",
	"A supervisor gave Queen's daughter several language.",
	"Did someone give Queen's daughter something?",
	"A man gave Queen's daughter the language.",
	"A man gave Queen's daughter some language.",
	"A boy gave Queen's daughter the language.",
	"The job gave Queen's daughter the worker.",
	"A man gave someone the language.",
	"A man gave someone something.",
	"Someone gave someone something.",
	"Did a supervisor work at a shelter?",
	"A supervisor did cleaning at a shelter.",
	"Did Queen's daughter spell names in the company?"
	]

wh_questions =[
	"Who worked?",
	"Who did Debra teach?",
	"Who taught Debra?",
	"Who gave the job to Debra?",
	"Who gave some job to Debra?",
	"Which person worked?",
	"Which person did Debra teach?",
	"Which subjects did Tanya teach?",
	"To whom did Queen give some job?",
	"Who did Queen give some job to?",
	"Who looked back?",
	"Which man looked back?",
	"Who raised Queen's daughter?",
	"Which woman raised Queen's daughter?",
	"Who gave the languages to Queen's daughter?",
	"Who gave some languages to Queen's daughter?",
	"Which person looked back?",
	"Which woman appreciated a supervisor?",
	"Which girl appreciated a supervisor?",
	"Which daughter appreciated a supervisor?",
	"Who did Queen's daughter appreciate?",
	"Which person did Queen's daughter appreciate?",
	"Which man did Queen's daughter appreciate?",
	"Which woman did Queen's daughter appreciate?",
	"Which thing did Queen's daughter appreciate?",
	"Which worker did Queen's daughter appreciate?",
	-- "To whom did a supervisor give some languages?",
	-- "Who did a supervisor give some languages to?",
	"Who had a worker?",
	"What did Queen's daughter have?",
	"Who did Queen's daughter have?",
	"Who did the job disappoint?",
	"Who did a supervisor's daughter appreciate?",
	"What did a supervisor's daughter appreciate?",
	"Which thing did a supervisor's daughter appreciate?",
	"Which man did a supervisor's daughter appreciate?",
	"Which woman did a supervisor's daughter appreciate?",
	"Which worker did a supervisor's daughter appreciate?",
	"What did someone have?"
	]

comp_questions = [
	"Who was homeless?",
	"Who was older?",
	"Who was a woman?",
	"Who were women?",
	"Who was the woman?",
	"Who was Tanya's supervisor?",
	"Who was Ann's supervisor?",
	"Who was Anne's supervisor?",
	"Who was Queen's supervisor?",
	"Who was the homeless woman that had a daughter?",
	"Who was Queen's daughter?",
	"Who was Queen's supervisor?",
	"Who was Queen's daughter?"
	]


relclauses = [
	"A woman who taught Debra worked.",
	"The woman who taught Debra worked.",
	"Did the woman who taught Debra work?",
	"Did every woman who taught Debra work?",
	"The woman who gave the job to Debra worked.",
	"Queen divorced the man that she gave the job to.",
	"Who killed the man that helped the woman " 
	 ++ "that had a boyfriend.",
	"A woman who raised Queen's daughter looked back.",
	"The woman who raised Queen's daughter looked back.",
	"Did the woman who raised Queen's daughter look back?",
	"Did every person who raised Queen's daughter look back?",
	"Did some person who raised Queen's daughter look back?",
	"The woman who gave the languages to Queen's daughter looked back.",
	"Queen married the man that gave the languages to Queen's son.",
	"The man that Queen married gave the languages to Queen's son.",
	"The man Queen married gave the languages to Queen's son.",
	"The job disappointed the man that gave Queen's daughter the languages.",
	"The man that the job disappointed cried the Dominican Republic.",
	"The man the job disappointed cried the Dominican Republic.",
	"Queen's daughter accepted the languages that a man gave Queen's son.",
	"Queen's daughter accepted the language that a man gave to Queen's son.",
	"Who appreciated the man that gave the girl \
	 \that cried the Dominican Republic a language?"
	]



lf0 = Rel "worked" [ Const(ents!!17) ]
lf00 = (Conj [(Rel "person" [Var 0]), (Rel "worked" [Var 0]) ] ) 
-- lf000 = (Exists (Conj [(Rel "person" [Var 0]), (Rel "worked" [Var 0]) ] )) (Const(ents)!!17)

lf1 = (Equi  (Rel "married" [ Const(ents!!9), Const(ents!!1) ]) (Neg (Rel "married" [ Const(ents!!8), Const(ents!!17)]) ) )

lf2 = (Conj [ (Rel "married" [ Const (ents !! 9), Const       (ents !! 1)]), (Rel "married" [ Const (ents !! 8), Const (ents !!   17)]) ] )

lf3 = Rel "married" [ Const (ents !! 8), Const (ents !! 17)]
lf4 = (Impl  (Rel "married" [ Const (ents !! 9), Const        (ents !! 1)]) (Rel "married" [ Const (ents !! 8), Const (ents !!    17)])  )
lf5 = (Conj [ (Rel "married" [ Const (ents !! 9), Const       (ents !! 1)]), (Rel "married" [ Const (ents !! 8), Const (ents !!   17)]) ] )
lf6 = (Disj [ (Rel "married" [ Const (ents !! 9), Const       (ents !! 1)]), (Rel "married" [ Const (ents !! 8), Const (ents !!   17)]) ] )

lf70 = ( \x -> ( Conj [ (Rel "daughter" [x]), (Rel "have" [x, Const (ents !! 8)]) ] ) ) (Const (ents !! 12) )
lf71 = ( \x -> ( Conj [ (Rel "daughter" [x]), (Rel "have" [x, Const (ents !! 17)]) ] ) ) (Const (ents !! 12) )
lf72 = ( \x -> ( Conj [ (Rel "daughter" [x]), (Rel "have" [x, Const (ents !! 17)]) ] ) ) (Const (ents !! 12) )
lf73 = \x -> Conj [ (Rel "daughter" [x]), (Rel "have" [x, Const (ents !! 17)]) ]
lf74 = ( \x -> ( Conj [ (Rel "daughter" [x]), (Rel "have" [x, Const (ents !! 17)]) ] ) )
lf75 = \x -> Impl (Rel "daughter" [x]) (Rel "have" [x, Const (ents !! 17)])
