# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

alias web="cd; screen -c /home/drbean/dot/.screen/web.rc -dR web; cd -"
alias surf="cd ~/sr; screen -dR surfraw; cd -"
alias tennis="cd ~/tennis; screen -dR tennis; cd -"
alias beans="cd ~/class/beans; APP=beans COURSE= screen -c /home/drbean/dot/.screen/project.rc -dR beans; cd -"
alias swiss="cd ~/swiss; APP=swiss COURSE=business screen -c /home/drbean/dot/.screen/project.rc -dR swiss; cd -"
alias comp="cd ~/comp; APP=comp COURSE=business STORY=adventure screen -c /home/drbean/dot/.screen/project.rc -dR comp; cd -"

function edit () {
    OPTIND=1
    local arg source
    while getopts 's:' arg
    do
        case ${arg} in
            s) source=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
    cd ~/edit/$source
    SOURCE=$source screen -c /home/drbean/dot/.screen/edit.rc -dR edit
    cd -
}

function dic () {
    OPTIND=1
    local arg app=dic course topic story old_story league script_arg
    while getopts 'c:t:s:o:l:x:' arg
    do
        case ${arg} in
            c) course=${OPTARG};;
            t) topic=${OPTARG};;
            s) story=${OPTARG};;
            o) old_story=${OPTARG};;
            l) league=${OPTARG};;
            x) script_arg=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
    cd ~/$app
    APP=$app COURSE=$course TOPIC=$topic STORY=$story OLD_STORY=$old_story LEAGUE=$league SCRIPT_ARG=$script_arg screen -c /home/drbean/dot/.screen/app.rc -dR dic
    cd -
}

function bett () {
    OPTIND=1
    local arg app=bett course topic story old_story league script_arg
    while getopts 'c:s:o:l:x:' arg
    do
        case ${arg} in
            c) course=${OPTARG};;
            s) story=${OPTARG};;
            o) old_story=${OPTARG};;
            l) league=${OPTARG};;
            x) script_arg=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
    cd ~/bett
    APP=bett \
    COURSE=$course \
    STORY=$story \
    OLD_STORY=$old_story \
    LEAGUE=$league \
    SCRIPT=$script_arg \
    screen -c /home/drbean/dot/.screen/app.rc -dR bett
    cd -
}

alias hpaste="cd ~/hpaste; screen -dR hpaste; cd -"

alias vim="cd ~/vim; screen -c /home/drbean/dot/.screen/vim.rc -dR vim; cd -"

alias dot="cd ~/dot; screen -c /home/drbean/dot/.screen/dotrc -dR dot; cd -"
alias irc="cd ~/znc; screen -c /home/drbean/dot/.screen/irc.rc -dR irc; cd -"

alias csfp="cd ~/class/csfp; screen -c /home/drbean/dot/.screen/csfprc -dR csfp; cd -"
alias GF="cd ~/GF; screen -c /home/drbean/dot/.screen/haskell.rc -dR GF; cd -"
alias nlp="cd ~/nlp; screen -dR nlp; cd -"

function pagestranscripts () {
    OPTIND=1
    local arg course story
    while getopts 'c:t:s:o:l:x:' arg
    do
        case ${arg} in
            c) course=${OPTARG};;
            s) story=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
    cd ~/class/pagestranscripts
    COURSE=$course \
    STORY=$story \
    screen -c /home/drbean/dot/.screen/pagestranscripts.rc -dR pagestranscripts
    cd -
}

function soundfiles () {
    OPTIND=1
    local arg course
    while getopts 'c:d:' arg
    do
        case ${arg} in
            c) course=${OPTARG};;
            d) directory=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
    cd ~/soundfiles
    COURSE=$course \
    DIRECTORY=$directory \
    screen -c /home/drbean/dot/.screen/soundfiles.rc -dR soundfiles
    cd -
}

alias class="cd ~/class; screen -dR class; cd -"
alias forms="cd ~/class/forms; screen -dR forms; cd -"
alias tmpl="cd ~/class/tmpl; screen -c /home/drbean/dot/.screen/utility.rc -dR tmpl; cd -"
alias rc="cd ~/021/rc; screen -c /home/drbean/dot/.screen/utility.rc -dR rc; cd -"

function business () {
    OPTIND=1
    local arg course=business view topic story form
    while getopts 'c:v:t:s:f:' arg
    do
        case ${arg} in
            v) view=${OPTARG};;
            t) topic=${OPTARG};;
            s) story=${OPTARG};;
            f) form=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
	cd ~/class/$course
	COURSE=$course \
	VIEW=$view \
	TOPIC=$topic \
	STORY=$story \
	FORM=$form \
	screen -c /home/drbean/dot/.screen/course.rc -dR $course
	cd -
}

