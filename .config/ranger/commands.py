from ranger.api.commands import Command

class fzf_dir_select(Command):
    """
    :fzf_dir_select
    See: https://github.com/urbainvaes/fzf-marks
    """
    def execute(self):
        import subprocess
        import os.path
        dir = self.fm.execute_command(
          "source $HOME/.config/fzf-marks/fzf-marks.plugin.bash && fzf-dir",
          universal_newlines=True,
          stdout=subprocess.PIPE)
        stdout, stderr = dir.communicate()
        if dir.returncode == 0:
            dir_folder = os.path.abspath(stdout.rstrip('\n'))
            self.fm.cd(dir_folder)


class fzf_file_select(Command):
    """
    :fzf_file_select
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
                self.fm.run('xdg-open ' + "'" + fzf_file + "'" + ' &>/dev/null')
