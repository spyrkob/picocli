#!/usr/bin/env bash
#
# picocompletion-demo Bash Completion
# =======================
#
# Bash completion support for the `picocompletion-demo` command,
# generated by [picocli](http://picocli.info/) version %1$s.
#
# Installation
# ------------
#
# 1. Source all completion scripts in your .bash_profile
#
#   cd $YOUR_APP_HOME/bin
#   for f in $(find . -name "*_completion"); do line=". $(pwd)/$f"; grep "$line" ~/.bash_profile || echo "$line" >> ~/.bash_profile; done
#
# 2. Open a new bash console, and type `picocompletion-demo [TAB][TAB]`
#
# 1a. Alternatively, if you have [bash-completion](https://github.com/scop/bash-completion) installed:
#     Place this file in a `bash-completion.d` folder:
#
#   * /etc/bash-completion.d
#   * /usr/local/etc/bash-completion.d
#   * ~/bash-completion.d
#
# Documentation
# -------------
# The script is called by bash whenever [TAB] or [TAB][TAB] is pressed after
# 'picocompletion-demo (..)'. By reading entered command line parameters,
# it determines possible bash completions and writes them to the COMPREPLY variable.
# Bash then completes the user input if only one entry is listed in the variable or
# shows the options if more than one is listed in COMPREPLY.
#
# References
# ----------
# [1] http://stackoverflow.com/a/12495480/1440785
# [2] http://tiswww.case.edu/php/chet/bash/FAQ
# [3] https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
# [4] http://zsh.sourceforge.net/Doc/Release/Options.html#index-COMPLETE_005fALIASES
# [5] https://stackoverflow.com/questions/17042057/bash-check-element-in-array-for-elements-in-another-array/17042655#17042655
# [6] https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion.html#Programmable-Completion
# [7] https://stackoverflow.com/questions/3249432/can-a-bash-tab-completion-script-be-used-in-zsh/27853970#27853970
#

if [ -n "$BASH_VERSION" ]; then
  # Enable programmable completion facilities when using bash (see [3])
  shopt -s progcomp
elif [ -n "$ZSH_VERSION" ]; then
  # Make alias a distinct command for completion purposes when using zsh (see [4])
  setopt COMPLETE_ALIASES
  alias compopt=complete

  # Enable bash completion in zsh (see [7])
  autoload -U +X compinit && compinit
  autoload -U +X bashcompinit && bashcompinit
fi

# ArrContains takes two arguments, both of which are the name of arrays.
# It creates a temporary hash from lArr1 and then checks if all elements of lArr2
# are in the hashtable.
#
# Returns zero (no error) if all elements of the 2nd array are in the 1st array,
# otherwise returns 1 (error).
#
# Modified from [5]
function ArrContains() {
  local lArr1 lArr2
  declare -A tmp
  eval lArr1=("\"\${$1[@]}\"")
  eval lArr2=("\"\${$2[@]}\"")
  for i in "${lArr1[@]}";{ [ -n "$i" ] && ((++tmp[$i]));}
  for i in "${lArr2[@]}";{ [ -n "$i" ] && [ -z "${tmp[$i]}" ] && return 1;}
  return 0
}

# Bash completion entry point function.
# _complete_picocompletion-demo finds which commands and subcommands have been specified
# on the command line and delegates to the appropriate function
# to generate possible options and subcommands for the last specified subcommand.
function _complete_picocompletion-demo() {
  CMDS0=(sub1)
  CMDS1=(sub2)
  CMDS2=(sub2 subsub1)
  CMDS3=(sub2 subsub2)
  CMDS4=(sub2 subsub3)

  ArrContains COMP_WORDS CMDS4 && { _picocli_picocompletion-demo_sub2_subsub3; return $?; }
  ArrContains COMP_WORDS CMDS3 && { _picocli_picocompletion-demo_sub2_subsub2; return $?; }
  ArrContains COMP_WORDS CMDS2 && { _picocli_picocompletion-demo_sub2_subsub1; return $?; }
  ArrContains COMP_WORDS CMDS1 && { _picocli_picocompletion-demo_sub2; return $?; }
  ArrContains COMP_WORDS CMDS0 && { _picocli_picocompletion-demo_sub1; return $?; }

  # No subcommands were specified; generate completions for the top-level command.
  _picocli_picocompletion-demo; return $?;
}

