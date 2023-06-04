# Custom variables for this file
ZSH_CONFIG_FOLDER=~/.zsh-config # Change this to your zsh-config folder path (suggested to keep it in home directory)
USERNAME=yourUserName           # Change this to your username

# Enabling colors
autoload -U colors && colors

# Custom history settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$ZSH_CONFIG_FOLDER/history

clear
# Runnning Jupyter notebook
# It activates conda and runs Jupyter notebook
function notebook() {
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/$USERNAME/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/$USERNAME/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/$USERNAME/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/$USERNAME/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

    conda activate
    jupyter notebook
}

# Function to deactivate conda
function deactivate_conda {
    conda deactivate
}

# Automatically deactivate conda environment (by calling a function) when terminal closes (i.e. when process's SIGNAL == EXIT)
trap deactivate_conda EXIT

# YouTube downloader
function youtube() {
    python3 $ZSH_CONFIG_FOLDER/youtube-dl $1
}

# Basic auto/tab completion features
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files

# Prompt string
PS1=$'%(?.\e[1;34m✔\e[m.\e[1;39m✘\e[m) \e[1;36m%n\e[m \e[0;35m➔\e[m '

# Custom ZSH plugins
source $ZSH_CONFIG_FOLDER/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null # Syntax highlighter plugin
source $ZSH_CONFIG_FOLDER/zsh-autosuggestions/zsh-autosuggestions.zsh                     # Auto suggestion plugin
# source <(ng completion script)                                                          # Uncomment it if you have Angular installed, it helps for Angular CLI autocompletion.

# source ~/.zshrc # Apply the new configurations
