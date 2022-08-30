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
  echo
  echo

  echo "---------------"
  echo "UPLOAD: ($(expr ${ix} + 1)/${#submodules[*]}) $name: $url -> $target";
  echo "---------------"

  if [ -d $target ]; then
    cd $target;
    git pull;
    git add .;
    git commit -m 'New Revisions';
    git push;
    cd -
  fi

done
