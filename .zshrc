source ~/.antigen/antigen.zsh

alias set_proxy="export ALL_PROXY=socks5://127.0.0.1:1080"
alias unset_proxy="unset ALL_PROXY"
alias getip="curl ifconfig.co"

alias getjson_ip="curl -s ifconfig.co/json|json_pp"
alias getjson_ip="curl -s ifconfig.co/json|jq ."

# Load the oh-my-zsh's library.
  antigen use oh-my-zsh

  # Bundles from the default repo (robbyrussell's oh-my-zsh).
  antigen bundle command-not-found  # suggests package name with relevant command
  antigen bundle docker             # docker autocomplete plugin
  antigen bundle gem                # support for Ruby package manager
  antigen bundle git                # support for git
  antigen bundle history            # aliases: h for history, hsi for grepping history
  antigen bundle npm                # support for NodeJS package manager
  antigen bundle pip                # support for Python Package Manager
  antigen bundle rvm                # support for Ruby version manager

  # Additional completion definitions for Zsh.
  antigen bundle zsh-users/zsh-completions src
  antigen bundle sdurrheimer/docker-compose-zsh-completion
  antigen bundle zsh-users/zsh-autosuggestions
  antigen bundle zsh-users/zsh-completions
  # Load the theme.
  antigen theme myzsh

  # Tell antigen that you're done.
  antigen apply
