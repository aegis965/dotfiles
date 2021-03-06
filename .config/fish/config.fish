#{{{ Environment Variables
fish_add_path ~/.local/bin /usr/local/bin

set -gx LANG en_US.UTF-8
set -gx LANGUAGE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8

set -gx VISUAL (type -p nvim)
set -gx EDITOR $VISUAL
set -gx SYSTEMD_EDITOR $VISUAL

set -gx LESS '-i -J -M -R -W -x4 -z-4'
set -gx LESSOPEN '| /usr/bin/source-highlight-esc.sh %s'
set -gx _JAVA_AWT_WM_NONREPARENTING 1
set -gx IDEA_JDK '/usr/lib/jvm/jre-jetbrains'
#}}}
#{{{ Fish
set -l bg0        323d43
set -l bg1        3c474d
set -l bg2        465258
set -l bg3        505a60
set -l bg4        576268
set -l bg_red     392f32
set -l bg_green   333b2f
set -l bg_blue    203a41
set -l grey       868d80
set -l fg         d8caac
set -l red        e68183
set -l orange     e39b7b
set -l yellow     d9bb80
set -l green      a7c080
set -l cyan       87c095
set -l blue       89beba
set -l purple     d3a0bc

set -g fish_color_normal  $fg
set -g fish_color_command  $red --italics
set -g fish_color_quote  $green
set -g fish_color_redirection  $green
set -g fish_color_end  $fg
set -g fish_color_error  $red
set -g fish_color_param  $blue
set -g fish_color_comment  $grey --italics
set -g fish_color_match  --background=$bg4
set -g fish_color_search_match  $bg0 --background=$fg
set -g fish_color_operator  $orange
set -g fish_color_escape  $yellow
set -g fish_color_autosuggestion  $grey --italics
set -g fish_color_valid_path  --underline
set -g fish_color_history_current  $green
set -g fish_color_selection  --background=$bg3
set -g fish_pager_color_completion  $purple
set -g fish_pager_color_prefix  $orange --bold
set -g fish_pager_color_description  $grey --italics
set -g fish_pager_color_progress  $blue --bold

set -g fish_key_bindings fish_vi_key_bindings
#}}}
#{{{ Plugins
set -g pipenv_fish_fancy yes
#}}}
#{{{ Hooks
if test (uname -s) = "Darwin"
    test (uname -m) = "arm64"; and set -l homebrew /opt/homebrew/bin/brew; or set -l homebrew /usr/local/bin/brew

    if type -q $homebrew
        eval ($homebrew shellenv)
    end
end

if type -q thefuck
    thefuck --alias | source
end

if type -q direnv
    direnv hook fish | source
end

if type -q starship
    starship init fish | source
end

if type -q aws
    complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
end
#}}}
#{{{ Aliases
# Default Arguments
alias su='su --shell=/usr/bin/fish'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias df='df -h'
alias free='free -m'
alias mkdir='mkdir -pv'
alias tty-clock='tty-clock -s -c -D -C 6'
alias pygmentize='pygmentize -O style=forest'
alias paru='paru --skipreview --cleanafter --bottomup'

