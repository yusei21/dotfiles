# Configuração do Shell Fish do Sunny
function fish_greeting
end
fish_add_path /home/sunny/.spicetify
~/.local/bin/mise activate fish | source
alias ollama-start="sudo systemctl start ollama"
alias brave="brave --password-store=basic"
set -gx PATH "/home/sunny/.local/bin" $PATH
set -gx PATH $PATH /home/sunny/.lmstudio/bin
