#!/usr/bin/env sh

# ---------------------------------------------------------------------------
# nO0bs - Noibe's macOs day-0 Bootstrapping Scripts

# ---------------------------------------------------------------------------

# MOVED FROM .zshrc TO HERE -----------------------------
# -------------------------------------------------------
# Find a way to make entr run in the background, then
#   echo /Users/noibe/.config/yabai/yabairc | entr /bin/sh /Users/noibe/.config/yabai/yabairc
#   echo /Users/noibe/.config/tmux/tmux.conf | entr /usr/local/bin/tmux source /Users/noibe/.config/tmux/tmux.conf
# Set wallpaper from command line
#   osascript -e 'tell application "Finder" to set desktop picture to POSIX file "<absolute_path_to_file>"'
#   osascript -e 'quit app "Finder"'
# Or, to use it inside a shell function,
#   osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$1\""

# Disable the "Are you sure you want to open this application?" dialog
#   defaults write com.apple.LaunchServices LSQuarantine -bool false

# List all songs and pipe them into tmd
#   find ~/Music -iname "*\.mp3" -print0 | xargs -0 tmd

# Change TeX home tree
#   sudo tlmgr conf texmf TEXMFHOME "~/TeX/texmf"

# Empty Dock
#   defaults write com.apple.dock recent-apps -array
#   defaults write com.apple.dock persistent-apps -array

# Hide Dock
#   defaults write com.apple.dock autohide-delay -float 1000

# Keep programs out of dock
#   System Preferences -> Dock -> Show recent applications in Dock [uncheck]

# If Dock gets stuck and won't launch anymore
#   launchctl unload -F /System/Library/LaunchAgents/com.apple.Dock.plist
#   launchctl   load -F /System/Library/LaunchAgents/com.apple.Dock.plist
#   launchctl start com.apple.Dock.agent
#   launchctl unload -F /System/Library/LaunchAgents/com.apple.Dock.plist
#   /System/Library/CoreServices/Dock.app/Contents/MacOS/Dock
#   rm -rf ~/Library/Application Support/Dock
#   rm -rf ~/Library/Preferences/com.apple.dock.plist
#   sudo reboot

# Write to /System
#   sudo mount -uw /
#   killall Finder

# defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
# defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)A
# -------------------------------------------------------
# -------------------------------------------------------


# ---------------------------------------------------------------------------
# System Preferences -> Mission Control -> Uncheck "Automatically rearrange spaces based of most recent use"
# System Preferences -> Keyboard -> Key Repeat all the way to the right
# System Preferences -> Keyboard -> Delay Until Repeat all the way to the right

# Quit the finder
defaults write com.apple.finder QuitMenuItem -bool false && killall Finder

# Remove 'Other' from login screen
sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWOTHERUSERS_MANAGED -bool FALSE

# Disable Gatekeeper and open every program without being asked for confirmation
sudo spctl --master-disable
# System Preferences -> Security & Privacy -> Allow apps downloaded from -> Check "Anywhere"

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# push to github without password
ssh-keygen -t rsa -C "riccardo.mazzarini98@gmail.com"
# copy the content of ~/.ssh/id_rsa.pub, go to github -> settings -> ssh and gpg keys -> new ssh key -> paste
# answer 'yes' to
ssh -T git@github.com
# go to the repository on github, close or download -> use ssh url, copy that url and paste it in <git_repo>/.git/config under [remote "origin"]


# silence startup sound (it's one of these ones, they should be system-dependent)
#sudo nvram SystemAudioVolume=%80
sudo nvram SystemAudioVolume=%01 # this is the first one that worked on my macbook (haven't tried the next 2)
#sudo nvram SystemAudioVolume=%00
#sudo nvram SystemAudioVolume=" "


# KEEP FINDER FROM OPENING WHEN NO OTHER APPS ARE OPENED
launchctl unload /System/Library/LaunchAgents/com.apple.Finder.plist

# FINDER OUT OF DOCK AND CMD-TAB MENU (https://apple.stackexchange.com/questions/30415/how-can-i-remove-the-finder-icon-from-my-dock?newreg=7853552a016a48d2a67c03406a1b7af9)
sudo nvim /System/Library/CoreServices/Dock.app/Contents/Resources/DockMenus.plist
# find the sections 'finder-quit', 'finder-running' and 'trash', and add a new subsection to them:
<dict>
    <key>command</key>
    <integer>1004</integer>
    <key>name</key>
    <string>REMOVE_FROM_DOCK</string>
