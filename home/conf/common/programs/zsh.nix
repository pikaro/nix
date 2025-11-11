{...}: {
  enable = true;
  enableCompletion = true;
  # FIXME: What is this from docs?
  # environment.pathsToLink = [ "/share/zsh" ];

  autosuggestion = {
    enable = true;
  };

  history = {
    append = true;
    expireDuplicatesFirst = true;
    extended = true;
    findNoDups = true;
    ignoreAllDups = true;
    ignoreSpace = true;
    save = 10000;
    saveNoDups = true;
    share = false;
    size = 10000;
  };

  initContent = ''
    stty -ixon

    bindkey -e

    WORDCHARS=

    autoload -U select-word-style
    select-word-style normal
    zle -N backward-kill-shell-word backward-kill-word-match
    zstyle :zle:backward-kill-shell-word word-style shell

    bindkey '^[[1;5C' forward-word
    bindkey '^[[1;5D' backward-word
    bindkey '^[[A' history-search-backward
    bindkey '^[[B' history-search-forward
    bindkey '^Q' backward-kill-word
    bindkey '^W' backward-kill-shell-word
    bindkey '^[[3~' delete-char
    bindkey '^R' history-incremental-search-backward

    . ~/.local/shell-include/entrypoint.sh;
  '';

  envExtra = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="$HOME/.bin:$PATH"
    export PATH="$HOME/.local/bin:$PATH"
    export PATH="$HOME/.local/gitbin:$PATH"
  '';

  syntaxHighlighting = {
    enable = true;
  };
}
