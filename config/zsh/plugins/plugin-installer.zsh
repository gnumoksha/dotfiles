# Simple function to install a zsh plugin from a git repository.
#
# This is useful because I've ended up with a slow shell startup while
# using more complete solutions like zplug.
zsh-plugin-installer() {
  local REPO=
  local DST=
  local EXEC_AFTER=
  local EXEC_ALWAYS=

  for arg in "$@"; do
    case ${arg} in
    repo=*)
      REPO="${arg#*=}"
      shift
      ;;
    dst=*)
      DST="${arg#*=}"
      shift
      ;;
    exec-after=*)
      EXEC_AFTER="${arg#*=}"
      shift
      ;;
    exec-always=*)
      EXEC_ALWAYS="${arg#*=}"
      shift
      ;;
    *)
      echo "The option ${arg} is unknown."
      exit 1
      ;;
    esac
  done

  local PKG_NAME=$(basename $REPO)
  STARTED_AT=$(date +%s.%N)

  if [[ -z "${DST}" ]]; then
    DST="${XDG_CACHE_HOME}/zsh-plugin-installer/${PKG_NAME}"
  fi

  if [[ ! -d "${DST}" ]]; then
    # ${DST} is not a directory
    echo "Installing $PKG_NAME"
    git clone --depth=1 --recurse-submodules --quiet "${REPO}" "${DST}"

    if [[ ! -z "${EXEC_AFTER}" ]]; then
      echo " -> Executing $EXEC_AFTER"
      pushd -q "${DST}"

      eval "${EXEC_AFTER}"
      if [[ $? -ne 0 ]]; then
        echo "Error on exec after!"
      fi

      popd -q
    fi
  fi

  if [[ -n "${EXEC_ALWAYS}" ]]; then
    # User has defined "EXEC_ALWAYS"
    pushd -q "${DST}"

    if [[ "${EXEC_ALWAYS}" == "plug" ]]; then
      source "${PKG_NAME}.plugin.zsh"
    else
      eval "${EXEC_ALWAYS}"
      if [[ $? -ne 0 ]]; then
        echo "Error on exec always!" >&2
      fi
    fi

    popd -q
  fi

  LOAD_TIME=$(($(date +%s.%N) - STARTED_AT))
  if [[ $LOAD_TIME -gt 1 ]]; then
    echo >&2 "[warning] startup time for $REPO was $LOAD_TIME seconds."
    read "?Press [ENTER] to continue"
    #zprof # show the profilling results from zprof module, if loaded
    #read "?Press [ENTER] to continue"
  fi
}
