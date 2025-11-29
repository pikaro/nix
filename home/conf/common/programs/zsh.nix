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
    PATH_ORIG="$PATH"
    PATH_SYS="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    PATH_NIX="''${PATH_ORIG%''${PATH_SYS}}"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    PATH_BREW="''${PATH%''${PATH_ORIG}}"
    PATH="$PATH_NIX$PATH_BREW:$PATH_SYS"
    PATH="$HOME/.bin:$PATH"
    PATH="$HOME/.local/bin:$PATH"
    PATH="$HOME/.local/gitbin:$PATH"
    export PATH
  '';

  syntaxHighlighting = {
    enable = true;
  };
}
