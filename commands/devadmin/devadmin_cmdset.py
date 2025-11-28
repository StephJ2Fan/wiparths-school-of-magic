from evennia import CmdSet
from .cmd_sysinfo import CmdSysInfo
from .cmd_reloadadmin import CmdReloadAdmin



class DevAdminCmdSet(CmdSet):
    """
    This is your developer only command set.
    Every command added here becomes available
    only to users with Developer permissions.
    """
    key = "DevAdminCmdSet"

    def at_cmdset_creation(self):
        """
        This function is automatically called
        when Evennia loads the command set.
        """
        super().at_cmdset_creation()
        # Commands will be added here later, like this:
        self.add(CmdSysInfo)
        self.add(CmdReloadAdmin)