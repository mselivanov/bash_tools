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

  printf ${_char}
}

run_tests() {
  printf "Running tests...\n"
  # Test ucase
  if [[ "A" != $(ucase "a") ]] 
  then
    printf "ucase 'a' must be equal 'A'"
    exit 1
  else
    printf "ucase 'a' test passed\n"
  fi

  exit 0
}

run_tests
