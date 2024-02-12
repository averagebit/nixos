ARGS=()
CLONE_BARE="false"
CLONE_USER="$(whoami)"
CLONE_REGISTRY="github.com"
CLONE_REPOS_DIR="${HOME}/repos"

function help() {
    cat << EOF
Clone repositories in a predefined directory structure.

Usage:
  clone [flags] [options] <repo-url> <folder-name>

Arguments:
  repo-url      The repository url (accepted formats:
                [name|owner/name|git@github.com:owner/name|https://github.com/owner/name])
  repo-folder   The name of the folder to clone the repository in (default:
                the repository name)

Options:
  -d, --dir        The repositories directory (default: \$CLONE_REPOS_DIR="\${HOME}/repos")
  -u, --user       The default git user (default: \$CLONE_USER="\$(whoami)")
  -r, --registry   The default git remote registry (default: \$CLONE_REGISTRY="github.com")

Flags:
  -b, --bare   clone as bare repository
  -h, --help   help for clone
EOF
}

function get_repo_registry() {
    local registry
    registry="$1"
    registry="${registry#*://}"
    registry="${registry%%/*}"
    registry="${registry#git@}"
    registry="${registry%%:*}"
    echo "${registry}"
}

function get_repo_owner() {
    local owner
    owner="$1"
    owner="${owner#*://*/}"
    owner="${owner%%/*}"
    owner="${owner#git@*:}"
    echo "${owner}"
}

function get_repo_name() {
    local repo
    repo="$1"
    repo="${repo%.git}"
    repo="${repo#*://}"
    repo="${repo##*/}"
    repo="${repo#git@}"
    repo="${repo##*:}"
    echo "${repo}"
}

function get_repo_branch() {
    local repo_path
    repo_path="$1"
    cd "${repo_path}"
    if grep -q main <<< "$(git branch)"; then
        echo "main"
    else
        echo "master"
    fi
}

function remove_repo() {
    local repo_path repo_owner_path
    repo_path="${1}"
    repo_owner_path="${repo_path%/*}"
    find "${repo_path}" -maxdepth 0 -type d -empty -delete || true
    find "${repo_owner_path}" -maxdepth 0 -type d -empty -delete || true
}

function clone_repo_regular() {
    local repo_url repo_path
    repo_url="$1"
    repo_path="$2"
    if ! git clone --recursive "${repo_url}" "${repo_path}"; then
        remove_repo "${repo_path}"
        exit 1
    fi
    echo "${repo_path}"
}

function clone_repo_bare() {
    local repo_url repo_path
    repo_url="$1"
    repo_path="$2"
    mkdir -p "${repo_path}"
    if ! git clone --recursive --bare "${repo_url}" "${repo_path}/.repo"; then
        remove_repo "${repo_path}"
        exit 1
    fi
    cd "${repo_path}"
    repo_branch="$(get_repo_branch "${repo_path}")"
    echo "gitdir: ./.repo" > .git
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
    git fetch origin
    git worktree add "${repo_branch}"
    echo "${repo_path}/${repo_branch}"
}

function clone_repo() {
    local repo_url repo_registry repo_name repo_owner clone_dir
    repo_url="${1}"
    clone_dir="${2:-}"

    if [[ -z "${repo_url:-}" ]]; then
        echo -e "error: missing argument <repo-url>"
        help
        exit 1
    fi

    if grep -qE "^(http|https|git@)" <<< "${repo_url}"; then
        repo_registry="$(get_repo_registry "${repo_url}")"
        repo_name="$(get_repo_name "${repo_url}")"
        repo_owner="$(get_repo_owner "${repo_url}")"
    fi

    if [[ "${repo_url}" =~ "/" && -z "${repo_registry:-}" ]]; then
        repo_registry="${CLONE_REGISTRY}"
        repo_owner="${repo_url%%/*}"
        repo_name="${repo_url##*/}"
    fi

    if [[ -z "${repo_registry:-}" ]]; then
        repo_registry="${CLONE_REGISTRY}"
        repo_owner="${CLONE_USER}"
        repo_name="${repo_url}"
    fi

    repo_url="git@${repo_registry}:${repo_owner}/${repo_name}"
    repo_path="${CLONE_REPOS_DIR}/${repo_registry}/${repo_owner}/${clone_dir:-"${repo_name}"}"

    if [[ "${CLONE_BARE}" == "true" ]]; then
        clone_repo_bare "${repo_url}" "${repo_path}"
    else
        clone_repo_regular "${repo_url}" "${repo_path}"
    fi
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -b|--bare)
            CLONE_BARE="true"
            shift
            ;;
        -d|--dir)
            CLONE_REPOS_DIR="$2"
            shift 2
            ;;
        -u|--user)
            CLONE_USER="$2"
            shift 2
            ;;
        -r|--registry)
            CLONE_REGISTRY="$2"
            shift 2
            ;;
        -h|--help)
            help
            exit 0
            ;;
        *)
            ARGS+=("$1")
            shift
            ;;
    esac
done

set -- "${ARGS[@]}"
if [[ $# -eq 0 ]]; then
    help
    exit 1
fi

clone_repo "$@"
