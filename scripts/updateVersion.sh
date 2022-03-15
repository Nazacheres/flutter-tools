#!/bin/bash

tag="$(git tag -l | egrep v | tail -1)"
regexVersion='[0-9]\+'
version=($(echo "$tag" | grep -o $regexVersion))

if [ ${#version[@]} -eq 0 ]; then
  version=(0 0 1 1)
  newBuildVersion=$(git rev-list --count HEAD)
else
  newBuildVersion=$(git rev-list --count $(git rev-list -n 1 $tag)..HEAD)
fi

major=${version[0]}
minor=${version[1]}
patch=${version[2]}
build=$((${version[3]}+$newBuildVersion))

if [ "$1" = "major" ]; then
  ((++major))
  minor=0
  patch=0
  build=1
elif [ "$1" = "minor" ]; then
  ((++minor))
  patch=0
  build=1
elif [ "$1" = "patch" ]; then
  ((++patch))
  build=1
fi

newYamlVersion="$major.$minor.$patch+$build"
echo $newYamlVersion

# changing version in config yaml
sed -i '' "s/^\(\s*version\s*:\s*\).*/\1 $newYamlVersion/" '../pubspec.yaml'
