#!/usr/bin/env bash

# Meta Keys:
# The ECMA-35 standard prefixes control sequences containing a high
# eighth-bit with <Esc> to disambiguate from unicode input, which also
# utilizes a high eigth-bit (overlapping ranges). This necessitates
# the use of timings to differentiate and <Esc>-prefixes control
# sequence and <Esc> preceding unrelated keys. Unfortunately the
# timing mechanism is unable to differentiate between macros and
# bindings from actual control sequences as in all cases timing is
# near-zero. Furthermore programs without accurate timers break
# unexpectedly and often randomly, such as vim. Neovim can be
# configured without any breakage, as can tmux. However it is simpler
# - if willing to forego working unicode input - to simply disble
# ECMA-35 and send meta-sequences as eight-bit high.
# Unfortunately URxvt simply passes eight-bit high control-sequences
# untouched, letting higher layers assume they are the beginning of
# unicode byte-sequences. This breaks these sequences. XTerm avoids
# this ambiguity by automatically converting the eight-bit high
# control sequence to appropriate byte sequences using the current
# locale. URxvt can be harcoded to mimic this behaviour, but not in a
# locale-independent fashion. If locales change, the following
# bindings will be broken.
# Summary:
#   * Specific to the current locale
#   * Breaks UTF-8 input

read -r -d '' PyURxvtMeta8 <<-'EOF'
    #!/usr/bin/env python3

    import locale

    locale.setlocale(locale.LC_ALL, "")
    encoding = locale.getlocale()[1]

    # ASCII range
    for i in range(32, 128):
        seq = "".join("\{:o}".format(j) for j in chr(i + (1<<7)).encode(encoding))
        key = "{:#06X}".format(i)
        print("urxvt*keysym.Meta-{}: {}".format(key, seq))
EOF

xrdb -merge <(python3 <<<"$PyURxvtMeta8")

# Execute X session
exec i3
