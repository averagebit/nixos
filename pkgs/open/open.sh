#!/usr/bin/env bash

function exists() {
    type "$1" &>/dev/null
}

open() {
    if exists xdg-open; then
        exec xdg-open "$@"
    elif exists /usr/bin/open; then
        exec /usr/bin/open "$@"
    fi
}

main() {
    [[ -n "$1" ]] && open "$@"
    if git -C . rev-parse; then
        local repo
        repo="$(git config --get remote.origin.url)"
        repo="${repo%.git}"
        if [[ "${repo}" =~ github.com ]]; then
            repo="${repo#git@github.com:}"
            repo="${repo#https://github.com/}"
            open "https://github.com/${repo}"
        elif [[ "${repo}" =~ gitlab.com ]]; then
            repo="${repo#git@gitlab.com:}"
            repo="${repo#https://gitlab.com/}"
            open "https://gitlab.com/${repo}"
        fi
    fi
}

main "$@"
