Mahjong Code Challenge
======================

Mahjong is a tile based game where players must form a hand of 12 tiles.

There are 136 tiles, divided into 3 suites(Bamboos, Characters, Circles) and 2 honors(Dragons, Winds).
Each tile in a suite has a number ranging from 1 to 9.
There are 4 winds: East, South, West, North.
There are 3 dragons: Red, Green, White.

Only 1 suite can be used in a hand, with the exclusion of the Winds and Dragons.

A valid hand must be made up of 4 pongs. 
A pong is a either:
- a triple of the same number and suite (e.g. 5 Character, 5 Character, 5 Character)
- a triple sequence of numbers in the same suite (e.g. 1 Bamboo, 2 Bamboo, 3 Bamboo) - Only 1 of these are allowed in a hand
- a triple of the same honor (e.g. Red Dragon, Red Dragon, Red Dragon) - Only 1 of these are allowed in a hand

Write a program which takes in a csv file as an argument and outputs if the hand is valid or invalid. A sample csv of the input format expected is attached, as well as the list below which defines all input formats.

Expected values for a tile are:
- Bamboo: BAM1 - BAM9
- Character: CHA1 - CHA9
- Circle: CIR1 - CIR9
- Dragons (Red, Green, White) DRR, DRG, DRW
- Winds (East, South, West, North) WIE, WIS, WIW, WIN


### Usage
You can run the program with some sample data using

```
./mahjong.rb -i samples/samples.csv
```

If working correctly, this should print
```
true
true
true
false
```
