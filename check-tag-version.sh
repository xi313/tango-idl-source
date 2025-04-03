#! /usr/bin/env bash

if [[ -z "$CI_COMMIT_TAG" ]]
then
  exit 0
fi

grep -qP "^set\(PACKAGE_VERSION[[:space:]]*\"${CI_COMMIT_TAG}\"\)$" build/tangoidlConfigVersion.cmake && exit 0

echo "git tag is not matching the version numbers (MAJOR_VERSION.MINOR_VERSION.PATCH_VERSION) in CMakeLists.txt"
exit 1
