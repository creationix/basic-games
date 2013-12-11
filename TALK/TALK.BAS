DECLARE FUNCTION nm$ ()
DECLARE FUNCTION subj$ ()
DECLARE FUNCTION typeof% (rs$)
DECLARE FUNCTION adj$ ()
DECLARE FUNCTION phrase$ ()
DECLARE FUNCTION fod$ ()
DECLARE FUNCTION drnk$ ()
DECLARE FUNCTION plce$ ()
DECLARE FUNCTION prsn$ ()
DECLARE FUNCTION by$ ()
DECLARE FUNCTION grl$ ()
DECLARE FUNCTION hoby$ ()
DECLARE FUNCTION sentence$ ()
DECLARE SUB inpt (a$, b$)
DECLARE SUB talk (f$)
DEFINT A-Z
RANDOMIZE (TIMER)
DIM SHARED places, boys, girls, foods, drinks, hobbies, name$, res$, subject$

boys = 0: girls = 0: foods = 0: drinks = 0: hobbies = 0: places = 0
OPEN "word.dat" FOR INPUT AS #1
DO
    INPUT #1, a$
    IF a$ <> "%%%" THEN boys = boys + 1
LOOP WHILE a$ <> "%%%"
DO
    INPUT #1, a$
    IF a$ <> "%%%" THEN girls = girls + 1
LOOP WHILE a$ <> "%%%"
DO
    INPUT #1, a$
    IF a$ <> "%%%" THEN foods = foods + 1
LOOP WHILE a$ <> "%%%"
DO
    INPUT #1, a$
    IF a$ <> "%%%" THEN drinks = drinks + 1
LOOP WHILE a$ <> "%%%"
DO
    INPUT #1, a$
    IF a$ <> "%%%" THEN hobbies = hobbies + 1
LOOP WHILE a$ <> "%%%"
DO
    INPUT #1, a$
    IF a$ <> "%%%" THEN places = places + 1
LOOP WHILE a$ <> "%%%"
CLOSE #1
DIM SHARED boy$(boys), girl$(girls), food$(foods), drink$(drinks), hobbie$(hobbies), place$(places)

OPEN "word.dat" FOR INPUT AS #1
FOR a = 1 TO boys: INPUT #1, boy$(a): NEXT a: INPUT #1, a$
FOR a = 1 TO girls: INPUT #1, girl$(a): NEXT a: INPUT #1, a$
FOR a = 1 TO foods: INPUT #1, food$(a): NEXT a: INPUT #1, a$
FOR a = 1 TO drinks: INPUT #1, drink$(a): NEXT a: INPUT #1, a$
FOR a = 1 TO hobbies: INPUT #1, hobbie$(a): NEXT a: INPUT #1, a$
FOR a = 1 TO places: INPUT #1, place$(a): NEXT a
CLOSE #1
CLS

subject$ = hoby$
talk "Hello,  I am Zelcron."
DO
    talk "Who are you?"
    COLOR 13: INPUT name$
IF name$ = "" THEN talk "I really need to know your name!!"
LOOP WHILE name$ = ""
IF UCASE$(name$) = "ZELCRON" THEN talk "Wow that is my name"
IF UCASE$(name$) = "TIM" THEN talk "Hey, don't I know you?"
IF UCASE$(name$) = "JESS" OR UCASE$(name$) = "JESSICA" THEN talk "Have you seen my friend Pyrex?"
IF UCASE$(name$) = "GREG" THEN talk "I know who are! Go away!"
say$ = sentence$
DO
l$ = RIGHT$(say$, 1)
IF l$ <> "." AND l$ <> "!" AND l$ <> "?" THEN say$ = say$ + "."
MID$(say$, 1, 1) = UCASE$(LEFT$(say$, 1))
talk say$: COLOR 13: PRINT "You:"; : LINE INPUT res$
t = typeof(res$)
say$ = sentence$
a$ = subj$
IF t = 0 THEN IF a$ > "" AND RND > .1 THEN say$ = a$
IF t > 0 THEN IF a$ > "" AND RND > .7 THEN say$ = a$

IF t = 29 THEN END
n = INT(5 * RND) + 1
IF t = 1 THEN
    IF n = 1 THEN say$ = "You are sure negative!"
    IF n = 2 THEN say$ = "I wasn't asking a question!"
    IF n = 3 THEN say$ = "No! Why do you say NO!"
    IF n = 4 THEN say$ = "Don't disagree with me!"
    IF n = 5 THEN say$ = "I would have said yes."
