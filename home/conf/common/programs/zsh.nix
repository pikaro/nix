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

    bindkey '^[[3~' delete-char

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
