if [ -d $HOME/bin ] ; then
    PATH=$HOME/bin:"${PATH}"
fi

# If we are root, get root paths
if [ "$EUID" = "0" ]; then
    PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin
fi
