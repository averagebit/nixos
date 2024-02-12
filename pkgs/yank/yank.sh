function exists() {
    type "$1" &>/dev/null
}

if exists wl-copy; then
    exe="wl-copy"
elif exists xclip; then
    exe="xclip"
elif exists pbcopy; then
    exe="pbcopy"
fi

if [[ -r "$1" ]]; then
    exec $exe < "$1"
else
    exec $exe <<< "$1"
fi

echo "error: clipboard tool is missing"
exit 1
