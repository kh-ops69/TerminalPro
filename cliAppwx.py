import wx
import subprocess

class CommandApp(wx.Frame):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.panel = wx.Panel(self)
        self.command_input = wx.TextCtrl(self.panel)
        self.run_button = wx.Button(self.panel, label="Run")
        self.output_display = wx.TextCtrl(self.panel, style=wx.TE_MULTILINE | wx.TE_READONLY)

        sizer = wx.BoxSizer(wx.VERTICAL)
        sizer.Add(self.command_input, flag=wx.EXPAND | wx.ALL, border=5)
        sizer.Add(self.run_button, flag=wx.EXPAND | wx.ALL, border=5)
        sizer.Add(self.output_display, proportion=1, flag=wx.EXPAND | wx.ALL, border=5)
        self.panel.SetSizer(sizer)

        self.run_button.Bind(wx.EVT_BUTTON, self.on_run)

    def on_run(self, event):
        command = self.command_input.GetValue()
        try:
            result = subprocess.run(command, shell=True, capture_output=True, text=True, executable="/bin/bash")
            self.output_display.SetValue(result.stdout or result.stderr)
        except Exception as e:
            self.output_display.SetValue(f"Error: {e}")

if __name__ == "__main__":
    app = wx.App(False)
    frame = CommandApp(None, title="Command Line GUI")
    frame.SetSize((600, 400))
    frame.Show()
    app.MainLoop()