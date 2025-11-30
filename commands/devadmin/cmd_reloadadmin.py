from evennia import CmdSet
from evennia.utils import time_format
from evennia.server.evennia_launcher import reload_evennia
from evennia.accounts.accounts import AccountDB
from evennia.commands.command import Command
import time


class CmdReloadAdmin(Command):
    """
    Reload server without kicking players
    """

    key = "@reloadadmin"
    locks = "cmd:perm(Admin)"

    def func(self):
        start = time.time()

        self.caller.msg("[Reloading server]")

        reload_evennia()

        duration = f"{(time.time() - start):.2f}s"
        online = AccountDB.objects.filter(db_is_connected=True).count()

        msg = [
            "",
            f"[Reload Complete]",
            f" Players online: {online}",
            f" Reload duration: {duration}",
            f" Reload finished at: {time_format(time.time(), localtime=True)}",
        ]

        self.caller.msg("\n".join(msg))


class DevAdminCmdSet(CmdSet):
    def at_cmdset_creation(self):
        self.add(CmdReloadAdmin())
