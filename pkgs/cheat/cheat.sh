cheat() {
    local topic="$1"
    if [[ $# -gt 1 ]]; then
        shift
        exec curl "http://cht.sh/${topic}/$(urlencode "$*")"
    fi
    exec curl "http://cht.sh/$(urlencode "$*")"
}

cheat "$@"
