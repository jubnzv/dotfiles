# Set to 0 if you have problems with the colorized prompt - reported by Plouj with Ubuntu gdb 7.2
set $COLOUREDPROMPT = 1

# Without enclosing non-printing escape sequences with \[ \] will cause
# prompt be overwrited
# Check http://stackoverflow.com/questions/19092488/custom-bash-prompt-is-overwriting-itself
if $COLOUREDPROMPT == 1
   	set prompt \001\033[31m\002gdb$ \001\033[0m\002
end

# General options
set history save on
set confirm off
set verbose off
