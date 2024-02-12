[[ -n "$1" ]] && exec curl -s "ix.io/$1"
url=$(curl -s -F 'f:1=<-' http://ix.io)
echo "${url}" && yank "${url}"
