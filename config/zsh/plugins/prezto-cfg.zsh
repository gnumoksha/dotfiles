#|
#| Prezto configuration file
#|

# Do not use alias from prezto git module.
zstyle ':prezto:module:git:alias' skip 'yes'
# Set the prompt theme to load.
# Setting it to 'random' loads a random theme.
# Auto set to 'off' on dumb terminals.
# Nice prompts: paradox, sorin, skwp, bart, giddie, damoekri, kylewest.
zstyle ':prezto:module:prompt' theme 'sorin'
#prompt sorin # ZPLUG-PREZTO-BUG
# Set the working directory prompt display length.
# By default, it is set to 'short'. Set it to 'long' (without '~' expansion)
# for longer or 'full' (with '~' expansion) for even longer prompt display.
zstyle ':prezto:module:prompt' pwd-length 'long'
# Set the prompt to display the return code along with an indicator for non-zero
# return codes. This is not supported by all prompts.
zstyle ':prezto:module:prompt' show-return-val 'yes'

