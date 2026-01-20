if status is-interactive
    # --- 1. Abbreviations ---
    
    # Git
    abbr -a lg lazygit
    abbr -a g git
    abbr -a ga git add
    abbr -a gaa git add --all
    abbr -a gb git branch
    abbr -a gbD git branch --delete --force
    abbr -a gco git checkout
    abbr -a gcb git checkout -B
    abbr -a gc git commit --verbose
    abbr -a gca git commit --verbose --all
    abbr -a gd git diff
    abbr -a gf git fetch
    abbr -a glog git log --decorate --graph
    abbr -a gl git pull
    abbr -a gp git push
    abbr -a gpsup git push --set-upstream origin
    abbr -a gst git status

    # Utils
    # Note: Ensure you install eza, nvim, tmux first!
    abbr -a l eza --icons --group-directories-first
    abbr -a la eza --icons --group-directories-first -a
    abbr -a nv nvim
    abbr -a tm tmux
    # Replace 'cat' with 'bat' (remembering the binary is named batcat)
    abbr -a bat batcat

    # Config Editing (Updated for Linux paths)
    abbr -a fishconfig nvim ~/dotfileslinux/.config/fish/config.fish
    abbr -a tmuxconfig nvim ~/dotfileslinux/.config/tmux/tmux.conf
    abbr -a fishrestart source ~/.config/fish/config.fish

    # --- 2. Initializations ---

    # Activate Mise (Version Manager)
    # We check if the binary exists to prevent errors on new machines
    if test -f ~/.local/bin/mise
        ~/.local/bin/mise activate fish | source
    end

    # Initialize Zoxide (Better cd)
    if type -q zoxide
        zoxide init fish | source
    end

    # Initialize Starship (Prompt)
    # Ensure you run: curl -sS https://starship.rs/install.sh | sh
    if type -q starship
        # Enable transient prompt (shows minimal prompt on past lines)
        function starship_transient_prompt_func
            starship module directory
            starship module time
            starship module character
        end
        starship init fish | source
        enable_transience
    end
end
