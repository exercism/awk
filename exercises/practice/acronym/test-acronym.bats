#!/usr/bin/env bats
load bats-extra

@test 'basic' {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f acronym.awk <<< 'Portable Network Graphics'
  assert_success
  assert_output 'PNG'
}

@test 'lowercase words' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f acronym.awk <<< 'Ruby on Rails'
  assert_success
  assert_output 'ROR'
}

@test 'punctuation' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f acronym.awk <<< 'First In, First Out'
  assert_success
  assert_output 'FIFO'
}

@test 'all caps word' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f acronym.awk <<< 'GNU Image Manipulation Program'
  assert_success
  assert_output 'GIMP'
}

@test 'punctuation without whitespace' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f acronym.awk <<< 'Complementary metal-oxide semiconductor'
  assert_success
  assert_output 'CMOS'
}

@test 'very long abbreviation' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f acronym.awk <<< 'Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me'
  assert_success
  assert_output 'ROTFLSHTMDCOALM'
}

@test "consecutive delimiters" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f acronym.awk <<< "Something - I made up from thin air"
  assert_success
  assert_output "SIMUFTA"
}

@test "apostrophes" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f acronym.awk <<< "Halley's Comet"
  assert_success
  assert_output "HC"
}

@test "underscore emphasis" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run gawk -f acronym.awk <<< "The Road __Not__ Taken"
  assert_success
  assert_output "TRNT"
}
