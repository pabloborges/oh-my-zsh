grey='\e[0;90m'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$grey%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$grey%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$grey%})"

function pablo_prompt {
  (( spare_width = ${COLUMNS} ))
  prompt=" "

  branch=$(current_branch)
  ruby_version=$(rvm_prompt_info)
  path_size=${#PWD}+4
  branch_size=${#branch}
  ruby_size=${#ruby_version}
  # user_machine_size=${#${(%):-%n@%m-}}

  if [[ ${#branch} -eq 0 ]]
    then (( ruby_size = ruby_size + 1 ))
  else
    (( branch_size = branch_size + 4 ))
    if [[ -n $(git status -s 2> /dev/null) ]]; then
      (( branch_size = branch_size + 2 ))
    fi
  fi

  # (( spare_width = ${spare_width} - (${user_machine_size} + ${path_size} + ${branch_size} + ${ruby_size}) ))
  (( spare_width = ${spare_width} - (${path_size} + ${branch_size} + ${ruby_size}) ))

  while [ ${#prompt} -lt $spare_width ]; do
    prompt=" $prompt"
  done

  prompt="%{%F{magenta}%}[%{%F{green}%}$PWD%{%F{magenta}%}]$prompt%{%F{red}%}$(rvm_prompt_info)%{$reset_color%} $(git_prompt_info)"

  echo $prompt
}

setopt prompt_subst

PROMPT='
╭─$(pablo_prompt)
╰─%(?,%{%F{green}%},%{%F{red}%})⚡%{$reset_color%}'
