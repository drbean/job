module Tests where

import Evaluation
import Parsing

haves = [
	"Did Ellen MacArthur have a team?"
	, "Ellen MacArthur had a boat"
	, "Did Ellen MacArthur have a boat?"
	, "Did Ellen MacArthur have a plane?"
	, "Did Ellen MacArthur have some plane?"
	, "Did Steve Fossett have a boat?"
	, "Did Steve Fossett have some balloon?"
	, "Did Steve Fossett have balloon?"
	, "Did Steve Fossett's boat have a boat?"
	, "Did Steve Fossett's boat have some balloon?"
	, "Did Steve Fossett's boat have a balloon?"
	, "Did a team have a plane?"
	, "Did a team have a woman's plane?"
	, "Did a team have Ellen MacArthur's plane?"
	, "Did a team have a team?"
	, "Did a team have a boat?"
	, "Did an ambitious woman have a boat?"
	, "Did an ambitious woman have some a boat?"
	, "Did an ambitious woman's boat have some a boat?"
	, "Did an ambitious woman's boat have a plane?"
	, "Did the boat have some a boat?"
	, "Did the boat have no a boat?"
	, "Ellen MacArthur's boat had many planes in Poland."
	, "Did the boat have some plane?"
	, "Did the boat have no plane?"
	, "Did Poland have a boat?"
	, "Did the United States have a boat?"
	, "Did Dr Bean have a boat?"
	, "Did Ellen MacArthur's boat have a boat?"
	, "Did a team have a boat?"
	, "Did a team have some balloon?"
	, "Did a team have balloon?"
	, "Did Dr Bean have a boat?"
	, "Did Dr Bean have some balloon?"
	, "Did Dr Bean have balloon?"
	, "Did a team have a worker?"
	, "Did Ellen MacArthur's boat have a worker?"
	, "Did Dr Bean have a worker?"
	, "Did someone have a worker?"
	]


tag_test = [
	"Steve Fossett sailed around the world. He was an adventurer, wasn't he."
	, "Uncertainty was stressful, wasn't it."
	, "The team didn't put pressure on Steve Fossett, did it."
	, "A man sailed around the world, didn't he."
	, "A man sailed around the world, didn't she."
	, "Ellen MacArthur flew around the world, didn't she."
	, "Steve Fossett felt stress because of lack of control, didn't he."
	, "Ellen MacArthur was the woman who sailed around the world, wasn't she."
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

rel_test = [
	"Steve Fossett was a man who sailed around the world."
	, "Steve Fossett was the man who sailed around the world."
	, "Ellen MacArthur was the woman who sailed around the world."
	, "Steve Fossett was the man who felt stress."
	, "Steve Fossett was a man who felt stress."
	, "Steve Fossett was a man who felt stress because of lack of control."
	]

fly_test = [
	"Did Steve Fossett fly around the world.",
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
	"Someone flew around the world in a plane."
	]

stress_test = [
	"Steve Fossett felt stress",
	"Ellen MacArthur felt stress",
	"Dr Bean felt stress",
	"Steve Fossett felt stress because of lack of control.",
	"Steve Fossett felt stress because of uncertainty.",
	"Steve Fossett felt stress because of lack of support.",
	"Steve Fossett felt stress because of pressure.",
	"Ellen MacArthur felt stress because of lack of control.",
	"Ellen MacArthur felt stress because of uncertainty.",
	"Ellen MacArthur felt stress because of lack of support.",
	"Ellen MacArthur felt stress because of pressure."
	]

len_test = [
	"Who was a man who flew in a balloon.",
	"Who flew a glider."
	]

lilith_test = [
	"Who sailed a boat around the world.",
	"Who flew a glider."
	]