# Generates completions for the options and subcommands of the `picocompletion-demo` command.
function _picocli_picocompletion-demo() {
  # Get completion data
  CURR_WORD=${COMP_WORDS[COMP_CWORD]}
  PREV_WORD=${COMP_WORDS[COMP_CWORD-1]}

  COMMANDS="sub1 sub2"
  FLAG_OPTS="-V --version -h --help"
  ARG_OPTS=""

  if [[ "${CURR_WORD}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${FLAG_OPTS} ${ARG_OPTS}" -- ${CURR_WORD}) )
  else
    COMPREPLY=( $(compgen -W "${COMMANDS}" -- ${CURR_WORD}) )
  fi
}

# Generates completions for the options and subcommands of the `sub1` subcommand.
function _picocli_picocompletion-demo_sub1() {
  # Get completion data
  CURR_WORD=${COMP_WORDS[COMP_CWORD]}
  PREV_WORD=${COMP_WORDS[COMP_CWORD-1]}

  COMMANDS=""
  FLAG_OPTS=""
  ARG_OPTS="--num --str --candidates"
  str2_OPTION_ARGS="aaa bbb ccc" # --candidates values

  compopt +o default

  case ${PREV_WORD} in
    --num)
      return
      ;;
    --str)
      return
      ;;
    --candidates)
      COMPREPLY=( $( compgen -W "${str2_OPTION_ARGS}" -- ${CURR_WORD} ) )
      return $?
      ;;
  esac

  if [[ "${CURR_WORD}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${FLAG_OPTS} ${ARG_OPTS}" -- ${CURR_WORD}) )
  else
    COMPREPLY=( $(compgen -W "${COMMANDS}" -- ${CURR_WORD}) )
  fi
}

# Generates completions for the options and subcommands of the `sub2` subcommand.
function _picocli_picocompletion-demo_sub2() {
  # Get completion data
  CURR_WORD=${COMP_WORDS[COMP_CWORD]}
  PREV_WORD=${COMP_WORDS[COMP_CWORD-1]}

  COMMANDS="subsub1 subsub2 subsub3"
  FLAG_OPTS=""
  ARG_OPTS="--num2 --directory -d"

  compopt +o default

  case ${PREV_WORD} in
    --num2)
      return
      ;;
    --directory|-d)
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- ${CURR_WORD} ) ) # files
      return $?
      ;;
  esac
  possibilities_POS_PARAM_ARGS="Aaa Bbb Ccc" # 0-2147483647 values

  if [[ "${CURR_WORD}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${FLAG_OPTS} ${ARG_OPTS}" -- ${CURR_WORD}) )
  else
    currIndex=0
    for i in $(seq $(($COMP_CWORD-2)) -1 0); do
      if [ "${PREV_WORD}" = "sub2" ]; then
        break
      fi
      if [[ "${ARG_OPTS}" =~ "${PREV_WORD}" ]]; then
        ((currIndex-=2)) # Arg option and its value not counted as positional param
      elif [[ "${FLAG_OPTS}" =~ "${PREV_WORD}" ]]; then
        ((currIndex-=1)) # Flag option itself not counted as positional param
      fi
      PREV_WORD=${COMP_WORDS[i]}
      ((currIndex++))
    done
    if ((${currIndex} >= 0 && ${currIndex} <= 2147483647)); then
      COMPREPLY=( $( compgen -W "$possibilities_POS_PARAM_ARGS" -- ${CURR_WORD} ) )
      return $?
    fi
    COMPREPLY=( $(compgen -W "${COMMANDS}" -- ${CURR_WORD}) )
  fi
}

# Generates completions for the options and subcommands of the `subsub1` subcommand.
function _picocli_picocompletion-demo_sub2_subsub1() {
  # Get completion data
  CURR_WORD=${COMP_WORDS[COMP_CWORD]}
  PREV_WORD=${COMP_WORDS[COMP_CWORD-1]}

  COMMANDS=""
  FLAG_OPTS=""
  ARG_OPTS="-h --host"

  compopt +o default

  case ${PREV_WORD} in
    -h|--host)
      compopt -o filenames
      COMPREPLY=( $( compgen -A hostname -- ${CURR_WORD} ) )
      return $?
      ;;
  esac

  if [[ "${CURR_WORD}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${FLAG_OPTS} ${ARG_OPTS}" -- ${CURR_WORD}) )
  else
    COMPREPLY=( $(compgen -W "${COMMANDS}" -- ${CURR_WORD}) )
  fi
}

