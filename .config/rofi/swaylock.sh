grim /tmp/screenshot.png
magick /tmp/screenshot.png -blur 0x5 /tmp/screenshotblur.png
swaylock -i /tmp/screenshotblur.png
rm /tmp/screenshot.png
rm /tmp/screenshotblur.png