# Replacements
alias more='less'
alias vim='nvim'
alias ls='exa --group --header --git'
alias bat='bat --color=always --theme="Forest Night (Italic)" --italic-text=always'
#}}}
#{{{ Abbreviations
if status --is-interactive
    # Coreutils
    abbr -ag la		'ls -a'
    abbr -ag ld	    	'ls -aD'
    abbr -ag lt	    	'ls -aT'
    abbr -ag l	    	'ls -l'
    abbr -ag lg	    	'ls -la --git'
    abbr -ag lla	'ls -la'
    abbr -ag lld	'ls -laD'
    abbr -ag llt	'ls -laT'

    abbr -ag dud	'du -d 1 -h'
    abbr -ag duf	'du -sh *'
    abbr -ag fdd	'fd -t d'
    abbr -ag fdf	'fd -t f'
    abbr -ag map	'xargs -n1'

    # Systemd
    abbr -ag sc		'sudo systemctl'
    abbr -ag scu	'systemctl --user'
    abbr -ag jor	'journalctl'
    abbr -ag jour	'journalctl --user'

    # Trash
    abbr -ag tp		'trash-put'
    abbr -ag te		'trash-empty'
    abbr -ag tl		'trash-list'
    abbr -ag tr		'trash-restore'
    abbr -ag trm	'trash-rm'

    # Yadm
    abbr -ag y          'yadm'
    abbr -ag ya         'yadm add'
    abbr -ag yaa        'yadm add -u'
    abbr -ag yc         'yadm commit'
    abbr -ag yd         'yadm diff'
    abbr -ag ydc        'yadm decrypt'
    abbr -ag yec        'yadm encrypt'
    abbr -ag yp         'yadm push'
    abbr -ag yf         'yadm fetch'
    abbr -ag yl         'yadm pull'
    abbr -ag yrmc       'yadm rm --cached'
    abbr -ag yu         'yadm add -u; and yadm commit; and yadm push'
    abbr -ag uy         'yadm pull'

    # Amplify
    abbr -ag ampc       'amplify configure'
    abbr -ag ampi       'amplify init'
    abbr -ag ampa       'amplify add'
    abbr -ag ampu       'amplify update'
    abbr -ag ampp       'amplify push'
    abbr -ag ampl       'amplify pull'
    abbr -ag amppb      'amplify publish'
    abbr -ag amps       'amplify status'
    abbr -ag ampsr      'amplify serve'
    abbr -ag ampd       'amplify delete'
    abbr -ag amph       'amplify help'
    abbr -ag ampg       'amplify codegen'
    abbr -ag ampgm      'amplify codegen models'
    abbr -ag ampe       'amplify env'

    # Arch
    abbr -ag par        'paru'
    abbr -ag pain       'paru -S'
    abbr -ag parin      'paru --redownload --rebuild -S'
    abbr -ag paupg      'paru -Syu'
    abbr -ag parem      'paru -Rns'
    abbr -ag parec      'paru -Sc'
    abbr -ag pareo      'paru --clean'

    abbr -ag gimme      'paru -S'
    abbr -ag yeet       'paru -Rns'
    abbr -ag relax      'paru -Syu'

    # VPN
    abbr -ag vpn        'expressvpn'
    abbr -ag vpna       'expressvpn activate'
    abbr -ag vpnc       'expressvpn connect'
    abbr -ag vpncs      'expressvpn connect smart'
    abbr -ag vpnd       'expressvpn disconnect'
    abbr -ag vpns       'expressvpn status'
    abbr -ag vpnl       'expressvpn list'
    abbr -ag vpnla      'expressvpn list all'
    abbr -ag vpnr       'expressvpn refresh'
    abbr -ag vpnp       'expressvpn preferences'
    abbr -ag vpnh       'expressvpn help'
    abbr -ag vpnlock    'expressvpn preferences set network_lock on'
    abbr -ag vpnunlock  'expressvpn preferences set network_lock off'

    # ADB
    abbr -ag asm        'adb-sync ~/Music/ /sdcard/Music/'
    abbr -ag asm2       'adb-sync -2 ~/Music/ /sdcard/Music/'
    abbr -ag asmd       'adb-sync -d ~/Music/ /sdcard/Music/'
    abbr -ag asmr       'adb-sync -R /sdcard/Music/ ~/Music/'
    abbr -ag asmrd      'adb-sync -R -d /sdcard/Music/ ~/Music/'
    abbr -ag ash        'adb-sync-hosts'

    # Misc
    abbr -ag q          'exit'
    abbr -ag e          'vifm'
    abbr -ag v          'nvim'
    abbr -ag uv         "nvim '+PlugUpdate' '+PlugClean!' '+PlugUpdate' '+qall'"
    abbr -ag x          'extract'
    abbr -ag aw         'awman'
    abbr -ag k3         'kid3-qt'
    abbr -ag ping       'prettyping'
    abbr -ag p8         'prettyping 8.8.8.8'
    abbr -ag abcdef     'abcde -o flac:"--best"'
    abbr -ag abcdem     'abcde -o m4a:"-b 320"'
    abbr -ag ea         'for a in (abbr -l); abbr -e $a; end'
    abbr -ag ef         'exec fish'
    abbr -ag ur         'sudo reflector -p http -p https -l 30 -n 20 --sort rate --save /etc/pacman.d/mirrorlist --verbose'
    abbr -ag bye        'poweroff'
    abbr -ag battery    'upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|to\ full|percentage"'
    abbr -ag fdir       'cd ~/.config/fish/'
    abbr -ag fconf      'vim ~/.config/fish/config.fish'
    abbr -ag sconf      'vim ~/.config/spectrwm/spectrwm.conf'
end
#}}}
#{{{ Functions
function cd --wraps cd
    if count $argv > /dev/null
        builtin cd "$argv"; and ls
    else
        builtin cd ~; and ls
    end
end

function man --wraps man -d "Run man with added colors"
    set -l bold_ansi_code "\u001b[1m"
    set -l underline_ansi_code "\u001b[4m"
    set -l reversed_ansi_code "\u001b[7m"
    set -l reset_ansi_code "\u001b[0m"
    set -l teal_ansi_code "\u001b[38;5;109m"
    set -l green_ansi_code "\u001b[38;5;144m"
    set -l cyan_ansi_code "\u001b[38;5;180m"

    set -x LESS_TERMCAP_md (printf $bold_ansi_code$teal_ansi_code) # start bold
    set -x LESS_TERMCAP_me (printf $reset_ansi_code) # end bold
    set -x LESS_TERMCAP_us (printf $underline_ansi_code$green_ansi_code) # start underline
    set -x LESS_TERMCAP_ue (printf $reset_ansi_code) # end underline
    set -x LESS_TERMCAP_so (printf $reversed_ansi_code$cyan_ansi_code) # start standout
    set -x LESS_TERMCAP_se (printf $reset_ansi_code) # end standout
    command man $argv
end

function mkc --wraps mkdir -d "Create a directory and set CWD"
    command mkdir $argv
    if test $status = 0
        switch $argv[(count $argv)]
            case '-*'

            case '*'
                cd $argv[(count $argv)]
                return
        end
    end
end

function extract -d 'Expand or extract bundled & compressed files'
    if test -f $argv
        switch $argv
            case \*.rar
                unrar x $argv
            case \*.zip
                unzip $argv
            case \*.tar.bz2
                tar xvjf $argv
            case \*.tar.gz
                tar xvzf $argv
            case \*.bz2
                bunzip2 $argv
            case \*.gz
                gunzip $argv
            case \*.tar
                tar xvf $argv
            case \*.tbz2
                tar xvjf $argv
            case \*.tgz
                tar xvzf $argv
            case \*.Z
                uncompress $argv
            case \*.7z
                7z x $argv
            case '*'
                echo "unknown extension"
        end
    else
        echo "Could not extract $argv"
    end
end

function fish_greeting
    if type -q fish_logo
        fish_logo $red $orange $yellow
    end
end
#}}}
#{{{ Start Actions
# Start X at Login
if status is-login; and test -z "$DISPLAY" -a "$XDG_VTNR" = 1
    exec startx -- -keeptty &> /dev/null
end
#}}}
