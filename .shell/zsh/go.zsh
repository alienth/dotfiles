
GOPATH=$HOME/lab/go
if [ -d $HOME/lab/go ]; then
    export GOPATH
fi

if [ -d $HOME/lab/go/bin ] ; then
    PATH=$HOME/lab/go/bin:"${PATH}"
fi