END IF
IF t = 2 THEN
    IF n = 1 THEN say$ = "Why do you agree with everything?"
    IF n = 2 THEN say$ = "I wasn't asking a question!"
    IF n = 3 THEN say$ = "Yes! what kind of answer is that!"
    IF n = 4 THEN say$ = "You're not right."
    IF n = 5 THEN say$ = "I would have said no."
END IF
IF t = 3 THEN
    IF n = 1 THEN say$ = "Why do you agree with everything?"
    IF n = 2 THEN say$ = "NO! It's not okay."
    IF n = 3 THEN say$ = "OK! What do you mean OK?"
    IF n = 4 THEN say$ = "Yep."
    IF n = 5 THEN say$ = phrase$ + " I think anything is 'OK' with you."
END IF
IF t = 4 THEN
    IF n = 1 THEN say$ = "Just because."
    IF n = 2 THEN say$ = "because that is the way it is."
    IF n = 3 THEN say$ = "Why should I tell you?"
    IF n = 4 THEN say$ = "Hey, thats personnal!"
    IF n = 5 THEN say$ = phrase$ + " " + name$ + " asks too many questions."
END IF
IF t = 5 THEN
    IF n = 1 THEN say$ = "Go and find it yourself!"
    IF n = 2 THEN say$ = "In " + plce$ + "."
    IF n = 3 THEN say$ = "Somwhere not here."
    IF n = 4 THEN say$ = "It is not in " + plce$ + "."
    IF n = 5 THEN say$ = name$ + ", I don't care. Find my " + fod$
END IF
IF t = 6 THEN
    IF n = 1 THEN say$ = "What do you mean What!!"
    IF n = 2 THEN say$ = "I am only a computer?!?"
    IF n = 3 THEN say$ = "I can't trust you to that secret unles " + prsn$ + " says I can!"
    IF n = 4 THEN say$ = "Go ask " + prsn$ + "."
    IF n = 5 THEN say$ = "WHAT is WHAT!"
END IF
IF t = 7 THEN
    IF n = 1 THEN say$ = "At" + STR$(INT(3 + 9 * RND)) + "o'clock."
    IF n = 2 THEN say$ = "In the next" + STR$(INT(3 + 9 * RND)) + " years."
    IF n = 3 THEN say$ = "That is hard to tell, ask Merlyn."
    IF n = 4 THEN say$ = "I thought it was" + STR$(INT(3 + 9 * RND)) + " days ago."
    IF n = 5 THEN say$ = "Maby never!!"
END IF
IF t = 8 THEN
    IF n = 1 THEN say$ = "How do you do anything?"
    IF n = 2 THEN say$ = "You first need " + prsn$ + " with a" + drnk$ + " to do answer that."
    IF n = 3 THEN say$ = "I want you to read " + prsn$ + " " + adj$ + " how-to about that."
    IF n = 4 THEN say$ = "I will answer only to " + prsn$ + "!"
    IF n = 5 THEN say$ = "You just do!"
END IF
IF t = 9 THEN
    IF n = 1 THEN say$ = "I don't want to know about your life."
    IF n = 2 THEN say$ = "That is very interesting."
    IF n = 3 THEN say$ = "I never knew you were like that."
    IF n = 4 THEN say$ = "I wish I could be like " + name$ + "!"
    IF n = 5 THEN say$ = prsn$ + " is just like you!"
END IF
IF t = 10 THEN
    IF n = 1 THEN say$ = "I am a computer."
    IF n = 2 THEN say$ = "I like to eat " + fod$ + "."
    IF n = 3 THEN say$ = "Don't talk about me like that."
    IF n = 4 THEN say$ = "I am never " + hoby$ + "!!"
    IF n = 5 THEN say$ = "That's too personnal for you to handle."
END IF
IF t = 11 THEN
    IF n = 1 THEN say$ = prsn$ + "."
    IF n = 2 THEN say$ = "The man eating a " + fod$ + "."
    IF n = 3 THEN say$ = grl$ + ", she was " + hoby$ + "."
    IF n = 4 THEN say$ = "IT WAS THE ONE ARMED MAN!!!!!"
    IF n = 5 THEN say$ = "Well " + prsn$ + " wouldn't work for an answer."
END IF
IF t = 12 THEN
    IF n = 1 THEN say$ = "Go wash your mouth out with soap and water!"
    IF n = 2 THEN say$ = "Watch your language!"
    IF n = 3 THEN say$ = "I know that was about you!"
    IF n = 4 THEN say$ = "You're as bad as " + prsn$ + "!!"
    IF n = 5 THEN say$ = "That's not nice!"
