if [[ -x /bin/systemctl ]]; then
  alias start='sudo systemctl start'
  alias stop='sudo systemctl stop'
  alias restart='sudo systemctl restart'
  alias status='sudo systemctl status'
fi
