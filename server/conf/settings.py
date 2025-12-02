r"""
Evennia settings file.

Don't copy more from the default file than you intend to change. Use:
`from evennia.settings_default import *` to pull in all default settings,
and override only what you need below.
"""

# Import all default settings from Evennia
from evennia.settings_default import *

######################################################################
# Evennia base server config
######################################################################

# The name of your game
SERVERNAME = "newgame"

######################################################################
# Settings given in secret_settings.py override those in this file.
######################################################################

try:
    from server.conf.secret_settings import *
except ImportError:
    print("secret_settings.py file not found or failed to import.")
