#!/usr/bin/env bash

shopt -s lastpipe; # If set, and job control is not active, the shell runs the last command of a pipeline not executed in the background in the current shell environment. This allows simple access to file contents.

ROOT='.';
if [ ! -d $ROOT ]; then
  mkdir -p $ROOT;
fi;

(sed -e 's/#.*$//' -e '/^$/d' -e 's/[[:space:]]*$//' .submodules.txt) | readarray -t submodules

for ix in ${!submodules[*]}
do
  url=${submodules[$ix]};
  name=$(basename -s .git $url)
  target="${ROOT}/${name}";
  echo "($(expr ${ix} + 1)/${#submodules[*]}) $name: $url -> $target";

  if [ -d $target ]; then
    cd $target;
    git pull;
    cd -
  else
    cd $ROOT;
    git clone "${url}" "${name}";
    cd -
  fi

done
