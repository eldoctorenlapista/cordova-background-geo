#!/usr/bin/env bash

platform=$1
src_root=""
target_regexp=""
sources_regexp=""
current_dir=$(pwd)
script_dir=$( cd "$(dirname "$0")" ; pwd -P )

if [[ "$platform" == android ]]; then
  src_root="android"
  target_regexp="s|android/.*/src/main/java|src|"
  sources_regexp=".*/src/main/java/.*\.java"
elif [[ "$platform" ==  ios ]]; then
  src_root="ios"
  sources_regexp=".*BackgroundGeolocation/.*\.[h,m]"
else
  echo "Missing or wrong parameter. Must be either: ios or android"
  exit 1;
fi

src_dir=$( cd "$script_dir/../$src_root" ; pwd )

if [[ "$current_dir/$src_root" != "$src_dir" ]]; then
  echo "Must be run from root dir: sh ./scripts/gen_sources.sh platform"
  exit 1
fi

src_files=$(find $src_dir -regex $sources_regexp | sed "s|$src_dir|$src_root|" | sort)

echo "<!-- Generated with gen_sources.sh @ $(date '+%Y-%m-%d %H:%M:%S') -->"
for f in $src_files; do
  if [[ ! -z "$target_regexp" ]]; then
    target_name=$(echo $f | sed $target_regexp)
    target_attr="target-dir=\"$(dirname $target_name)\" "
  fi
  if [[ "$f" == *h ]]; then
    echo "<header-file src=\"$f\" $target_attr/>"
  else
    echo "<source-file src=\"$f\" $target_attr/>"
  fi
done
echo "<!-- End of generated sources -->"
