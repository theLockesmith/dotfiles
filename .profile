# Kayobe
export KAYOBE_CONFIG_PATH="$HOME/stack/openstack/src/kayobe-config/etc/kayobe"

test -r ~/stack/openstack/src/kayobe/kayobe-complete && source ~/stack/openstack/src/kayobe/kayobe-complete
if [ -e /home/forgemaster/.nix-profile/etc/profile.d/nix.sh ]; then . /home/forgemaster/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "$HOME/.cargo/env"
