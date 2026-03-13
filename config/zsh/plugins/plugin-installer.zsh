# Simple function to install a zsh plugin from a git repository.
#
# This is useful because I've ended up with a slow shell startup while
# using more complete solutions like zplug.
zsh-plugin-installer() {
	zmodload zsh/zutil || return

	C_RED='\e[31m'
	C_GREEN='\e[32m'
	C_YELLOW='\e[33m'
	C_BLUE='\e[34m'
	C_NO='\e[0m' # No Color

	local help verbose repo exec_after exec_always
	# -D pulls parsed flags out of $@
	# -F says fail if we find a flag that wasn't defined
	# -K allows us to set default values without zparseopts overwriting them
	# Remember that the first dash is automatically handled, so long options are -opt, not --opt
	# Add a trailing colon (:) to an option spec if it requires an argument
	zparseopts -D -F -K -- \
		{h,-help}=help \
		{v,-verbose}=verbose \
		{r,-repo}:=repo \
		{a,-exec-after}:=exec_after \
		{w,-exec-always}:=exec_always

	if (($#help)); then
		print -rC1 -- \
			"$0 [-h|--help]" \
			"$0 [-v|--verbose]" \
			"$0 [-r|--repo=<arg>]" \
			"$0 [-a|--exec-after=<arg>]" \
			"$0 [-w|--exec-always=<arg>]"
		return
	fi

	local REPO=$repo[-1]
	local DST=
	local EXEC_AFTER=$exec_after[-1]
	local EXEC_ALWAYS=$exec_always[-1]

	(($#verbose)) && echo -e "${C_YELLOW}REPO = '$REPO' | DST = '$DST' | EXEC_AFTER = '$EXEC_AFTER' | EXEC_ALWAYS = '$EXEC_ALWAYS' ${C_NO}"

	local PKG_NAME=$(basename $REPO)
	STARTED_AT=$(date +%s.%N)

	if [[ -z "${DST}" ]]; then
		DST="${XDG_CACHE_HOME}/zsh-plugin-installer/${PKG_NAME}"
	fi

	if [[ ! -d "${DST}" ]]; then
		echo -e "${C_BLUE}Installing $PKG_NAME${C_NO} in $DST"
		git clone --depth=1 --recurse-submodules --quiet "${REPO}" "${DST}"

		if [[ ! -z "${EXEC_AFTER}" ]]; then
			echo -e " ${C_BLUE}-> Executing${C_NO} $EXEC_AFTER"
			pushd -q "${DST}"

			eval "${EXEC_AFTER}"
			if [[ $? -ne 0 ]]; then
				echo -e "${C_RED}Error on exec after!${C_NO}"
			fi

			popd -q
		fi
	fi

	if [[ -n "${EXEC_ALWAYS}" ]]; then
		(($#verbose)) && echo -e "${C_YELLOW}Executing${C_NO} '$EXEC_ALWAYS' in $DST"
		pushd -q "${DST}"

		if [[ "${EXEC_ALWAYS}" == "plug" ]]; then
			source "${PKG_NAME}.plugin.zsh"
		else
			eval "${EXEC_ALWAYS}"
			if [[ $? -ne 0 ]]; then
				echo -e "${C_RED}Error on exec always!${C_NO}" >&2
			fi
		fi

		popd -q
	fi

	LOAD_TIME=$(($(date +%s.%N) - STARTED_AT))
	if [[ $LOAD_TIME -gt 1 ]]; then
		echo >&2 "${C_RED}[warning] startup time for $REPO was $LOAD_TIME seconds.${C_NO}"
		read "?Press [ENTER] to continue"
		#zprof # show the profilling results from zprof module, if loaded
		#read "?Press [ENTER] to continue"
	fi
}
