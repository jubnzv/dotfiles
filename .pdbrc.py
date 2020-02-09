# Save history across sessions in local directory
# [1]: https://wiki.python.org/moin/PdbRcIdea

def _pdbrc_init():
    import readline
    histfile = ".pyhistory"
    try:
        readline.read_history_file(histfile)
    except IOError:
        pass
    import atexit
    atexit.register(readline.write_history_file, histfile)
    readline.set_history_length(500)

_pdbrc_init()
del _pdbrc_init
