#!/usr/bin/env bats

load bats-extra

@test "puzzle with three letters" {
  run awk -f alphametics.awk <<< "I + BB == ILL"
  assert_success
  assert_output "B=9 I=1 L=0"
}

@test "solution must have unique value for each letter" {
  run awk -f alphametics.awk <<< "A == B"
  assert_success
  assert_output ""
}

@test "leading zero solution is invalid" {
  run awk -f alphametics.awk <<< "ACA + DD == BD"
  assert_success
  assert_output ""
}

@test "puzzle with two digits final carry" {
  run awk -f alphametics.awk <<< "A + A + A + A + A + A + A + A + A + A + A + B == BCC"
  assert_success
  assert_output "A=9 B=1 C=0"
}

@test "puzzle with four letters" {
  run awk -f alphametics.awk <<< "AS + A == MOM"
  assert_success
  assert_output "A=9 M=1 O=0 S=2"
}

@test "puzzle with six letters" {
  run awk -f alphametics.awk <<< "NO + NO + TOO == LATE"
  assert_success
  assert_output "A=0 E=2 L=1 N=7 O=4 T=9"
}

@test "puzzle with seven letters" {
  run awk -f alphametics.awk <<< "HE + SEES + THE == LIGHT"
  assert_success
  assert_output "E=4 G=2 H=5 I=0 L=1 S=9 T=7"
}

@test "puzzle with eight letters" {
  run awk -f alphametics.awk <<< "SEND + MORE == MONEY"
  assert_success
  assert_output "D=7 E=5 M=1 N=6 O=0 R=8 S=9 Y=2"
}

@test "puzzle with ten letters" {
  run awk -f alphametics.awk <<< "AND + A + STRONG + OFFENSE + AS + A + GOOD == DEFENSE"
  assert_success
  assert_output "A=5 D=3 E=4 F=7 G=8 N=0 O=2 R=1 S=6 T=9"
}

@test "puzzle with ten letters and 199 addends" {
  run awk -f alphametics.awk <<< "THIS + A + FIRE + THEREFORE + FOR + ALL + HISTORIES + I + TELL + A + TALE + THAT + FALSIFIES + ITS + TITLE + TIS + A + LIE + THE + TALE + OF + THE + LAST + FIRE + HORSES + LATE + AFTER + THE + FIRST + FATHERS + FORESEE + THE + HORRORS + THE + LAST + FREE + TROLL + TERRIFIES + THE + HORSES + OF + FIRE + THE + TROLL + RESTS + AT + THE + HOLE + OF + LOSSES + IT + IS + THERE + THAT + SHE + STORES + ROLES + OF + LEATHERS + AFTER + SHE + SATISFIES + HER + HATE + OFF + THOSE + FEARS + A + TASTE + RISES + AS + SHE + HEARS + THE + LEAST + FAR + HORSE + THOSE + FAST + HORSES + THAT + FIRST + HEAR + THE + TROLL + FLEE + OFF + TO + THE + FOREST + THE + HORSES + THAT + ALERTS + RAISE + THE + STARES + OF + THE + OTHERS + AS + THE + TROLL + ASSAILS + AT + THE + TOTAL + SHIFT + HER + TEETH + TEAR + HOOF + OFF + TORSO + AS + THE + LAST + HORSE + FORFEITS + ITS + LIFE + THE + FIRST + FATHERS + HEAR + OF + THE + HORRORS + THEIR + FEARS + THAT + THE + FIRES + FOR + THEIR + FEASTS + ARREST + AS + THE + FIRST + FATHERS + RESETTLE + THE + LAST + OF + THE + FIRE + HORSES + THE + LAST + TROLL + HARASSES + THE + FOREST + HEART + FREE + AT + LAST + OF + THE + LAST + TROLL + ALL + OFFER + THEIR + FIRE + HEAT + TO + THE + ASSISTERS + FAR + OFF + THE + TROLL + FASTS + ITS + LIFE + SHORTER + AS + STARS + RISE + THE + HORSES + REST + SAFE + AFTER + ALL + SHARE + HOT + FISH + AS + THEIR + AFFILIATES + TAILOR + A + ROOFS + FOR + THEIR + SAFE == FORTRESSES"
  assert_success
  assert_output "A=1 E=0 F=5 H=8 I=7 L=2 O=6 R=3 S=4 T=9"
}
