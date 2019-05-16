#!/bin/env bash

# Takes a-z character as an input in $1
# Returns: character in upper-case
ucase() {
  _char=
  case $1 in 
    [a-z]) _char=${1^}
    ;;
    *) _char=${1}
    ;;
  esac

  printf "${_char}"
}

run_tests() {
  printf "Running tests...\n"
  # Test ucase
  if [[ "A" != $(ucase "a") ]] 
  then
    printf "ucase 'a' must be equal to 'A'"
    exit 1
  else
    printf "ucase 'a' test passed\n"
  fi

  if [[ "" != $(ucase "") ]] 
  then
    printf "ucase '' must be equal to ''"
    exit 1
  else
    printf "ucase '' test passed\n"
  fi

  if [[ "Z" != $(ucase "z") ]] 
  then
    printf "ucase 'z' must be equal to 'Z'\n"
    exit 1
  else
    printf "ucase 'z' test passed\n"
  fi
  
  exit 0
}

run_tests
