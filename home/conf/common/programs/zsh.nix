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

  initExtra = ''
    stty -ixon

    bindkey -e

    bindkey '^[[1;5C' forward-word
    bindkey '^[[1;5D' backward-word
    bindkey '^[Oc' forward-word
    bindkey '^[Od' backward-word
    bindkey '^[[A' history-search-backward
    bindkey '^[[B' history-search-forward
    bindkey '^Q' backward-kill-word

    WORDCHARS="''${WORDCHARS/\//}"

    . ~/.local/include/entrypoint.sh;
  '';

  syntaxHighlighting = {
    enable = true;
  };
}
