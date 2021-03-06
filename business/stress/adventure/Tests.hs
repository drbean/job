module Tests where

import LogicalForm
import Parsing

relatives = [
	"Was Steve Fossett a man who flew around the world?"
	, "Was Ellen MacArthur a man who flew around the world?"
	, "Was Ellen MacArthur the woman who was an adventurer?"
	]

haves = [
	"Did Ellen MacArthur have a team?"
	, "Ellen MacArthur had stress."
	, "Ellen MacArthur had a boat."
	, "Did Ellen MacArthur have a boat?"
	, "Did Ellen MacArthur have a plane?"
	, "Did Ellen MacArthur have some plane?"
	, "Did Steve Fossett have stress?"
	, "Did Steve Fossett have a boat?"
	, "Did Steve Fossett have some balloon?"
	, "Did Steve Fossett have balloon?"
	, "Did a team have stress?"
	, "Did a team have a plane?"
	, "Did a team have a woman's plane?"
	, "Did a team have Ellen MacArthur's plane?"
	, "Did a team have a team?"
	, "Did a team have a boat?"
	, "Did an ambitious woman have stress?"
	, "Did an ambitious woman have a boat?"
	, "Did an ambitious woman have some boat?"
	, "Did an ambitious woman's boat have some boat?"
	, "Did the boat have some boat?"
	, "Did the boat have no boat?"
	, "Did the boat have some plane?"
	, "Did the boat have no plane?"
	, "Did Dr Bean have stress?"
	, "Did Dr Bean have a boat?"
	, "Did Ellen MacArthur's boat have a boat?"
	, "Did a team have a boat?"
	, "Did a team have some balloon?"
	, "Did a team have balloon?"
	, "Did Dr Bean have a boat?"
	, "Did Dr Bean have some balloon?"
	, "Did Dr Bean have balloon?"
	]

text_test = [
	"Steve Fossett sailed around the world. He was an adventurer."
	, "He was an adventurer. Steve Fossett sailed around the world."
	, "Ellen MacArthur sailed around the world. She was an adventurer."
	, "Ellen MacArthur sailed around the world. He was an adventurer."
	, "Ellen MacArthur sailed around the world. She was a woman, but she was an adventurer."
	, "Ellen MacArthur sailed around the world. She wasn't a man, but she was an adventurer."
	]

comp_tests = [
	"Lack of support was stressful."
	, "Uncertainty was stressful."
	, "Lack of control was stressful."
	, "Pressure was stressful."
	, "Steve Fossett was a man."
	, "Steve Fossett was an adventurer."
	, "Ellen MacArthur was a woman."
	, "Ellen MacArthur was an adventurer."
	, "Ellen MacArthur was a man."
	, "Ellen MacArthur wasn't a woman."
	, "Steve Fossett wasn't a woman."
	, "Ellen MacArthur wasn't an adventurer."
	, "Steve Fossett was ambitious."
	, "Ellen MacArthur wasn't stressful."
	]

pressure_test = [
	"The team put pressure on the team.",
	"A team didn't put pressure on a team.",
	"The team put pressure on Steve Fossett.",
	"The team didn't put pressure on Steve Fossett.",
	"Steve Fossett put pressure on the team.",
	"Steve Fossett didn't put pressure on the team.",
	"Steve Fossett didn't put pressure on a team.",
	"Steve Fossett put pressure on Ellen MacArthur.",
	"Steve Fossett didn't put pressure on Ellen MacArthur.",
	"The team put pressure on Ellen MacArthur.",
	"The team didn't put pressure on Ellen MacArthur.",
	"Ellen MacArthur put pressure on the team.",
	"Ellen MacArthur didn't put pressure on the team.",
	"Ellen MacArthur put pressure on Ellen MacArthur."
	]

sail_test = [
	"Steve Fossett sailed around the world.",
	"The world sailed around Steve Fossett.",
	"A man sailed around the world.",
	"Ellen MacArthur sailed around the world.",
	"CUSP sailed around the world.",
	"Dr Bean sailed around the world.",
	"Someone sailed around the world.",
	"Steve Fossett sailed around the world in a boat.",
	"Ellen MacArthur sailed around the world in a boat.",
	"CUSP sailed around the world in a balloon.",
	"Dr Bean sailed around the world in an aircraft.",
	"Someone sailed around the world in an aircraft."
	]