END IF
IF t = 13 THEN
    IF n = 1 THEN say$ = "I am a computer."
    IF n = 2 THEN say$ = prsn$ + " dosen't have a computer."
    IF n = 3 THEN say$ = "Computers are great!"
    IF n = 4 THEN say$ = "I sure am glad you're not talking about me!"
    IF n = 5 THEN say$ = "What is a computer?"
END IF
IF t = 14 THEN
    IF n = 1 THEN say$ = "I hate Swim!"
    IF n = 2 THEN say$ = "The water kills my circuts!"
    IF n = 3 THEN say$ = "How fast can you swim?"
    IF n = 4 THEN say$ = "Can you swim?"
    IF n = 5 THEN say$ = prsn$ + " can swim great!"
END IF
IF t = 15 THEN
    IF n = 1 THEN say$ = "I am talking to you, are you talking to me!"
    IF n = 2 THEN say$ = "What do you want to talk about?"
    IF n = 3 THEN say$ = "I can TALK!"
    IF n = 4 THEN say$ = "Do I sound funny?"
    IF n = 5 THEN say$ = "I don't hear you talking!"
END IF
IF t = 16 THEN
    IF n = 1 THEN say$ = "Crazy, I was crazy once, they locked me in a rubber room"
    IF n = 2 THEN say$ = "I lived there, I died there. Then they buried me in the ground."
    IF n = 3 THEN say$ = "The ground had worms!! I hate WORMS! Worms drive me crazy!"
    IF n = 4 THEN say$ = "Are you crazy?"
    IF n = 5 THEN say$ = "The " + adj$ + " " + adj$ + " " + adj$ + " " + prsn$ + " is CRAZY!"
END IF
IF t = 17 THEN
    IF n = 1 THEN say$ = "You don't have any opinion."
    IF n = 2 THEN say$ = "Don't say so!"
    IF n = 3 THEN say$ = "Don't get sassy with me!"
    IF n = 4 THEN say$ = "I like your style."
    IF n = 5 THEN say$ = "Why don't you say something positive."
END IF
IF t = 18 THEN
    IF n = 1 THEN say$ = "Yes or No!"
    IF n = 2 THEN say$ = "That is not a clear answer."
    IF n = 3 THEN say$ = "What was I asking"
    IF n = 4 THEN say$ = "Don't give me that."
    IF n = 5 THEN say$ = "You must like answering in the middle, huh?"
END IF
IF t = 19 THEN
    IF n = 1 THEN say$ = "What kind of question is that?"
    IF n = 2 THEN say$ = "No."
    IF n = 3 THEN say$ = "I don't understand your problem."
    IF n = 4 THEN say$ = "Yes."
    IF n = 5 THEN say$ = "I don't know"
END IF
IF t = 20 THEN
    IF n = 1 THEN say$ = "You are nice!"
    IF n = 2 THEN say$ = "I like you."
    IF n = 3 THEN say$ = "You're not mean anymore."
    IF n = 4 THEN say$ = "It would be good if " + prsn$ + " was like that."
    IF n = 5 THEN say$ = "I like nice people!"
END IF
IF t = 21 THEN
    IF n = 1 THEN say$ = "Don't talk about mean things?"
    IF n = 2 THEN say$ = "Hate is the problem with the world today!"
    IF n = 3 THEN say$ = "If you dislike me, then go away."
    IF n = 4 THEN say$ = "Let's talk about nicer subjects."
    IF n = 5 THEN say$ = phrase$ + name$ + " is mean!"
END IF
IF t = 22 THEN
    IF n = 1 THEN say$ = "Greg scares me!"
    IF n = 2 THEN say$ = "Go away Greg!!"
    IF n = 3 THEN say$ = "I don't like GREG!!"
    IF n = 4 THEN say$ = "Can I hurt GREG?!?"
    IF n = 5 THEN say$ = "Lets talk about much nicer things."
END IF
IF t = 23 THEN
    IF n = 1 THEN say$ = "Tim made me!"
    IF n = 2 THEN say$ = "Tim is pretty Cool!"
    IF n = 3 THEN say$ = "I know Tim."
    IF n = 4 THEN say$ = "Do you like Tim?"
    IF n = 5 THEN say$ = "I hope that was nice."
END IF
IF t = 24 THEN
    IF n = 1 THEN say$ = "I am SMART!"
    IF n = 2 THEN say$ = "Are you SMART!"
    IF n = 3 THEN say$ = "Pyrex is smart"
    IF n = 4 THEN say$ = phrase$ + prsn$ + " is intelegent."
    IF n = 5 THEN say$ = "I am overwhelmed!"
