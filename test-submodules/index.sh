#!/usr/bin/env bash

ROOT='.';
if [ ! -d $ROOT ]; then
  mkdir -p $ROOT;
fi;

shopt -s lastpipe; # If set, and job control is not active, the shell runs the last command of a pipeline not executed in the background in the current shell environment. This allows simple access to file contents.
(sed -e 's/#.*$//' -e '/^$/d' -e 's/[[:space:]]*$//' .submodules.txt) | readarray -t submodules

for ix in ${!submodules[*]}
do
  url=${submodules[$ix]};
  name=$(basename -s .git $url)
  target="${ROOT}/${name}";
  if [ -d $target ]; then
    cd $target;
    if [[ -z $(git status -s) ]]; then
      echo "$(tput setaf 2)[OK]$(tput sgr 0) ${name} has no local changes."
    else
      echo "$(tput setaf 1)[NO]$(tput sgr 0) ${name} has uncommited changes. SOLUTION: ./publish.sh"
    fi

    cd - > /dev/null
  fi

done