function conversation () {
    OPTIND=1
    local arg course=conversation view topic story form
    while getopts 'c:v:t:s:f:' arg
    do
        case ${arg} in
            v) view=${OPTARG};;
            t) topic=${OPTARG};;
            s) story=${OPTARG};;
            f) form=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
	cd ~/class/$course
	COURSE=$course \
	VIEW=$view \
	TOPIC=$topic \
	STORY=$story \
	FORM=$form \
	screen -c /home/drbean/dot/.screen/course.rc -dR $course
	cd -
}

function multimedia () {
    OPTIND=1
    local arg course=multimedia view topic story form
    while getopts 'c:v:t:s:f:' arg
    do
        case ${arg} in
            v) view=${OPTARG};;
            t) topic=${OPTARG};;
            s) story=${OPTARG};;
            f) form=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
	cd ~/class/$course
	COURSE=$course \
	VIEW=$view \
	TOPIC=$topic \
	STORY=$story \
	FORM=$form \
	screen -c /home/drbean/dot/.screen/course.rc -dR $course
	cd -
}

function media () {
    OPTIND=1
    local arg course=media view topic story form
    while getopts 'c:v:t:s:f:' arg
    do
        case ${arg} in
            v) view=${OPTARG};;
            t) topic=${OPTARG};;
            s) story=${OPTARG};;
            f) form=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
	cd ~/class/$course
	COURSE=$course \
	VIEW=$view \
	TOPIC=$topic \
	STORY=$story \
	FORM=$form \
	screen -c /home/drbean/dot/.screen/course.rc -dR $course
	cd -
}

function exam_prep () {
    OPTIND=1
    local arg course round topic story form
    while getopts 'c:v:t:s:f:' arg
    do
        case ${arg} in
            c) course=${OPTARG};;
            v) view=${OPTARG};;
            t) topic=${OPTARG};;
            s) story=${OPTARG};;
            f) form=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
	cd ~/class/$course
	COURSE=$course \
	VIEW=$view \
	TOPIC=$topic \
	STORY=$story \
	FORM=$form \
	screen -c /home/drbean/dot/.screen/exam_prep.rc -dR $course
	cd -
}

function grading () {
    OPTIND=1
    local arg league round topic story form
    while getopts 'l:r:t:s:f:n:' arg
    do
        case ${arg} in
            l) league=${OPTARG};;
            r) round=${OPTARG};;
            t) topic=${OPTARG};;
            s) story=${OPTARG};;
            f) form=${OPTARG};;
            n) n=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
    cd ~/021/$league
    ROUND=$round \
    NEXTROUND=$(($round+1)) \
    LEAGUE=$league \
    TOPIC=$topic \
    STORY=$story \
    FORM=$form \
    N=$n \
    screen -c /home/drbean/dot/.screen/grading.rc -dR $league
    cd -
}

alias intercultural="cd ~/class/intercultural; VIEW=intercultural TOPIC= screen -c /home/drbean/dot/.screen/course.rc -dR intercultural; cd -"
alias literature="cd ~/class/literature; VIEW=literature TOPIC= STORY=robin-hood FORM=2 screen -c /home/drbean/dot/.screen/course.rc -dR literature; cd -"

alias grammar="cd ~/class/curriculum/grammar; screen -dR grammar; cd -"
alias writing="cd ~/class/curriculum/writingreading; screen -dR writing; cd -"
alias speaking="cd ~/class/curriculum/speaking; screen -dR speaking; cd -"
alias reading="cd ~/class/curriculum/reading; screen -dR reading; cd -"
alias friends="cd ~/class/friends; screen -dR friends; cd -"
alias pop="cd ~/class/curriculum/pop; screen -dR pop; cd -"
alias ko="cd ~/class/curriculum/ko; screen -dR ko; cd -"
alias magazine="cd ~/class/magazine; screen -dR magazine; cd -"

alias 021="cd ~/021; screen -dR s021; cd -"

function AFN2N0 () {
    OPTIND=1
    local arg league=AFN2N0 session week letter topic tables
    while getopts 's:w:l:t:' arg
    do
        case ${arg} in
            s) session=${OPTARG};;
            w) week=${OPTARG};;
            l) letter=${OPTARG};;
            t) topic=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
    case ${letter} in
	A) tables="Black::Blue,BlackBlack::Green,Orange::Pink,Yellow::White,Purple::BlueBlue";;
	B) tables="Green::Black,Blue::BlueBlue,Purple::Yellow,White::Orange,Pink::BlackBlack";;
	C) tables="Black::Blue,Brown::BlueBlue,BlackBlack::Green,Orange::Pink,Yellow::White,Purple::Red,BrownBrown::Assistants";;
	X) tables="Green::Black,Blue::BlueBlue,Purple::Yellow,White::Orange,Pink::BlackBlack";;
	*) return 1 # illegal option
    esac
    cd ~/021/$league
    SESSION=$session \
    WEEK=$week \
    LASTWEEK=$(($week-1)) \
    LEAGUE=$league \
    TOPIC=$topic \
    LETTER=$letter \
    TABLES=$tables \
    screen -c /home/drbean/dot/.screen/class.rc -dR $league
    cd -
}