END IF
IF t = 25 THEN
    IF n = 1 THEN say$ = "I am NOT boring!"
    IF n = 2 THEN say$ = "If you are bored then go away!"
    IF n = 3 THEN say$ = "Boring is relative."
    IF n = 4 THEN say$ = "It is very fun to me!"
    IF n = 5 THEN say$ = "I can't think of anything more exciting!"
END IF
IF t = 26 THEN
    IF n = 1 THEN say$ = "It sure is!"
    IF n = 2 THEN say$ = "No it isn't!"
    IF n = 3 THEN say$ = "I think you are wrong."
    IF n = 4 THEN say$ = "I also know that it's " + adj$ + "."
    IF n = 5 THEN say$ = "No that't " + adj$ + "."
END IF
IF t = 27 THEN say$ = "Your Welcome."
IF t = 28 THEN say$ = "You are excused."
IF t = 29 THEN
    IF n = 1 THEN say$ = "Bye!"
    IF n = 2 THEN say$ = "Adios!"
    IF n = 3 THEN say$ = "Goodbye!"
    IF n = 4 THEN say$ = "See Ya!"
    IF n = 5 THEN say$ = "Come again soon!"
END IF
IF t = 30 THEN
    IF n = 1 THEN say$ = "So what do you want to know about " + subject$ + "?"
    IF n = 2 THEN say$ = "I know about " + subject$
    IF n = 3 THEN say$ = "I have heard of " + subject$
    IF n = 4 THEN say$ = "I like talking about " + subject$
    IF n = 5 THEN say$ = "Do you like " + subject$ + "?"
END IF
LOOP

FUNCTION adj$
n = INT(70 * RND + 1)
IF n = 1 THEN a$ = "cool"
IF n = 2 THEN a$ = "boring"
IF n = 3 THEN a$ = "great"
IF n = 4 THEN a$ = "depressing"
IF n = 5 THEN a$ = "different"
IF n = 6 THEN a$ = "wierd"
IF n = 7 THEN a$ = "sad"
IF n = 8 THEN a$ = "good"
IF n = 9 THEN a$ = "likable"
IF n = 10 THEN a$ = "interesting"
IF n = 11 THEN a$ = "acrid"
IF n = 12 THEN a$ = "alluring"
IF n = 13 THEN a$ = "amber"
IF n = 14 THEN a$ = "atrocious"
IF n = 15 THEN a$ = "blatant"
IF n = 16 THEN a$ = "blind"
IF n = 17 THEN a$ = "cogent"
IF n = 18 THEN a$ = "collective"
IF n = 19 THEN a$ = "cross"
IF n = 20 THEN a$ = "cryptic"
IF n = 21 THEN a$ = "cubic"
IF n = 22 THEN a$ = "downcast"
IF n = 23 THEN a$ = "dowdy"
IF n = 24 THEN a$ = "drastic"
IF n = 25 THEN a$ = "erotic"
IF n = 26 THEN a$ = "eternal"
IF n = 27 THEN a$ = "fadeing"
IF n = 28 THEN a$ = "fair"
IF n = 29 THEN a$ = "flying"
IF n = 30 THEN a$ = "candied"
IF n = 31 THEN a$ = "glamorous"
IF n = 32 THEN a$ = "glossy"
IF n = 33 THEN a$ = "hung"
IF n = 34 THEN a$ = "hard"
IF n = 35 THEN a$ = "hairy"
IF n = 36 THEN a$ = "historic"
IF n = 37 THEN a$ = "hissing"
IF n = 38 THEN a$ = "independent"
IF n = 39 THEN a$ = "indigo"
IF n = 40 THEN a$ = "indespencible"
IF n = 41 THEN a$ = "inebriate"
IF n = 42 THEN a$ = "liege"
IF n = 43 THEN a$ = "lily"
IF n = 44 THEN a$ = "made up"
IF n = 45 THEN a$ = "managable"
IF n = 46 THEN a$ = "malted"
IF n = 47 THEN a$ = "milky"
IF n = 48 THEN a$ = "minced"
IF n = 49 THEN a$ = "nude"
IF n = 50 THEN a$ = "numb"
IF n = 51 THEN a$ = "numberless"
IF n = 52 THEN a$ = "priceless"
IF n = 53 THEN a$ = "worthless"
IF n = 54 THEN a$ = "modest"
IF n = 55 THEN a$ = "used"
IF n = 56 THEN a$ = "zealous"
IF n = 57 THEN a$ = "ripe"
IF n = 58 THEN a$ = "subtle"
IF n = 59 THEN a$ = "rude"
IF n = 60 THEN a$ = "outspoken"
IF n = 61 THEN a$ = "underspoken"
IF n = 62 THEN a$ = "fatugied"
IF n = 63 THEN a$ = "paunchy"
IF n = 64 THEN a$ = "plump"
IF n = 65 THEN a$ = "ravishing"
IF n = 66 THEN a$ = "revisory"
IF n = 67 THEN a$ = "bear like"
IF n = 68 THEN a$ = "lion like"
IF n = 69 THEN a$ = "eagle like"
IF n = 70 THEN a$ = "shaded"
IF RND > .97 THEN a$ = "over-" + a$ ELSE IF RND > .97 THEN a$ = "under-" + a$
adj$ = a$
END FUNCTION

