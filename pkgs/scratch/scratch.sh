#!/usr/bin/env bash

file="${NOTES}/scratchpad/scratchpad.md"
exec vi -c "setlocal nonu nornu laststatus=0 ft=markdown $*" "${file}"