function AFN300 () {
    OPTIND=1
    local arg league=AFN300 session week letter topic tables
    while getopts 's:w:l:t:' arg
    do
        case ${arg} in
            s) session=${OPTARG};;
            w) week=${OPTARG};;
            l) letter=${OPTARG};;
            t) topic=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
    case ${letter} in
	A) tables="Black::Blue,Brown::Gray,BrownBrown::BlueBlue,BlackBlack::Green,Orange::Pink,Purple::Red,PinkPink::OrangeOrange,Yellow::White";;
	B) tables="1/1::1/2,2/1::2/2,3/1::3/2,4/1::4/2,8/1::8/2,9/1::9/2,10/1::10/2,11/1::11/2";;
	C) tables="Black::Blue,Brown::Gray,BrownBrown::BlueBlue,BlackBlack::Green,Orange::Pink,Purple::Red,PinkPink::OrangeOrange,Yellow::White";;
	X) tables="Green::Black,Blue::Brown,BlueBlue::BlackBlack,Yellow::Orange,Pink::Purple,Red::OrangeOrange";;
	*) return 1 # illegal option
    esac
    cd ~/021/$league
    SESSION=$session \
    WEEK=$week \
    LASTWEEK=$(($week-1)) \
    LEAGUE=$league \
    TOPIC=$topic \
    LETTER=$letter \
    TABLES=$tables \
    screen -c /home/drbean/dot/.screen/class.rc -dR $league
    cd -
}

function AFN3Y0 () {
    OPTIND=1
    local arg league=AFN3Y0 session week letter topic tables
    while getopts 's:w:l:t:' arg
    do
        case ${arg} in
            s) session=${OPTARG};;
            w) week=${OPTARG};;
            l) letter=${OPTARG};;
            t) topic=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
    case ${letter} in
	A) tables="Black::Blue,Brown::BlueBlue,BlackBlack::Green,Orange::Pink,Purple::Red,Yellow::OrangeOrange";;
	B) tables="Green::Black,Blue::Brown,BlueBlue::BlackBlack,Yellow::Orange,Pink::Purple,Red::OrangeOrange";;
	C) tables="Black::Blue,Brown::BlueBlue,BlackBlack::Green,Orange::Pink,Purple::Red,Yellow::OrangeOrange";;
	X) tables="Green::Black,Blue::Brown,BlueBlue::BlackBlack,Yellow::Orange,Pink::Purple,Red::OrangeOrange";;
	*) return 1 # illegal option
    esac
    cd ~/021/$league
    SESSION=$session \
    WEEK=$week \
    LASTWEEK=$(($week-1)) \
    LEAGUE=$league \
    TOPIC=$topic \
    LETTER=$letter \
    TABLES=$tables \
    screen -c /home/drbean/dot/.screen/class.rc -dR $league
    cd -
}

function yd40001280 () {
    OPTIND=1
    local arg league=yd40001280 session week letter topic tables
    while getopts 's:w:l:t:' arg
    do
        case ${arg} in
            s) session=${OPTARG};;
            w) week=${OPTARG};;
            l) letter=${OPTARG};;
            t) topic=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
    case ${letter} in
	A) tables="Black::Blue,Brown::BlueBlue,BlackBlack::Green,Orange::Pink,Purple::Red,Yellow::OrangeOrange";;
	B) tables="Green::Black,Blue::Brown,BlueBlue::BlackBlack,Yellow::Orange,Pink::Purple,Red::OrangeOrange";;
	C) tables="Black::Blue,Brown::BlueBlue,BlackBlack::Green,Orange::Pink,Purple::Red,Yellow::OrangeOrange";;
	X) tables="Green::Black,Blue::Brown,BlueBlue::BlackBlack,Yellow::Orange,Pink::Purple,Red::OrangeOrange";;
	*) return 1 # illegal option
    esac
    cd ~/021/$league
    SESSION=$session \
    WEEK=$week \
    LASTWEEK=$(($week-1)) \
    LEAGUE=$league \
    TOPIC=$topic \
    LETTER=$letter \
    TABLES=$tables \
    screen -c /home/drbean/dot/.screen/class.rc -dR $league
    cd -
}

