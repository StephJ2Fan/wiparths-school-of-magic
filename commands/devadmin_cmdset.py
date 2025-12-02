from evennia import CmdSet
from newgame.commands.devadmin.admin_commands import CmdReloadAdmin, CmdSysInfo


class DevAdminCmdSet(CmdSet):
    """
    This is your developer/admin-only command set.
    Only users with Developer/Builder permissions will see these.
    """
    key = "DevAdminCmdSet"

    def at_cmdset_creation(self):
        self.add(CmdReloadAdmin())
        self.add(CmdSysInfo())
