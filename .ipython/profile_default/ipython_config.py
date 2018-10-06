c = get_config()

c.TerminalIPythonApp.display_banner = False


def hexon_ipython():
    """Enable hex output formatting."""
    formatter = get_ipython().display_formatter.formatters['text/plain']
    formatter.for_type(int, lambda n, p, cycle: p.text("0x%x" % n))


def hexoff_ipython():
    """Disable hex output formatting."""
    formatter = get_ipython().display_formatter.formatters['text/plain']
    formatter.for_type(int, lambda n, p, cycle: p.text("%d" % n))


hexon = hexon_ipython
hexoff = hexoff_ipython