# Generates completions for the options and subcommands of the `subsub2` subcommand.
function _picocli_picocompletion-demo_sub2_subsub2() {
  # Get completion data
  CURR_WORD=${COMP_WORDS[COMP_CWORD]}
  PREV_WORD=${COMP_WORDS[COMP_CWORD-1]}

  COMMANDS=""
  FLAG_OPTS=""
  ARG_OPTS="-u --timeUnit -t --timeout"
  timeUnit_OPTION_ARGS="%2$s" # --timeUnit values

  compopt +o default

  case ${PREV_WORD} in
    -u|--timeUnit)
      COMPREPLY=( $( compgen -W "${timeUnit_OPTION_ARGS}" -- ${CURR_WORD} ) )
      return $?
      ;;
    -t|--timeout)
      return
      ;;
  esac
  str2_POS_PARAM_ARGS="aaa bbb ccc" # 0-2147483647 values

  if [[ "${CURR_WORD}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${FLAG_OPTS} ${ARG_OPTS}" -- ${CURR_WORD}) )
  else
    currIndex=0
    for i in $(seq $(($COMP_CWORD-2)) -1 0); do
      if [ "${PREV_WORD}" = "subsub2" ]; then
        break
      fi
      if [[ "${ARG_OPTS}" =~ "${PREV_WORD}" ]]; then
        ((currIndex-=2)) # Arg option and its value not counted as positional param
      elif [[ "${FLAG_OPTS}" =~ "${PREV_WORD}" ]]; then
        ((currIndex-=1)) # Flag option itself not counted as positional param
      fi
      PREV_WORD=${COMP_WORDS[i]}
      ((currIndex++))
    done
    if ((${currIndex} >= 0 && ${currIndex} <= 2147483647)); then
      COMPREPLY=( $( compgen -W "$str2_POS_PARAM_ARGS" -- ${CURR_WORD} ) )
      return $?
    fi
    COMPREPLY=( $(compgen -W "${COMMANDS}" -- ${CURR_WORD}) )
  fi
}

# Generates completions for the options and subcommands of the `subsub3` subcommand.
function _picocli_picocompletion-demo_sub2_subsub3() {
  # Get completion data
  CURR_WORD=${COMP_WORDS[COMP_CWORD]}
  PREV_WORD=${COMP_WORDS[COMP_CWORD-1]}

  COMMANDS=""
  FLAG_OPTS=""
  ARG_OPTS=""
  cands_POS_PARAM_ARGS="aaa bbb ccc" # 0-0 values

  if [[ "${CURR_WORD}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${FLAG_OPTS} ${ARG_OPTS}" -- ${CURR_WORD}) )
  else
    currIndex=0
    for i in $(seq $(($COMP_CWORD-2)) -1 0); do
      if [ "${PREV_WORD}" = "subsub3" ]; then
        break
      fi
      if [[ "${ARG_OPTS}" =~ "${PREV_WORD}" ]]; then
        ((currIndex-=2)) # Arg option and its value not counted as positional param
      elif [[ "${FLAG_OPTS}" =~ "${PREV_WORD}" ]]; then
        ((currIndex-=1)) # Flag option itself not counted as positional param
      fi
      PREV_WORD=${COMP_WORDS[i]}
      ((currIndex++))
    done
    if ((${currIndex} >= 0 && ${currIndex} <= 0)); then
      COMPREPLY=( $( compgen -W "$cands_POS_PARAM_ARGS" -- ${CURR_WORD} ) )
      return $?
    elif ((${currIndex} >= 1 && ${currIndex} <= 2)); then
      compopt -o filenames
      COMPREPLY=( $( compgen -f -- ${CURR_WORD} ) ) # files
      return $?
    elif ((${currIndex} >= 3 && ${currIndex} <= 2147483647)); then
      compopt -o filenames
      COMPREPLY=( $( compgen -A hostname -- ${CURR_WORD} ) )
      return $?
    fi
    COMPREPLY=( $(compgen -W "${COMMANDS}" -- ${CURR_WORD}) )
  fi
}

# Define a completion specification (a compspec) for the
# `picocompletion-demo`, `picocompletion-demo.sh`, and `picocompletion-demo.bash` commands.
# Uses the bash `complete` builtin (see [6]) to specify that shell function
# `_complete_picocompletion-demo` is responsible for generating possible completions for the
# current word on the command line.
# The `-o default` option means that if the function generated no matches, the
# default Bash completions and the Readline default filename completions are performed.
complete -F _complete_picocompletion-demo -o default picocompletion-demo picocompletion-demo.sh picocompletion-demo.bash