function FLA0006 () {
    OPTIND=1
    local arg league=FLA0006 session week letter topic tables
    while getopts 's:w:l:t:' arg
    do
        case ${arg} in
            s) session=${OPTARG};;
            w) week=${OPTARG};;
            l) letter=${OPTARG};;
            t) topic=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
    case ${letter} in
	A) tables="Black::Blue,BlueBlue::BlackBlack,Green::Orange,Pink::Purple,Yellow::White";;
	B) tables="Green::Black,Blue::Brown,BlueBlue::BlackBlack,Yellow::Orange,Pink::Purple,Red::OrangeOrange";;
	C) tables="Black::Blue,BlueBlue::BlackBlack,Green::Orange,Pink::Purple,Yellow::White";;
	X) tables="Green::Black,Blue::Brown,BlueBlue::BlackBlack,Yellow::Orange,Pink::Purple,Red::OrangeOrange";;
	*) return 1 # illegal option
    esac
    cd ~/021/$league
    SESSION=$session \
    WEEK=$week \
    LASTWEEK=$(($week-1)) \
    LEAGUE=$league \
    TOPIC=$topic \
    LETTER=$letter \
    TABLES=$tables \
    screen -c /home/drbean/dot/.screen/class.rc -dR $league
    cd -
}

function FLA0007 () {
    OPTIND=1
    local arg league=FLA0007 session week letter topic tables
    while getopts 's:w:l:t:' arg
    do
        case ${arg} in
            s) session=${OPTARG};;
            w) week=${OPTARG};;
            l) letter=${OPTARG};;
            t) topic=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
    case ${letter} in
	A) tables="Black::Blue,Brown::Gray,Orange::Pink,Purple::Red";;
	B) tables="Orange::Black,Blue::Brown,Gray::Red,Purple::Pink";;
	C) tables="Black::Blue,Brown::Gray,Orange::Pink,Purple::Red";;
	X) tables="Orange::Black,Blue::Brown,Gray::Red,Purple::Pink";;
	*) return 1 # illegal option
    esac
    cd ~/021/$league
    SESSION=$session \
    WEEK=$week \
    LASTWEEK=$(($week-1)) \
    LEAGUE=$league \
    TOPIC=$topic \
    LETTER=$letter \
    TABLES=$tables \
    screen -c /home/drbean/dot/.screen/class.rc -dR $league
    cd -
}

function GL00006 () {
    OPTIND=1
    local arg league=GL00006 session week letter topic tables
    while getopts 's:w:l:t:' arg
    do
        case ${arg} in
            s) session=${OPTARG};;
            w) week=${OPTARG};;
            l) letter=${OPTARG};;
            t) topic=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
    case ${letter} in
	A) tables="Black::Gray,Orange::Green,White::Yellow,Blue::Assistants";;
	B) tables="Black::Blue,Gray::White,Yellow::Green,Orange::Brown";;
	C) tables="Black::Gray,Orange::Green,White::Yellow,Blue::Brown";;
	X) tables="Yellow::Black,Blue::Orange,Green::Gray,Red::White";;
	*) return 1 # illegal option
    esac
    cd ~/021/$league
    SESSION=$session \
    WEEK=$week \
    LASTWEEK=$(($week-1)) \
    LEAGUE=$league \
    TOPIC=$topic \
    LETTER=$letter \
    TABLES=$tables \
    screen -c /home/drbean/dot/.screen/class.rc -dR $league
    cd -
}

function GL00030 () {
    OPTIND=1
    local arg league=GL00030 session week letter topic tables
    while getopts 's:w:l:t:' arg
    do
        case ${arg} in
            s) session=${OPTARG};;
            w) week=${OPTARG};;
            l) letter=${OPTARG};;
            t) topic=${OPTARG};;
            *) return 1 # illegal option
        esac
    done
    case ${letter} in
	A) tables="Green::Orange,BlackBlack::Pink";;
	B) tables="Green::BlackBlack,Orange::Pink";;
	C) tables="Green::Pink,Orange::BlackBlack";;
	X) tables="Assistants::Green,BlackBlack::Purple,Pink::Orange,Yellow::OrangeOrange";;
	*) return 1 # illegal option
    esac
    cd ~/021/$league
    SESSION=$session \
    WEEK=$week \
    LASTWEEK=$(($week-1)) \
    LEAGUE=$league \
    TOPIC=$topic \
    LETTER=$letter \
    TABLES=$tables \
    screen -c /home/drbean/dot/.screen/class.rc -dR $league
    cd -
}

alias contest="cd ~/001/contest; screen -dR contest; cd -"

alias job="cd ~/job; screen -dR job; cd -"

alias q=exit

# vim: set ts=8 sts=4 sw=4 noet:
