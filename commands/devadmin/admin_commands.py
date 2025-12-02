from evennia import Command
from evennia.server.evennia_launcher import reload_evennia
from evennia.accounts.models import AccountDB
import time
from evennia.utils.utils import datetime_format
import platform
import sys
from datetime import datetime


# Global store (in memory) for last reload info
LAST_RELOAD_INFO = {}

class CmdReloadAdmin(Command):
    """
    Reload the server without fully shutting down.

    Usage:
      @reloadadmin

    Displays reload details before restarting the server and
    disconnecting users.
    """
    key = "@reloadadmin"
    locks = "cmd:pperm(Developer)"
    help_category = "Admin"

    def func(self):
        start_time = time.time()
        # Human-readable local timestamp (date + time, local timezone)
        # Use time.localtime to ensure we display LOCAL time, not UTC
        reload_time = time.strftime("%Y-%m-%d %H:%M:%S %Z", time.localtime(start_time))
        online_accounts = AccountDB.objects.filter(db_is_connected=True).count()
        duration_estimate = f"{0:.2f}s (estimated)"  # We won't have full duration since we reload before it ends.

        self.caller.msg("\n".join([
            "|w[Server Reload Initiated]|n",
            f" Reload requested by: |c{self.caller.key}|n",
            f" Estimated reload time: {duration_estimate}",
            f" Players currently online: {online_accounts}",
            f" Timestamp: {reload_time}",
            " You will now be disconnected. Please reconnect shortly.",
        ]))

        # Store the reload metadata
        global LAST_RELOAD_INFO
        LAST_RELOAD_INFO["user"] = self.caller.key
        LAST_RELOAD_INFO["timestamp"] = reload_time

        reload_evennia()


class CmdLastReload(Command):
    """
    Show when the last @reloadadmin was performed and by whom.

    Usage:
      @lastreload
    """
    key = "@lastreload"
    locks = "cmd:pperm(Developer)"
    help_category = "Admin"

    def func(self):
        global LAST_RELOAD_INFO

        user = LAST_RELOAD_INFO.get("user")
        timestamp = LAST_RELOAD_INFO.get("timestamp")

        if user and timestamp:
            self.caller.msg(
                f"|wLast Reload Information|n\n"
                f" Triggered by: |c{user}|n\n"
                f" Timestamp: {timestamp}"
            )
        else:
            self.caller.msg("No reload information found.")




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
        info = (
            f"Python Version: {sys.version}\n"
            f"Operating System: {platform.system()} {platform.release()}\n"
            f"Platform: {platform.platform()}\n"
        )
        self.caller.msg(info)
