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
  else
    COMPREPLY=()
  fi
}

complete -F _nip nip
