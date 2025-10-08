{sysInfo, ...}: {
  enable = true;
  aliases = {
    "a" = "add";
    "aa" = "add .";
    "b" = "!git for-each-ref --color=always --sort='-committerdate:iso8601' --format=' %(color:brightblack)%(committerdate:iso8601)%09%(committerdate:relative)%09%(color:blue)[%(authorname)]%09%(if:equals=master)%(refname:short)%(then)%(color:red)%(else)%(if:equals=development)%(refname:short)%(then)%(color:green)%(else)%(color:cyan)%(end)%(end)%(refname:short)%09%(color:reset)%(contents:subject)' refs/heads | column -ts$'\\t'";
    "c" = "checkout";
    "ca" = "commit --amend";
    "can" = "commit --amend --no-edit --no-verify";
    "cm" = "commit -m";
    "cmn" = "commit --no-verify -m";
    "d" = "diff -w";
    "f" = "fetch";
    "l" = "log --pretty=format:\"%C(yellow)%h\\ %ai%Cred%d\\ %C(brightwhite)%s%Cblue\\ [%cn]\" --decorate --date=short";
    "lg" = "!git log --graph --oneline --decorate --all";
    "m" = "merge";
    "p" = "push";
    "u" = "pull";
    "s" = "status";
    "t" = "tag --sort=-taggerdate";
    "ff" = "flow feature";
    "ffc" = "flow feature checkout";
    "ffs" = "flow feature start";
    "fff" = "flow feature finish --squash --force_delete";
    "ffp" = "flow feature publish";
    "fr" = "flow release";
    "frc" = "flow release checkout";
    "frs" = "flow release start";
    "frf" = "flow release finish --keepremote";
    "frp" = "flow release publish";
    "fh" = "flow hotfix";
    "fhc" = "flow hotfix checkout";
    "fhs" = "flow hotfix start";
    "fhf" = "flow hotfix finish --squash --force_delete";
    "fhp" = "flow hotfix publish";
  };
  delta.enable = true;
  extraConfig = {
    init = {
      defaultBranch = "dev";
      templateDir = "~/.git-template";
    };
    gitflow = {
      prefix = {
        feature = "feature/";
        release = "release/";
        hotfix = "fix/";
        bugfix = "fix/";
        versiontag = "v";
        support = "support/";
      };
      branch = {
        master = "master";
        develop = "dev";
      };
    };
    push = {
      autoSetupRemote = true;
    };
    pull = {
      rebase = true;
    };
    rebase = {
      autostash = true;
    };
  };
  ignores = [
    "*~"
    "*.swp"
    "*.pyc"
    "*.pyo"
    "*.pyd"
    "*.o"
    "*.out"
    "*.log"
    "*.tmp"
    "*.bak"
    ".DS_Store"
  ];
  lfs = {
    enable = true;
  };
  userEmail = "git@d-reis.com";
  userName = sysInfo.userName;
}
