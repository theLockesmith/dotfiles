# kdesrc-build #################################################################

## Add kdesrc-build to PATH
export PATH="/home/forgemaster/kde/src/kdesrc-build:$PATH"

## Autocomplete for kdesrc-run
function _comp_kdesrc_run
{
  local cur
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"

  # Complete only the first argument
  if [[ $COMP_CWORD != 1 ]]; then
    return 0
  fi

  # Retrieve build modules through kdesrc-run
  # If the exit status indicates failure, set the wordlist empty to avoid
  # unrelated messages.
  local modules
  if ! modules=$(kdesrc-run --list-installed);
  then
      modules=""
  fi

  # Return completions that match the current word
  COMPREPLY=( $(compgen -W "${modules}" -- "$cur") )

  return 0
}

## Register autocomplete function
complete -o nospace -F _comp_kdesrc_run kdesrc-run
################################################################################

test -r ~/stack/openstack/src/kayobe/kayobe-complete && source ~/stack/openstack/src/kayobe/kayobe-complete
if [ -e /home/forgemaster/.nix-profile/etc/profile.d/nix.sh ]; then . /home/forgemaster/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