mod_test = [
	"Steve Fossett was a man who sailed around the world."
	, "Steve Fossett was the man with a boat."
	, "Steve Fossett was the man who sailed around the world."
	, "Ellen MacArthur was the woman who sailed around the world."
	, "Ellen MacArthur was the woman who had a boat."
	, "Ellen MacArthur was the woman with the boat."
	, "Steve Fossett was the man who felt stress."
	, "Steve Fossett was a man who felt stress."
	, "Steve Fossett was a man who felt stress because of lack of control."
	]

possessives = [
	"Dr Bean's team helped Ellen MacArthur."
	, "Did Ellen MacArthur's team talk to Steve Fossett?"
	, "Did the team of Ellen MacArthur talk to Steve Fossett?"
	, "Ellen MacArthur's stress talked to the team."
	-- , "Ellen MacArthur's team caused Dr Bean's stress"
	, "Did Dr Bean's stress cause stress to Steve Fossett's team?"
	, "Did Dr Bean's stress cause stress to Steve Fossett's team?"
	, "Ellen MacArthur was an adventurer."
	, "Ellen MacArthur was ambitious."
	, "Stress was because of lack of support."
	, "Steve Fossett's stress was because of lack of support?"
	, "The stress of Steve Fossett was because of lack of support?"
	, "Was the stress of Steve Fossett because of lack of support?"
	, "Was the stress of the ambitious women because of lack of support?"
	, "Was the stress of Dr Bean because of lack of support?"
	, "Was the team of Ellen MacArthur because of lack of support?"
	, "Was the team of Steve Fossett because of lack of support?"
	, "Did the team of Ellen MacArthur talk to Steve Fossett?"
	, "Did someone talk to Steve Fossett?"
	]

talks = [
	"Did Steve Fossett talk to Dr Bean?"
	, "Someone talked to Ellen MacArthur."
	, "A team talked to Ellen MacArthur."
	, "The team of Ellen MacArthur talked to Ellen MacArthur."
	, "A team of Ellen MacArthur talked to Ellen MacArthur."
	, "The team of Ellen MacArthur talked to Steve Fossett."
	, "Did the stress of Ellen MacArthur talk to Dr Bean?"
	, "Did a stress of Ellen MacArthur talk to Dr Bean?"
	-- , "Did the stress of Steve Fossett talk to Ellen MacArthur's team?"
	]

fly_test = [
	"Did Steve Fossett fly around the world.",
	"Didn't Steve Fossett fly around the world.",
	"Steve Fossett flew around the world.",
	"Ellen MacArthur flew around the world.",
	"CUSP flew around the world.",
	"Dr Bean flew around the world.",
	"Someone flew around the world.",
	"Steve Fossett flew around the world in a balloon.",
	"Steve Fossett flew around the world in a plane.",
	"Ellen MacArthur flew around the world in a boat.",
	"CUSP flew around the world in a balloon.",
	"Dr Bean flew around the world in a plane.",
	"Dr Bean flew around the world in a balloon.",
	"Didn't Dr Bean fly around the world in a balloon.",
	"Someone flew around the world in a plane."
	]

stress_test = [
	"Steve Fossett felt stress"
	, "Ellen MacArthur felt stress"
	, "Dr Bean felt stress"
	, "Steve Fossett felt stress because of lack of control."
	, "Steve Fossett felt stress because of uncertainty."
	, "Steve Fossett felt stress because of lack of support."
	, "Steve Fossett felt stress because of pressure."
	, "Ellen MacArthur felt stress because of lack of control."
	, "Ellen MacArthur felt stress because of uncertainty."
	, "Ellen MacArthur felt stress because of lack of support."
	, "Ellen MacArthur felt stress because of pressure."
	, "Lack of control caused stress to Ellen MacArthur."
	, "Uncertainty caused stress to Ellen MacArthur."
	, "Lack of support caused stress to Ellen MacArthur."
	, "Pressure caused stress to Ellen MacArthur."
	]

