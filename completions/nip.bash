_nip() {
  local cur prev words cword
  _init_completion || return

  local commands="add clean import install list remove search update help"

  if [[ $cur == -* ]]; then
    COMPREPLY=($(compgen -W "-h --help" -- "$cur"))
    return
  fi

  if [[ $cword -eq 1 ]]; then
    COMPREPLY=($(compgen -W "$commands" -- "$cur"))
    return
  fi

  local cmd="${words[1]}"

  if [[ "$cmd" == "remove" || "$cmd" == "update" ]]; then
    local pkgs
    pkgs="$(nip list 2>/dev/null)"
    COMPREPLY=($(compgen -W "$pkgs" -- "$cur"))
    return
  fi

  if [[ "$cmd" == "add" || "$cmd" == "install" ]]; then
    local pkgs
    # this feels hacky, but to make it look nice:
    echo -ne "\033[s" >&2         # save the location of the user's cursor
    echo -ne "\nSearching..." >&2 # on the next line, tell them we are searching
    pkgs="$(nip search "$cur" 2>/dev/null | awk -F: '{print $1}')"
    echo -ne "\r            " >&2 # erase the searching message
    echo -ne "\033[u" >&2         # return back to the saved location. if there was only one option, completion will write the rest
    # from the saved location, but if there were more than one option, auto completions will print them on the next line,
    # which is the same line as where the "searching" message used to be
    COMPREPLY=($(compgen -W "$pkgs" -- "$cur"))
    return

  else
    COMPREPLY=()
  fi
}

complete -F _nip nip
