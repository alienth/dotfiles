if [[ -x /bin/systemctl ]]; then
  alias start='sudo systemctl start'
  alias stop='sudo systemctl stop'
  alias restart='sudo systemctl restart'
  alias status='sudo systemctl status'
fi

# `less` options to use on pager. This is default other than the re-enabling of
# wrapping.
export SYSTEMD_LESS=FRXMK
