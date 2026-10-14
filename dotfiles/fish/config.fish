if status is-interactive
    if command -q starship
        starship init fish | source
    end
    if command -q zoxide
        zoxide init fish | source
    end
    set -g fish_greeting
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    alias ll 'ls -lah'
    alias gs 'git status'
end
