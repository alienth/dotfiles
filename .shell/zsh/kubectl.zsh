KUBECTL=$(command -v kubectl)

kubectl () {
    KUBECTL_TOUCH=$(date +%s)
    if [[ $KUBECTL ]]; then
        $KUBECTL "$@";
    else
        # Just in case kubectl was moved.
        if KUBECTL=$(command kubectl); then
            kubectl "$@";
        fi
    fi
}
