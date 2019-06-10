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

lcase() {
  _char=
  case $1 in 
    [A-Z]) _char=${1,}
    ;;
    *) _char=${1}
    ;;
  esac

  printf "${_char}"
}

to_lower() {
  _result=
  _input=$1


  _input_max_idx=$(( ${#1}-1 ))
  _curr_idx=0
  while [[ ${_curr_idx} -le ${_input_max_idx} ]]
  do
    _result=${_result}"$(lcase ${_input:${_curr_idx}:1})"
    _curr_idx=$(( ${_curr_idx} + 1 ))
  done

  printf "${_result}"
}

ltrim() {
  _result=$1
 
 while [ "${_result:0:1}" == " " ]
 do
   _result="${_result##\ }"
 done

 printf "${_result}"
}

rtrim() {
  _result=$1
 
  while [ "${_result:$(( ${#_result}-1 )):1}" == " " ]
 do
   _result="${_result%%\ }"
 done

 printf "${_result}"
}

remove_non_chars() {
  _result=
  _input=$1

  _max_idx=$(( ${#_input}-1 ))
  _curr_idx=0

  while [[ ${_curr_idx} -le ${_max_idx} ]]
  do
    _curr_char=${_input:${_curr_idx}:1}	  
    if [[ ${_curr_char} =~ [a-zA-Z] ]]
    then
      _result=${_result}${_curr_char}
    fi
    _curr_idx=$(( ${_curr_idx}+1 ))
  done
  printf "${_result}"
}

is_palindrome() {
  _result=
  _input=$1

  _input="$(to_lower "$(remove_non_chars "${_input}")")"
  _mid_idx=$(( ${#_input}/2-1 ))
  _curr_idx=0
  _max_idx=$(( ${#_input}-1 ))
  while [[ ${_curr_idx} -le ${_mid_idx} ]]
  do
    _s_char=${_input:${_curr_idx}:1}
    _e_char=${_input:$(( ${_max_idx}-${_curr_idx} )):1}

    if [[ ${_s_char} != ${_e_char} ]]	  
    then
      printf "0"
      return
    fi
    _curr_idx=$(( ${_curr_idx} + 1 ))
  done

  printf "1"

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
  
  if [[ "a" != $(lcase "A") ]] 
  then
    printf "lcase 'A' must be equal to 'a'"
    exit 1
  else
    printf "lcase 'A' test passed\n"
  fi

  if [[ "" != $(lcase "") ]] 
  then
    printf "lcase '' must be equal to ''"
    exit 1
  else
    printf "lcase '' test passed\n"
  fi

  if [[ "z" != $(lcase "Z") ]] 
  then
    printf "lcase 'Z' must be equal to 'z'\n"
    exit 1
  else
    printf "lcase 'Z' test passed\n"
  fi

  if [[ "abcd 12 " != $(ltrim "   abcd 12 ") ]] 
  then
    printf "ltrim '   abcd 12 ' must be equal to 'abcd 12 '\n"
    exit 1
  else
    printf "ltrim '   abcd 12 ' test passed\n"
  fi

  if [[ "  abcd 12" != $(rtrim "  abcd 12   ") ]] 
  then
    printf "rtrim '  abcd 12   ' must be equal to '  abcd 12'\n"
    exit 1
  else
    printf "rtrim '  abcd 12   ' test passed\n"
  fi

  _tc_result=$(to_lower "ABCd12,!")
  if [[ ${_tc_result} != "abcd12,!" ]]
  then
    printf "to_lower 'ABCd12,!' returned ${_tc_result}\n"
    printf "to_lower 'ABCd12,!' must be equal to 'abcd12,!'\n"
  else
    printf "to_lower 'ABCd12,!' passed\n"
  fi

  _tc_result=$(remove_non_chars "ABCd12,!")
  if [[ ${_tc_result} != "ABCd" ]]
  then
    printf "remove_non_chars 'ABCd12,!' returned ${_tc_result}\n"
    printf "remove_non_chars 'ABCd12,!' must be equal to ABCd'\n"
  else
    printf "remove_non_chars 'ABCd12,!' passed\n"
  fi

  printf "to_lower: $(to_lower 'Redrum sirismurder')\n"
  printf "rnc: $(remove_non_chars 'Redrum sirismurder')\n"
  printf "ip: $(is_palindrome 'Red rum, sir, is murder')\n"
  exit 0
}

run_tests