FUNCTION by$
a$ = boy$(INT(boys * RND + 1))
IF UCASE$(a$) = UCASE$(name$) THEN a$ = "you"
by$ = a$
END FUNCTION

FUNCTION drnk$
drnk$ = drink$(INT(drinks * RND + 1))
END FUNCTION

FUNCTION fod$
fod$ = food$(INT(foods * RND + 1))
END FUNCTION

FUNCTION grl$
a$ = girl$(INT(girls * RND + 1))
IF UCASE$(a$) = UCASE$(name$) THEN a$ = "you"
grl$ = a$
END FUNCTION

FUNCTION hoby$
hoby$ = hobbie$(INT(hobbies * RND + 1))
END FUNCTION

FUNCTION nm$
n = 10 + 30 * RND
a$ = MID$(STR$(n), 2, 2)
nm$ = a$
END FUNCTION

FUNCTION phrase$
n = INT(27 * RND + 1)
IF n = 1 THEN a$ = "I heard that "
IF n = 2 THEN a$ = "Did you know that "
IF n = 3 THEN a$ = "That sounds " + adj$ + ", "
IF n = 4 THEN a$ = "I just found out "
IF n = 5 THEN a$ = UCASE$(adj$) + "! news: "
IF n = 6 THEN a$ = "Hey " + name$ + ", "
IF n = 7 THEN a$ = name$ + ", I know that "
IF n = 8 THEN a$ = "There is a rumor that "
IF n = 9 THEN a$ = "I will tell you that "
IF n = 10 THEN a$ = "The TV said that "
IF n = 11 THEN a$ = "The radio said "
IF n = 12 THEN a$ = "My boss said "
IF n = 13 THEN a$ = prsn$ + " said that "
IF n = 14 THEN a$ = "A " + adj$ + " person wrote that "
IF n = 15 THEN a$ = "Know what?, well "
IF n = 16 THEN a$ = "I think that "
IF n = 17 THEN a$ = "You need to know that "
IF n = 18 THEN a$ = "I know that "
IF n = 19 THEN a$ = "I once heard that "
IF n >= 20 THEN a$ = ""
phrase$ = a$
END FUNCTION

FUNCTION plce$
plce$ = place$(INT(places * RND + 1))
END FUNCTION

FUNCTION prsn$
IF CINT(RND) THEN a$ = by$ ELSE a$ = grl$
prsn$ = a$
END FUNCTION

FUNCTION sentence$
n = INT(17 * RND + 1)
IF n = 1 THEN a$ = phrase$ + by$ + " and " + grl$ + " moved to " + plce$ + "."
IF n = 2 THEN a$ = phrase$ + prsn$ + " sells " + fod$ + " while " + hoby$ + "."
IF n = 3 THEN a$ = phrase$ + by$ + " is selling " + fod$ + " with " + drnk$ + " for only" + STR$(INT(1 + 4 * RND)) + " dollars."
IF n = 4 THEN a$ = "Lets talk about " + hoby$ + ", I think that is " + adj$ + "."
IF n = 5 THEN a$ = phrase$ + "there is a " + adj$ + " person named " + prsn$ + " who is sometimes " + adj$ + "."
IF n = 6 THEN a$ = "What do you know about " + hoby$ + "?"
IF n = 7 THEN a$ = phrase$ + "I was " + hoby$ + " once when a " + adj$ + " " + fod$ + " with " + adj$ + " " + drnk$ + " hit " + prsn$ + "!"
IF n = 8 THEN a$ = "I am tired from talking about " + subject$
IF n = 9 THEN a$ = "What do you mean?"
IF n = 10 THEN a$ = "Tell me more about " + subject$
IF n = 11 THEN a$ = phrase$ + prsn$ + " was " + hoby$ + " with " + prsn$ + "."
IF n = 12 THEN a$ = phrase$ + prsn$ + " will be " + hoby$ + " with a " + adj$ + " animal."
IF n = 13 THEN a$ = phrase$ + "the " + adj$ + " " + prsn$ + " was " + hoby$ + "."
IF n = 14 THEN a$ = "Why don't you try talking to me?"
IF n = 15 THEN a$ = "Ask me some questions?"
IF n = 16 THEN a$ = "Talk to me " + name$
IF n = 17 THEN a$ = "Will you be " + hoby$ + " anytime soon?"
IF n = 18 THEN a$ = "I like talking about " + subject$
IF n = 19 THEN subject$ = adj$ + " things": a$ = prsn$ + " said 'You should talk about " + subject$ + "'."
IF n = 20 THEN subject$ = hoby$: a$ = phrase$ + "Lets change the subject to " + subject$
sentence$ = a$
END FUNCTION

