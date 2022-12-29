
config.load_autoconfig()

def bind(key, command, mode):  # noqa: E302
    """Bind key to command in mode."""
    # TODO set force; doesn't exist yet
    config.bind(key, command, mode=mode)

def nmap(key, command):
    """Bind key to command in normal mode."""
    bind(key, command, 'normal')

nmap('N', 'tab-prev')
nmap('', 'tab-prev')
# no default binding
nmap('E', 'tab-next')
