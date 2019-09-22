# VIM Configuration
I'm revisiting my Vim configuration after... some years, as it's probably time to do a spruce up with modern changes.

## Installing VIM
Since Ubuntu's version of VIM seems to run a little behind latest, save the following in `/etc/apt/sources.list.d/jonathonf-ubuntu-vim-bionic.list`:

`deb http://ppa.launchpad.net/jonathonf/vim/ubuntu bionic main`

Also, make sure to install `vim-gtk` to get full clipboard functionality. See below for more details on integrating the clipboard correctly with Windows when running on Linux Subsystem.

### Integrating VIM Clipboard with Windows
For those who want to go the X server route, let me leave my notes here.

Install [VcXsrv](https://sourceforge.net/projects/vcxsrv/) (I found that Xming is outdated on sourceforge and the new version is donationware)

1. If it starts after installing, stop it
2. Start it using XLaunch (search in the start menu), go with all the defaults (ensure the clipboard options are checked)
3. At the end, save the configuration to a file (use that to start it from now on)
4. Put export DISPLAY=localhost:0.0 in your .bashrc in bash for Windows (and run the command in any open bash windows). The reason I explicitly say localhost is that this makes SSH X forwarding work, see below.
5. Ensure vim is installed using clipboard support. vim --version | grep clipboard should say +clipboard, not -clipboard. Also if you run the ex command :echo has('clipboard') in vim and it says 0 it does not have clipboard support compiled in. If you don't have clipboard support, install the vim-gtk package (apt-get install vim-gtk).

It should now work

As a bonus you should now be able to copy from and to your Windows clipboard from a remote machine by using SSH X forwarding (ssh -X ... ). You can use xclip on the remote machine or if you use vim there you will again need to make sure the clipboard option is compiled into vim (e.g. install vim-gtk). You can probably also configure PuTTY to use your local X server in case you prefer using that for remote connections.

## Plugins
Somewhat under the radar, Vundle seems to have been superceded by [vim-plug](https://github.com/junegunn/vim-plug), so that's what I'm going to use here.

### [Ack.vim](https://github.com/mileszs/ack.vim)
There's a little bit of setup for this one, but well worth it. It's fast as fudge searching throuugh files and finding text matches inside.

#### Requirements
- [Ack](https://beyondgrep.com/install)
- [The Silver Searcher](https://github.com/ggreer/the_silver_searcher) Not actually required, but really useful.

### [CtrlP Search](https://github.com/ctrlpvim/ctrlp.vim)

### [Deoplete](https://github.com/Shougo/deoplete.nvim) For Code Completion
