from evennia import Command
from evennia.utils import time_format
from evennia.server.evennia_launcher import reload_evennia
from evennia.accounts.models import AccountDB
import time
import platform
import sys

class CmdReloadAdmin(Command):
    """
    Reload the server without kicking connected players.
    Usage:
        @reloadadmin
    """

    key = "@reloadadmin"
    locks = "cmd:pperm(Developer)"
    help_category = "Admin"

    def func(self):
        start = time.time()

        self.caller.msg("[Reloading server ...]")
        reload_evennia()

        duration = f"{(time.time() - start):.2f}s"
        online = AccountDB.objects.filter(db_is_connected=True).count()

        msg = [
            "",
            "[Reload Complete]",
            f" Players online: {online}",
            f" Reload duration: {duration}",
            f" Reload finished at: {time_format(time.time(), localtime=True)}",
        ]

        self.caller.msg("\n".join(msg))


class CmdSysInfo(Command):
    """
    Display basic system information.
    Usage:
        @sysinfo
    """

    key = "@sysinfo"
    locks = "cmd:pperm(Developer)"
    help_category = "Admin"

    def func(self):
        self.caller.msg(
            f"Python Version: {sys.version}\n"
            f"Operating System: {platform.system()} {platform.release()}\n"
            f"Platform: {platform.platform()}\n"
        )