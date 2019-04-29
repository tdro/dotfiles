from ranger.api.commands import Command

class fzm_select(Command):
    """
    :fzm_select
    See: https://github.com/urbainvaes/fzf-marks
    """
    def execute(self):
        import subprocess
        import os.path
        fzm = self.fm.execute_command("source $HOME/.config/ranger/fzf-marks/fzf-marks.plugin.bash && fzm", universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzm.communicate()
        if fzm.returncode == 0:
            fzm_folder = os.path.abspath(stdout.rstrip('\n'))
            self.fm.cd(fzm_folder)


class fzf_select(Command):
    """
    :fzf_select
    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import subprocess
        import os.path
        fzf = self.fm.execute_command("ls -t -A1 --color=never | fzf +m", universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)
                self.fm.run('xdg-open ' + fzf_file)