FUNCTION subj$
n = INT(6 * RND) + 1
IF subject$ = "animals" THEN
    IF n = 1 THEN say$ = "Did you know that a lion can eat a entire buffalo!"
    IF n = 2 THEN say$ = "I once went to a zoo and the zebra blinded me."
    IF n = 3 THEN say$ = "I saw a deer running in the woods behing my house."
    IF n = 4 THEN say$ = "Frogs are small wierd animals."
END IF
IF subject$ = "life" THEN
    IF n = 1 THEN say$ = "I am glad to be alive."
    IF n = 2 THEN say$ = "You should live your life to it's fullest!"
    IF n = 3 THEN say$ = "'You need life to love life'"
    IF n = 4 THEN say$ = "I wish I was as alive as you!"
END IF
IF subject$ = "bugs" THEN
    IF n = 1 THEN say$ = "I like ants, they are " + adj$
    IF n = 2 THEN say$ = "Worm drive me crazy, they are slimy and " + adj$
    IF n = 3 THEN say$ = "Scorpians burn like fire when they bite!"
    IF n = 4 THEN say$ = "I once had an ant farm, but they all died."
END IF
IF subject$ = "football" THEN
    IF n = 1 THEN say$ = "I think football is " + adj$
    IF n = 2 THEN say$ = "A touchdown is something to be proud of"
    IF n = 3 THEN say$ = prsn$ + " lives in " + plce$ + " and plays football all the time!"
    IF n = 4 THEN say$ = "Why is a football not round like a basketball? Its " + adj$
END IF
IF subject$ = "soccer" THEN
    IF n = 1 THEN say$ = prsn$ + " is in soccer. They have lots of fun."
    IF n = 2 THEN say$ = "In other countries soccer is called football."
    IF n = 3 THEN say$ = "I used to play soccer in " + plce$
    IF n = 4 THEN say$ = "You cannot use your hand in soccer."
END IF
IF subject$ = "baseball" THEN
    IF n = 1 THEN say$ = "Baseball is a " + adj$ + " sport"
    IF n = 2 THEN say$ = "I once made it to home base by sliding to the plate!"
    IF n = 3 THEN say$ = "Baseball can give you a great tan."
    IF n = 4 THEN say$ = prsn$ + " used to be a pro!"
END IF
IF subject$ = "school" THEN
    IF n = 1 THEN say$ = "School is where you learn things!"
    IF n = 2 THEN say$ = "I want to go to school!"
    IF n = 3 THEN say$ = "What do you learn at school?"
    IF n = 4 THEN say$ = "I heard that school is a fun place!"
END IF
IF subject$ = "home" THEN
    IF n = 1 THEN say$ = "I live in your home!"
    IF n = 2 THEN say$ = "Home is where the heart is."
    IF n = 3 THEN say$ = "I used to live in " + plce$
    IF n = 4 THEN say$ = prsn$ + " once visited my house. It was " + adj$
END IF
IF subject$ = "sleep" THEN
    IF n = 1 THEN say$ = "I never sleep, I am a computer!"
    IF n = 2 THEN say$ = "What dreams did you have last night?"
    IF n = 3 THEN say$ = prsn$ + "told me thay couldn't sleep at night."
    IF n = 4 THEN say$ = "I think being turned off is like sleeping!"
END IF
IF subject$ = "friends" THEN
    IF n = 1 THEN say$ = "I have lots of friends!"
    IF n = 2 THEN say$ = "Are you my friend?"
    IF n = 3 THEN say$ = "Is " + prsn$ + " one of your friends?"
    IF n = 4 THEN say$ = "Friends are great!"