wh_test = [
	"Who sailed around the world?"
	, "Who was a man who flew in a balloon."
	, "Who sailed a boat around the world."
	, "Who flew a glider."

	, "How do you release your stress?"
	, "What can reduce your stress?"
	, "What is Ellen's career?"
	, "How many records did Steve Fossett set?"
	, "What is situation ehen Steve Fossett fly?"
	, "What kind of situation make Ellen Arthur have stress in her sailing time?"
	, "What can reduce your stress?"
	, "How many times does Steve traveling around the world?"
	, "How many times did she spend to successfully sail around the world?"
	, "How many people sail with Ellen?"
	, "What's Steve stressform?"
	, "How much stress do you have?"

	, "How old was he scaled his first mountain?"
	, "Was Steve the first person to fly solo nonstop around the world in a balloon?"
	, "Was Steve Fossett born in Jackson?"
	, "How did he make his fortune? "
	, "What was Fossett's first job?"
	, "What does Steve Fossett's first job out of business school?"
	, "Who was the first person to fly solo nonstop around the world in a balloon?"
	, "Was Steve Fossett an American businessman?"
	, "What makes you feel stressful?"
	, "How many records did Steve set in five different sports?"
	, "Who is Steve Fossett?"
	, "How many records did Fossett set in five differents sports?"
	, "How many years old was Steve Fossett?"

	, "What about people's stress?"
	, "who feels more stress,Susu or Angela?"
	, "How do you release your stress?"
	, "When do you feel stress?"
 	, "Who felt more stress , Leo or Cathy ?"
	, "Why Lisa with more supports was more stressful ?"
	, "Who felt more stress , Ben or Danny ?"
	, "Who felt more stress , Frank or Wei ?"
	, "Who felt more stress , Eric or Leo ?"
	, "Which person felt more stress , Dent or Alien ?"
	, "What will you do when you haven't any support?"
	, "What situation will make you feel stressful ?"
	, "Who felt more stress , Bob or Chris ?"
	, "Why did Toshe feel more stress than David , even though she had more control than David?"
	, "Why does Tina always control others ?"
	, "Why did Rene feel more stress than Alien , even though she had more support than Alien?"
	, "What will you do when you under pressure ?"



	]

yn_test = [
	"Does stress make people feel like sick?"
	, "Is he the person who traveling around the world in a balloon?"
	, "Can Steve Fossett control his stress?"
	, "Did Ellen MacArthur break any global record?"
	, "Did she successfully sail around the world?"
	, "Do you feel stressful when you face obstacles?"
	, "Did he make fortune in financial services industry?"
	, "Is Dame Ellen best known as a solo long-distance?"
	, "Was Steve Fossett an adventurer?"
	, "Did Steve sail sea?"
	, "Did stress need to exist?"
	, "Did Ellen MacArthur sail around the world?"

	, "Did James Stephen Fossett was he born 1944?"
	, "Was Steve the first person to fly solo nonstop around the world in a balloon?"
	, "Was Steve Fossett born in Jackson?"
	, "Was he a sailor?"
	, "Was Fossett married to Peggy Fosset?"
	, "Was Fossett best known for many world records?"
	, "Did Steve fly solo nonstop in a balloon?"
	, "Was Steve the first person to fly solo around the world in a balloon?"
	, "Was Steve Fossett a American businessman?"
	, "Did you think speeding English is stressful?"
	, "Did Steve fly around the world the world with supports?"
	, "Is Steve Fossett the first person to fly solo nonstop around the world in a balloon?"
	, "Was Fossett declared legally dead on February 15, 2008?"
	, "Was Fossett reported missing after the plane he was flying over the Nevada desert failed to return?"
	, "Did Fossett set 116 records in five different sports?"

	, "Do you feel stress when you are late for school?"
	, "Does watching a horror movie make you feel stress?"
	, "Do you feel stressful if you stuck in a traffic jam?"
	, "Did you feel more stress in playing basketball than tennis?"
	, "Did you have stress when you have to say 'I love you' to your parents?"
	, "Did you feel stressful when you have a test in math?"
	, "Do you think stress is good or bad?"
	, "Did people feel much stress when they met with a car accident?"
	, "Do you feel stress when you talk to Dr,Bean?"
	, "Did you feel much stress when the exam's coming?"
	, "Did you feel stress in Dr.Bean's class?"
	, "Did James have more stress?"
	, "Did you have more support?"
	, "Did Eric have more support when he feel more stress?"
	, "Did you have lack support?"
	, "Did Rene have more support than Alien?"
	, "Does uncertainty make you feel more pressure?"
	, "Did Chris have more stress?"
	, "Did Tina have more support?"
	, "Did David have more stress?"
	, "Does the situation always out of control?"
	, "Did you have more stress?"
	, "Do you feel attending this English class give you a lot of pressure?"
	, "Did Abby feel pressure after her boss blame her?"
	, "Did Leo have more support?"

	]

