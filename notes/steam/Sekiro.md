# Sekiro FPS Unlock and Other Fixes

Sekiro was kind of a pain to get running correctly so imma write this down

## FPS Unlock

1. Download latest release of FPS unlocking tool [Link](https://github.com/Lahvuun/sekirofpsunlockhttps:/)
2. Unpack tar.gz file with `tar -xzf <file.tar.gz>`
3. Set steam launch arguments for Sekiro as ` <absolute path of exe> 30 set-fps 240 & mangohud %command%`
   Example: `/home/jared/Tools/sekirofpsunlock 30 set-fps 240 & mangohud %command%`

## Graphics Tab Crashes Game

This is probably caused by playing on a 4k monitor

1. Open `~/.local/share/Steam/steamapps/compatdata/814380/pfx/drive_c/users/steamuser/AppData/Roaming/Sekiro/GraphicsConfig.xml`
2. Change reolution numbers to 1920 and 1080 instead of 3840 and 2160
3. Dont change any other settings here and do it in game to be safe
4. Launch game and graphics settings tab should work

## No Worky

put [this file](https://github.com/Lahvuun/sekirofpsunlock/blob/master/contrib/dxvk.confhttps:/) in the game folder