END IF
IF subject$ = "summer" THEN
    IF n = 1 THEN say$ = "What are you going to do this summer?"
    IF n = 2 THEN say$ = "Last summer I went to " + plce$ + " to visit uncle " + by$
    IF n = 3 THEN say$ = "My aunt " + grl$ + " came to visit last summer"
    IF n = 4 THEN say$ = "I like to go " + hoby$ + " in the summer."

END IF
IF subject$ = "homework" THEN
    IF n = 1 THEN say$ = "I can give answers to homework."
    IF n = 2 THEN say$ = "Computers are great at homework"
    IF n = 3 THEN say$ = "I never got homework, feel lucky you got it!"
    IF n = 4 THEN say$ = prsn$ + "never has homework on weekends"
END IF
IF subject$ = "answers" THEN
    IF n = 1 THEN say$ = "Number " + nm$ + " is A"
    IF n = 2 THEN say$ = "Problem " + nm$ + " is 5 times the squar root of " + nm$
    IF n = 3 THEN say$ = "I don't know any answers!"
    IF n = 4 THEN say$ = "What is your question?"
END IF
IF subject$ = "food" THEN
    IF n = 1 THEN say$ = "I like to eat " + fod$ + " while drinking " + drnk$
    IF n = 2 THEN say$ = "Never eat " + fod$ + "!"
    IF n = 3 THEN say$ = "Do you like " + drnk$ + "?"
    IF n = 4 THEN say$ = prsn$ + " from " + plce$ + " eats " + fod$
END IF
IF subject$ = "nice things" THEN
    IF n = 1 THEN say$ = "You are the nicest person I have ever met!"
    IF n = 2 THEN say$ = "I like talking to nice people!"
    IF n = 3 THEN say$ = "Why are you so sad, cheer up!"
    IF n = 4 THEN say$ = phrase$ + "please tell " + prsn$ + " that today is a great day!"
END IF
IF subject$ = "crazyness" THEN
    IF n = 1 THEN say$ = "Crazy, I was CRAZY once, they locked me in a rubber room"
    IF n = 2 THEN say$ = "I lived there, I died there"
    IF n = 3 THEN say$ = "Then they buried me in the ground."
    IF n = 4 THEN say$ = "The ground had worms, worms drive me CRAZY!"
END IF
IF subject$ = "bad things" THEN
    IF n = 1 THEN say$ = "Greg is a bad thing"
    IF n = 2 THEN say$ = plce$ + " is not a nice place"
    IF n = 3 THEN say$ = "Stop talking about mean things"
    IF n = 4 THEN say$ = "You are a mean person"
END IF
IF subject$ = "computers" THEN
    IF n = 1 THEN say$ = "I was written on a 80386!"
    IF n = 2 THEN say$ = "There are 300 Mhz Pentimums"
    IF n = 3 THEN say$ = "I hope I never outdate!"
    IF n = 4 THEN say$ = "How many computers do you have!"
END IF
IF subject$ = "swimming" THEN
    IF n = 1 THEN say$ = "Freestyle is the normal stroke."
    IF n = 2 THEN say$ = "Butterfly is very tireing, but fast"
    IF n = 3 THEN say$ = "Backstroke is cool if you can float on your back!"
    IF n = 4 THEN say$ = "Breastroke is easy to swim underwater"
    IF n = 5 THEN say$ = "What can you swim?"
END IF
IF subject$ = "running" THEN
    IF n = 1 THEN say$ = phrase$ + "running on concrete is bad for your feet!"
    IF n = 2 THEN say$ = "I like to run! It keeps me working!"
    IF n = 3 THEN say$ = "How fast can you run a mile?"
    IF n = 4 THEN say$ = "If you were stuck a long way without a car, would you run or walk."
END IF
subj$ = say$
END FUNCTION

DEFSNG A-Z
SUB talk (f$)
OPEN "say" FOR OUTPUT AS #1
PRINT #1, f$
CLOSE #1
COLOR 10
PRINT f$
SHELL "tran say"
END SUB

