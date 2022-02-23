#!/bin/bash

regexVersion='[0-9]\+'
version=$(grep 'version:' ../pubspec.yaml | tail -n1); version=${version//*version:/};
buildName=($(echo "$version" | grep -o $regexVersion))

major=${buildName[0]}
minor=${buildName[1]}
patch=${buildName[2]}
build=${buildName[3]}

echo "$major.$minor.$patch+$build"