</dict>
# open the Finder, then
killall Dock
# right click on the finder icon in the Dock and remove it


# STOP CREATION OF .DS_Store FILES
# download the latest .zip release from 'https://github.com/xiaozhuai/odourless/releases'
# move it to /Applications
# in case it doesn't launch (in my case it said something like 'this has to be under /Applications', even if it was under /Applications), just run it from the command line:
# /Applications/Odourless.app/Contents/MacOS/odourless
# install the daemon on the lil gui that pops up
# reboot and you should be gucci


# Change TeX directory
sudo tlmgr conf texmf TEXMFHOME "~/Library/texmf"



# 1. Disable SIP (can't be done via script, has to be done manually)
# 2. Download homebrew
#      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
# 3. Enable tab to click
#      System Preferences -> Trackpad -> Check 'Tap to click'
# 4. Make brew casks available
#      brew tap caskroom/cask
# 5. Download firefox
#      brew cask install firefox
# 6. Add battery percentage to menu bar
#      Click battery icon in menu bar -> Show Percentage
# 7. Remove input sources in menu bar
#      System Preferences -> Keyboard -> Input Sources -> Uncheck 'Show Input menu in menu bar'
# 8. Show Bluetooth in menu bar
#      System Preferences -> Bluetooth -> Check 'Show Bluetooth in menu bar'
# 9. Manually put bluetooth icon between Wi-Fi and battery in menu bar
# 10. Disable Gatekeeper (pt 1)
#       sudo spctl --master-disable; defaults write com.apple.LaunchServices LSQuarantine -bool false
# 11. Open firefox without being prompted for dialog
#       sudo xattr -r -d com.apple.quarantine /Applications/Firefox.app
# 12. Edit sudoers file to uso sudo without password
#       echo "noibe ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# 13. Download bitwarden firefox extension
# 14. Sign in to gmail to get bitwarden master password
# 15. Remove apps from dock
#       defaults write com.apple.dock recent-apps -array
#       defaults write com.apple.dock persistent-apps -array
#       killall Dock
# 16. Remove downloads folder from Dock
#       Right click downloads folder -> Options -> Remove from Dock
# 17. Keep programs out of dock
#       System Preferences -> Dock -> Uncheck 'Show recent applications in Dock'
# 18. Show Dock on hover only
#       System Preferences -> Dock -> Uncheck 'Automatically hide and show the Dock'
# 19. Hide Dock
#       defaults write com.apple.dock autohide-delay -float 1000
#       killall Dock
# 20. Show menu bar on hover only
#       System Preferences -> General -> Check 'Automatically hide and show the menu bar'
# 21. Change key repeat and initial key repeat
#       defaults write -g InitialKeyRepeat -int 10
#       defaults write -g KeyRepeat -int 10
# 22. Don't rearrange spaces
#       System Preferences -> Mission Control -> Uncheck 'Automatically rearrange Spaces based on most recent use'
# 23. Remove everything from notifications 'Today' page
# 24. Remove public folder from home folder
#       sudo rm -rf Public
# 25. Install programs
#       brew install zsh entr calcurse fd git lf nvim tmux transmission-cli redshift coreutils koekeishiya/formulae/yabai koekeishiya/formulae/skhd fzf zsh-autosuggestions zsh-syntax-highlighting
#       brew cask install alacritty
# 26. Change shell to zsh
#       sudo sh -c 'echo /usr/local/bin/zsh >> /etc/shells'
#       chsh -s /usr/local/bin/zsh
# 27. Install vim-plug
#       curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# 28. Install dropbox
#       brew cask install dropbox
# 29. Allow skhd and yabai accessibility permission
# 30. Key repeat
#       System Preferences -> Keyboard -> Key repeat both to max
# 31. Allow dropbox accessibility permissions
# 32. Link greyscale vim lightline
# 33. Set correct time
#       System Preferences -> Date and time -> Time Zone -> select time zone
# 34. Compaudit
#       compaudit
#       sudo chmod -R 755 the top directory of each compaudit (in my case it returned the directoryies /usr/local/share/zsh and /usr/local/share/zsh/site-functions, so sudo chmod -R 755 /usr/local/share/zsh was enough)
# 35. Login firefox
# 36. firefox about:config options
# 37. load firefox config
#     cd ~/Library/Application\ Support/Firefox/Profiles/*-release/
#     mkdir chrome && cd chrome
#     ln -s ~/.config/firefox/userChrome.css
#     ln ~/.config/firefox/userContent.css
# 38. Install iosevka nerd font
#       brew cask install font-iosevka-nerd-font
# 39. Install ssh
#       brew install openssh
# 40. download scripts folder
#      git clone https://github.com/n0ibe/scripts
# 41. create ssh key for github
#     ssh-keygen -t rsa -C "riccardo.mazzarini98@gmail.com"
# # copy the content of ~/.ssh/id_rsa.pub, go to github -> settings -> ssh and gpg keys -> new ssh key -> paste
# # answer 'yes' to
# ssh -T git@github.com
# # go to the repository on github, close or download -> use ssh url, copy that url and paste it in <git_repo>/.git/config under [remote "origin"]
# 42. download calcurse
#       git clone https://github.com/n0ibe/calcurse
#       mv calcurse ~/.local/share/
# 43. remove finder and trash from dock
#       sudo mount -uw /
#       killall Finder (maybe not necessary)
#       sudo nvim /System/Library/CoreServices/Dock.app/Contents/Resources/DockMenus.plist
#       find the sections 'finder-quit', 'finder-running', 'trash' and add a new entry
#       <dict>
#           <key>command</key>
#           <integer>1004</integer>
#           <key>name</key>
#           <string>REMOVE_FROM_DOCK</string>
#       </dict>
# 44. link at login files
#       cd /Library/LaunchDaemons
#       sudo ln -s ~/scripts/@login/Odourless/odourless-daemon.plist
#       launchctl load /Library/LaunchDaemons/odourless-daemon.plist
#       reboot and test if it works
# 45. rm ~/.config/zsh/.zsh-history ~/.CFUserTextEncoding ~/.viminfo ~/.zsh-history
# 46. make zsh history dir
#       mkdir ~/.cache/zsh
# 47. link login files
#     cd ~/Library/LaunchAgents
#     ln -s ~/scripts/@login/....plist
#     launchctl load ./*.plist
# 48. disable remove from dock sound
#         System Preferences -> Sound -> Uncheck 'Play user interface sound effects'
# 49. install texlive
#       brew cask install mactex-no-gui
#       git clone https://github.com/n0ibe/texmf
#       mv texmf ~/Library/texmf
#       sudo ln -s ~/Library/tex/context /usr/local/texlive/texmf-local/tex/
# 50. install ndiet
#       mkdir ~/bin && cd ~/bin
#       git clone https://github.com/n0ibe/ndiet
#       pip3 install pyfiglet
#       pip3 install docopt
#       pip3 install gkeepapi
# 52. install speedtest
#       brew install speedtest-cli
# 53. rename host
#       sudo scutil --set ComputerName "MBAir" LocalHostname "MBAir" HostName "MBAir"
# 54. for every git folder downloaded, edit the remote origin url in the git config file to be of the form git@github.com:n0ibe/<repo_name>.git
# 55. load vimium c config file
# 56. Finder
#     defaults write com.apple.finder QuitMenuItem -bool true; killall Finder
#     Preferences -> Uncheck 'External disks' and 'CDs, DVDs and iPods'
#     Preferences -> New Finder windows show home
#     Delete all Tags
#     Remove Documents Desktop Recents Airdrop from Sidebar
#     Add ~ and .config to sidebar
#     Order sidebar folders with Applications on top
#     brew cask install mysides
#     mysides add dotfiles file:///Users/noibe/.config to add config folder, also options to list and remove folders from favourites in finder sidebar
#     tags can be deleted from preferences -> tags
#     stuff can be removed from sidebar via preferences -> sidebar
#     preferences -> advanced to show filename extensions, dont show warnings
#     show view options -> group by name sort by name -> use as defaults
# 57. Attach an external display and rearrange so that the external is the main one
# 58. download logitech options
#       brew tap homebrew/cask-drivers
#       brew cask install logitech-options (have to reboot for it to take effect)
#       allow accessibility to logitech options (have to select it manually clicking on +)
# 59. install lf previews
#       brew install mediainfo highlight
#       brew cask install pdftotext
# 60. install skim
#       preferences -> Sync -> Check 'check for file changes' and 'reload automatically'
# 61. use skim as default pdf viewer
#       right click on a pdf file -> get info -> open with: skim.app -> change all
# 62. debloat skim
#       skim -> view -> hide contents pane and notes pane, toogle toolbar
#       skim -> preferences -> general -> remember lat page viewed
# 63. brew cask install mpv
# 64. tell transmission to run script when torrent is done
#       transmission-remote --torrent-done-script ~/scripts/transmission/notify-done.sh
# 65. login youtube, switch account and enable dark mode and english
# 66. brew install terminal-notifier
# 67. Allow terminal-notifier notifications
# 68. System Preferences -> Energy Saver -> never computer and display sleep for battery and power adapter
# 69. System Preferences -> Energy Saver -> Uncheck 'put hard disks to spleep when possible' and 'slightly dim the display while on battery power'
# 70. Logitech options -> zoom with wheel,
#     Logitech options -> Point & Scroll -> Scroll direction -> Natural, Thumb wheel direction -> Inverted
#     set pointer and scrolling speed
#     Smooth scrolling -> disabled
# 71. System Preferences -> Desktop & Screen Saver -> Screen Saver -> Start after: Never
# 72. System Preferences -> Date and Time -> Clock -> Date Options check 'show the day of the week'
# 73. sudo touch /etc/zshenv && echo "export ZDOTDIR=~/.config/zsh" | sudo tee /etc/zshenv >/dev/null
# 74. brew install tree
# 75. mkdir ~/.cache/python
# 75. mkdir ~/.cache/less
# 76. defaults write com.apple.Finder AppleShowAllFiles true
# 77. System preferences -> General -> show scroll bars -> when scrolling
# 78. Font Book -> User -> Iosevka Nerd Font -> disable everything except Medium Regular Italic Bold Heavy Bold-Italic
# 79. LogiOptions bind buttons to 'KeyStroke Assignment: Cmd + Left' and 'KeyStroke Assignment: Cmd + Right' (or don't, do that only if you need them to work with qutebrowser, otherwise stick with forward and back)
# 80. Use /usr/local/etc/gitconfig for git config file instead of ~/.config/gitconfig. To use that you need to use the --system flag, so for ex 'git config --system user.name n0ibe' etc. To list all configs and the file where they are defined use 'git config --list --show-origin'
# 82. brew cask install whatsapp
# 84. brew cask install ubersicht
# 85. remove spotlight from the menu bar
#     https://www.idownloadblog.com/2017/02/02/disable-spotlight-remove-menu-bar/
#     basically
#     cd /System/Library/CoreServices/Spotlight.app/Contents/MacOS
#     sudo mount -uw /
#     sudo cp Spotlight Spotlight-backup
#     sudo perl -pi -e 's|(\x00\x00\x00\x00\x00\x00\x47\x40\x00\x00\x00\x00\x00\x00)\x42\x40(\x00\x00\x80\x3f\x00\x00\x70\x42)|$1\x00\x00$2|sg' Spotlight
#     sudo codesign -f -s - Spotlight
#     sudo killall Spotlight
# input password if asked. If it worked 'sudo rm Spotlight-backup'
# 86. 'pip3 install neovim' for UltiSnips

