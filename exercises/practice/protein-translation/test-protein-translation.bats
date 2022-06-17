#!/usr/bin/env bats
load bats-extra

# Translate input RNA sequences into proteins
@test "Empty RNA sequence results in no proteins" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< ""
    assert_success
    assert_output ""
}

@test "Methionine RNA sequence" {       
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "AUG"
    assert_success
    assert_output "Methionine"
}

@test "Phenylalanine RNA sequence 1" {  
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UUU"
    assert_success
    assert_output "Phenylalanine"
}

@test "Phenylalanine RNA sequence 2" {  
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UUC"
    assert_success
    assert_output "Phenylalanine"
}

@test "Leucine RNA sequence 1" {        
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UUA"
    assert_success
    assert_output "Leucine"
}

@test "Leucine RNA sequence 2" {        
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UUG"
    assert_success
    assert_output "Leucine"
}

@test "Serine RNA sequence 1" { 
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UCU"
    assert_success
    assert_output "Serine"
}

@test "Serine RNA sequence 2" { 
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UCC"
    assert_success
    assert_output "Serine"
}

@test "Serine RNA sequence 3" { 
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UCA"
    assert_success
    assert_output "Serine"
}

@test "Serine RNA sequence 4" { 
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UCG"
    assert_success
    assert_output "Serine"
}

@test "Tyrosine RNA sequence 1" {       
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UAU"
    assert_success
    assert_output "Tyrosine"
}

@test "Tyrosine RNA sequence 2" {       
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UAC"
    assert_success
    assert_output "Tyrosine"
}

@test "Cysteine RNA sequence 1" {       
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UGU"
    assert_success
    assert_output "Cysteine"
}

@test "Cysteine RNA sequence 2" {       
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UGC"
    assert_success
    assert_output "Cysteine"
}

@test "Tryptophan RNA sequence" {       
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UGG"
    assert_success
    assert_output "Tryptophan"
}

@test "STOP codon RNA sequence 1" {     
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UAA"
    assert_success
    assert_output ""
}

@test "STOP codon RNA sequence 2" {     
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UAG"
    assert_success
    assert_output ""
}

@test "STOP codon RNA sequence 3" {     
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UGA"
    assert_success
    assert_output ""
}

@test "Sequence of two protein codons translates into proteins" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UUUUUU"
    assert_success
    assert_output "Phenylalanine Phenylalanine"
}

@test "Sequence of two different protein codons translates into proteins" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UUAUUG"
    assert_success
    assert_output "Leucine Leucine"
}

@test "Translate RNA strand into correct protein list" {        
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "AUGUUUUGG"
    assert_success
    assert_output "Methionine Phenylalanine Tryptophan"
}

@test "Translation stops if STOP codon at beginning of sequence" {      
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UAGUGG"
    assert_success
    assert_output ""
}

@test "Translation stops if STOP codon at end of two-codon sequence" {  
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UGGUAG"
    assert_success
    assert_output "Tryptophan"
}

@test "Translation stops if STOP codon at end of three-codon sequence" {        
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "AUGUUUUAA"
    assert_success
    assert_output "Methionine Phenylalanine"
}

@test "Translation stops if STOP codon in middle of three-codon sequence" {     
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UGGUAGUGG"
    assert_success
    assert_output "Tryptophan"
}

@test "Translation stops if STOP codon in middle of six-codon sequence" {       
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UGGUGUUAUUAAUGGUUU"
    assert_success
    assert_output "Tryptophan Cysteine Tyrosine"
}

@test "Error case" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UGG---AUG"
    assert_failure
    assert_output "Invalid codon"
}

@test "Non-existing codon can't translate" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "AAA"
    assert_failure
    assert_output "Invalid codon"
}

@test "Unknown amino acids, not part of a codon, can't translate" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "XYZ"
    assert_failure
    assert_output "Invalid codon"
}

@test "Incomplete RNA sequence can't translate" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "AUGU"
    assert_failure
    assert_output "Invalid codon"
}

@test "Incomplete RNA sequence can translate if valid until a STOP codon" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f protein-translation.awk <<< "UUCUUCUAAUGGU"
    assert_success
    assert_output "Phenylalanine Phenylalanine"
}
