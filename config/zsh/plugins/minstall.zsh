#|
#| Manually install some plugins
#|
#
# This is useful because I've ended up with a slow shell startup while
# using more complete solutions like zplug.

minstall() {
  local REPO=${1:-}
  local DST=${2:-}
  local EXEC_AFTER=${3:-}
  local EXEC_ALWAYS=${4:-}

  local PKG_NAME=$(basename $REPO)
  STARTED_AT=$(date +%s.%N)

  if [[ -z "${DST}" ]]; then
    DST="${XDG_CACHE_HOME}/manually-installed/${PKG_NAME}"
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
