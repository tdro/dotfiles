from ranger.api.commands import Command

class fzm_select(Command):
    """
    :fzm_select
    """
    def execute(self):
        import subprocess
        import os.path
        fzm = self.fm.execute_command("source $HOME/.config/ranger/fzf-marks/fzf-marks.plugin.bash && fzm", universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzm.communicate()
        if fzm.returncode == 0:
            fzm_folder = os.path.abspath(stdout.rstrip('\n'))
            self.fm.cd(fzm_folder)
