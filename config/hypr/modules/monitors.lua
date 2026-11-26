hl.monitor({output="DP-3",mode="1920x1080@320",position="0x420",scale=1})
hl.monitor({output="HDMI-A-1",mode="1920x1080@120",position="1920x0",scale=1,transform=3})
hl.monitor({output="",mode="preferred",position="auto",scale=1})

hl.workspace_rule({ workspace = "1", monitor = "DP-3", default = true })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1", default = true })