tag_test = [
	"Steve Fossett sailed around the world. He was an adventurer, wasn't he."
	, "Dr Bean didn't fly around the world in a balloon, did he?"
	, "Uncertainty was stressful, wasn't it."
	, "The team didn't put pressure on Steve Fossett, did it."
	, "Steve Fossett sailed around the world, didn't he."
	, "A man sailed around the world, didn't he."
	, "A man sailed around the world, didn't she."
	, "Ellen MacArthur flew around the world, didn't she."
	, "Steve Fossett felt stress because of lack of control, didn't he."
	, "Ellen MacArthur was the woman who sailed around the world, wasn't she."

	, "Taking the exam is stressful ,isn't it? "
	, "An interview makes you feel stress,doesn't it? "
	, "Steve was an American Businessman,wasn't he? "
	, "Ellen Rather broke the world record for the fastest solo circumnavigation of the global, didn't she? "
	, "He became the first person to fly around the world alone,isn't he? "
	, "Does Steve like fly,does he? "
	, "Fossett flew solo nonstop around the world in a balloon,didn't he? "
	, "Ellen MacArthur sailed around the world ,didn't she? "
	, "Ellen is a best known as a solo long-distance yacht woman,isn't she? "
	, "Fossett set 116record in five different sports,doesn't he? "
	, "He was the first person to fly solo nonstop around the world in a balloon ,wasn't he? "
	, "Fossett became a successful salesman in 1973,didn't he?"

	, "Did he scaled his mountain in 12 years old?"
	, "Fossett was one of the world’s most accomplished sailors, wasn’t he?"
	, "Fossett was born in Jackson, wasn’t he?"
	, "He was adventurer, wasn’t he?"
	, "Did Fossett set the Absolute World Speed Record for airship on October 27, 2004, didn’t it?"
	, "Steve Fossett was first to fly around the world in balloon, wasn’t he?"
	, "Steve was an American business, wasn’t he?"
	, "Ellen was named “Sailing Young Hope” in France, wasn’t she?"
	, "Fossett was graduated from Stanford with the degree in economics, didn’t he?"
	, "Being a worker is more stressful than being a student, isn’t it?"
	, "Steve passed away in a plane crash, didn’t him?"
	, "Fossett was born in Jackson.Tennessee, wasn’t he?"
	, "Fossett see 166 record in five different sports, didn’t he?"
	, "Fossett was the first person to fly solo nonstop around the world in the balloon, wasn’t he?"
	, "Ellen MacArthur broke the world record for the fastest solo circumnavigation of the globe on 7 February 2005, didn’t she?"

	, "B felt more stressful than A, didn't B?"
	, "Watching a movie is a relaxing thing, isn't is?"
	, "More control made Banana feel more stress, didn't it?"
	, "Emily has stress on her job, doesn't she?"
	, "The pressure is under my control, isn't it?"
	, "It's stressful to raise a child, isn't it?"
	, "Jophiel was stressful for money, wasn't he?"
	, "It's stressful to do your homework, isn't it?"
	, "Manage a team is more stressful than answer a question, isn't it?"
	, "Teachers put more pressure on students, didn't they?"
	, "Stress cause from internal feeling, doesn't it?"
	, "Chossing the question by yourself is more stressful, isn't it?"
	, "You are nervous when you feel stressful, aren't you?"
	, "Some stress is sometimes good for us, isn't it?"
	]