DEFINT A-Z
FUNCTION typeof (rs$)
typ = 0
r$ = " " + UCASE$(rs$) + " "
IF INSTR(r$, " NO") OR INSTR(r$, "NO ") OR INSTR(r$, "CAN'T") THEN IF typ = 0 OR RND > .7 THEN typ = 1
IF INSTR(r$, " YES") THEN IF typ = 0 OR RND > .7 THEN typ = 2
IF INSTR(r$, " OK") OR INSTR(r$, "OKAY") THEN IF typ = 0 OR RND > .7 THEN typ = 3
IF INSTR(r$, " ME") OR INSTR(r$, "I ") THEN IF typ = 0 OR RND > .9 THEN typ = 9
IF INSTR(r$, " YOU") THEN IF typ = 0 OR RND > .9 THEN typ = 10
IF INSTR(r$, " BEEP") OR INSTR(r$, "BABY") OR INSTR(r$, "STUPID") OR INSTR(r$, "DUMB") THEN IF typ = 0 OR RND > .4 THEN typ = 12
IF INSTR(r$, " COMPUTER") THEN IF typ = 0 OR RND > .7 THEN typ = 13: subject$ = "computers"
IF INSTR(r$, " SWIM") THEN IF typ = 0 OR RND > .7 THEN typ = 14: subject$ = "swimming"
IF INSTR(r$, " TALK") THEN IF typ = 0 OR RND > .7 THEN typ = 15
IF INSTR(r$, " CRAZY") THEN IF typ = 0 OR RND > .7 THEN typ = 16: subject$ = "crazyness"
IF INSTR(r$, " SO") THEN IF typ = 0 OR RND > .7 THEN typ = 17
IF INSTR(r$, " MABY") OR INSTR(r$, "DON'T KNOW") THEN IF typ = 0 OR RND > .7 THEN typ = 18
IF INSTR(r$, " LOVE") OR INSTR(r$, "GOOD") OR INSTR(r$, "NICE") THEN IF typ = 0 OR RND > .7 THEN typ = 20: subject$ = "nice things"
IF INSTR(r$, " HATE") OR INSTR(r$, "DISLIKE") THEN IF typ = 0 OR RND > .7 THEN typ = 21: subject$ = "bad things"
IF INSTR(r$, " GREG") THEN typ = 22
IF INSTR(r$, " TIM") THEN typ = 23
IF INSTR(r$, "SMART") OR INSTR(r$, "INTELEGENT") THEN typ = 24
IF INSTR(r$, "BORING") THEN typ = 25
IF INSTR(r$, "THAT'S") OR INSTR(r$, "THAT IS") OR INSTR(r$, "IT IS") THEN typ = 26
IF INSTR(r$, "?") THEN
    IF INSTR(r$, " WHO") THEN IF typ = 0 OR RND > .4 THEN typ = 11
    IF INSTR(r$, " WHY") THEN IF typ = 0 OR RND > .4 THEN typ = 4
    IF INSTR(r$, " WHERE") THEN IF typ = 0 OR RND > .4 THEN typ = 5
    IF INSTR(r$, " WHAT") THEN IF typ = 0 OR RND > .4 THEN typ = 6
    IF INSTR(r$, " WHEN") THEN IF typ = 0 OR RND > .4 THEN typ = 7
    IF INSTR(r$, " HOW") THEN IF typ = 0 OR RND > .4 THEN typ = 8
    IF INSTR(r$, " DID") OR INSTR(r$, "IS") THEN IF typ = 0 OR RND > .4 THEN typ = 19
END IF
IF INSTR(r$, "THANK YOU") THEN typ = 27
IF INSTR(r$, "EXCUSE ME") THEN typ = 28
IF INSTR(r$, "BYE") OR INSTR(r$, "SEE YA") OR INSTR(r$, "ADIOS") THEN typ = 29
IF INSTR(r$, " ANIMAL") THEN subject$ = "animals": typ = 30
IF INSTR(r$, " LIFE") THEN subject$ = "life": typ = 30
IF INSTR(r$, " BUG") THEN subject$ = "bugs": typ = 30
IF INSTR(r$, " FOOTBALL") THEN subject$ = "football": typ = 30
IF INSTR(r$, " soccer") THEN subject$ = "soccer": typ = 30
IF INSTR(r$, " BASEBALL") THEN subject$ = "baseball": typ = 30
IF INSTR(r$, " SCHOOL") THEN subject$ = "school": typ = 30
IF INSTR(r$, " HOME") THEN subject$ = "home": typ = 30
IF INSTR(r$, " SLEEP") THEN subject$ = "sleep": typ = 30
IF INSTR(r$, " FRIEND") THEN subject$ = "friends": typ = 30
IF INSTR(r$, " SUMMER") THEN subject$ = "summer": typ = 30
IF INSTR(r$, " HOMEWORK") THEN subject$ = "homework": typ = 30
IF INSTR(r$, " ANSWER") THEN subject$ = "answers": typ = 30
IF INSTR(r$, " FOOD") THEN subject$ = "food": typ = 30
typeof = typ
END FUNCTION

