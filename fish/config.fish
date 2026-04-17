if status is-interactive
set -g fish_greeting
    # --- Homebrew ---
    eval (/opt/homebrew/bin/brew shellenv)

    # --- Paths ---
    fish_add_path $HOME/.cargo/bin
    fish_add_path $HOME/bin
    fish_add_path $HOME/.local/bin
    fish_add_path /usr/local/bin
    fish_add_path /Users/ahmetdagustun/.spicetify
    fish_add_path /Users/ahmetdagustun/.local/bin

    # --- Tool Initializations ---
    zoxide init fish | source
    thefuck --alias fk | source
    
    # fzf configuration
    set -gx FZF_DEFAULT_OPTS "--preview 'bat --color=always {}'"

    # --- Functions ---
    
    # Yazi: Change directory on exit
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    # --- Aliases ---
    alias spoofon='launchctl load ~/Library/LaunchAgents/com.spoofdpi.plist'
    alias spoofoff='launchctl unload ~/Library/LaunchAgents/com.spoofdpi.plist'
    alias dots='cd ~/dotfiles'
    alias fconf='code ~/.config/fish/config.fish'
    alias zconf='code ~/.zshrc'
    alias reload='source ~/.config/fish/config.fish'
    alias bsync='brew bundle dump --force --file=~/dotfiles/Brewfile && cd ~/dotfiles && git add Brewfile && git commit -m "update Brewfile" && git push && cd -'
    alias mc='ssh adagustun@100.66.114.110'
    alias path='echo $PATH | tr " " "\n"'
    alias ports='sudo lsof -iTCP -sTCP:LISTEN -P -n'
    alias speed='networkQuality'
    alias ls='eza --icons'
    alias ll='eza --icons -la'
    alias lt='eza --icons --tree'
    alias lg='lazygit'
    alias ytd='yt-dlp'
    alias ytdja='yt-dlp --write-sub --sub-lang ja'
    alias todo='~/meowdo/meowdo' 
end