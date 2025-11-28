from evennia import Command
from evennia.server.sessionhandler import SESSIONS
from evennia.utils.utils import time_format
import time

class CmdReloadAdmin(Command):
    key = "@reloadadmin"
    locks = "cmd:perm(Developer)"
    help_category = "Admin"


    def func(self):
        self.caller.msg("|y[Reloading server]|n")

        before = time.time()
        online = len(SESSIONS.get_sessions())

        try:
            self.caller.execute_cmd("@reload")
        except Exception as err:
            self.caller.msg("|r[Reload Failed]|n")
            self.caller.msg(f"|rError:|n {err}")
            return

        duration = time.time() - before

        self.caller.msg("|g[Reload Complete]|n")
        self.caller.msg(f" Players connected: |w{online}|n")
        self.caller.msg(f" Reload duration: |w{duration:.2f}s|n")
        self.caller.msg(
            f" Reload finished at: |w{time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())}|n"
        )