# # git clone https://github.com/Aloxaf/fz-tab /usr/local/share/fz-tab
# # git clone https://github.com/zdharma/fast-syntax-highlighting /usr/local/share/fast-syntax-highlighting
# # brew install zsh-autosuggestions
# # git clone https://github.com/kutsan/zsh-system-clipboard /usr/local/share/zsh-system-clipboard
# # git clone https://github.com/hlissner/zsh-autopair /usr/local/share/zsh-autopair

# pip3 install buku
# ln -s ~/Dropbox/share/buku/bookmarks.db ~/.local/share/buku/bookmarks.db

# 86. brew cask install qview
# 87. to get skim to do backward search you first need to 'pip3 install pynvim neovim-remote', then open Skim -> Preferences -> Sync -> Preset: Custom, Command: nvr, Arguments: --remote +"%line" "%file". It doesn't work too well since it triggers the BufUnload event so with the way I have things set up the pdf file closes, but the backward search also doesn't expand folds so it's kinda useless
# 88. install vimtex for coc via
#     :CocInstall coc-vimtex
# 89. SQUARE BORDERS

# Place DarkAquaAppearance.car file found here (https://github.com/tsujp/custom-macos-gui/tree/master/DarkAquaAppearance/Edited) in /System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/DarkAquaAppearance.car. Will have to unmount the filesystem first with

# sudo mount -uw /

# then move the file there replacing the one that's already there, then reboot. (https://www.reddit.com/r/unixporn/comments/i7s3t1/yabaiwm_monokai_machintosh/g16gnck?utm_source=share&utm_medium=web2x)

# 90. pip3 install jedi if coc-python gives problems
