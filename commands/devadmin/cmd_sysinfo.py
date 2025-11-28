from evennia import Command
import platform
import sys

class CmdSysInfo(Command):
    key = "@sysinfo"
    locks: "cmd:perm(Developer)"
    help_category = "Admin"

    def func(self):
        self.caller.msg(
            f"Python Version: {sys.version}\n"
            f"Operating System: {platform.system()} {platform.release()}\n"
            f"Platform: {platform.platform()}\n"
        )