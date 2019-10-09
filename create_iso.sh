#!/bin/bash -x -e

hdiutil create -o /tmp/macos -size 9000m -volname macos -layout SPUD -fs HFS+J
hdiutil attach /tmp/macos.dmg -noverify -mountpoint /Volumes/macos
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/macos --nointeraction
hdiutil detach /Volumes/Install\ macOS\ Mojave
hdiutil convert /tmp/macos.dmg -format UDTO -o ~/Desktop/macos.cdr
mv ~/Desktop/macos.cdr ~/Desktop/macos.iso