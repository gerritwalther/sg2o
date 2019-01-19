#!/bin/bash

# Script to bump version by major, minor or patch version.

usage () {
cat <<EOF
Usage: $0 [option]

Bumps the version in the meta data of the script files.

Add one of the following options:
-h | --help
-n | --minor
-m | --major
-p | --patch
EOF
  exit 1
}

bump_major () {
  echo "Bumping major version."
  NEW_MAJOR=$(($OLD_MAJOR+1))
  NEW_VERSION=$NEW_MAJOR.0.0
}

bump_minor () {
  echo "Bumping minor version."
  NEW_MINOR=$((OLD_MINOR+1))
  NEW_VERSION=$OLD_MAJOR.$NEW_MINOR.0
}

bump_patch () {
  echo "Bumping patch version."
  NEW_PATCH=$((OLD_PATCH+1))
  NEW_VERSION=$OLD_MAJOR.$OLD_MINOR.$NEW_PATCH
}

write_new_version () {
  echo "... manifest.json"
  sed -i s/\"$OLD_VERSION\"/\"$NEW_VERSION\"/ manifest.json
  echo "... VERSION"
  sed -i s/$OLD_VERSION/$NEW_VERSION/ VERSION
  echo "... pubspec.yaml"
  sed -i s/version\:\ $OLD_VERSION/version\:\ $NEW_VERSION/ pubspec.yaml
  echo "... sg2o.meta.js"
  sed -ri s,\(//\ @version[\ ]*\)$OLD_VERSION,\\1$NEW_VERSION, sg2o.meta.js
  echo "... sg2o.meta.js"
  sed -ri s,\(//\ @version[\ ]*\)$OLD_VERSION,\\1$NEW_VERSION, sg2o-install.meta.js
  echo "... sg2o.meta.js"
  sed -ri s,\(//\ @version[\ ]*\)$OLD_VERSION,\\1$NEW_VERSION, sg2o-install.user.js
}

OLD_VERSION=`grep -oP '\d+.\d+.\d+' VERSION`
OLD_MAJOR=`echo $OLD_VERSION | sed 's/\([0-9]\+\).[0-9]\+.[0-9]\+/\1/'`
OLD_MINOR=`echo $OLD_VERSION | sed 's/[0-9]\+.\([0-9]\+\).[0-9]\+/\1/'`
OLD_PATCH=`echo $OLD_VERSION | sed 's/[0-9]\+.[0-9]\+.\([0-9]\+\)/\1/'`

echo Old version is $OLD_VERSION

# Got this from http://stackoverflow.com/a/7948533/1004795
TEMP=`getopt -o hmnp --long help,minor,major,patch \
             -n 'bumpVersion.sh' -- "$@"`

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

# Stop here, if no arguments were passed
if [ -z $1 ] ; then usage; fi

# Note the quotes around `$TEMP': they are essential!
eval set -- "$TEMP"

case "$1" in
  -h | --help       ) usage ;;
  -n | --minor      ) bump_minor; shift ;;
  -m | --major      ) bump_major; shift ;;
  -p | --patch      ) bump_patch; shift ;;
  -- ) shift; break ;;
  *  ) break ;;
esac

echo Writing new version $NEW_VERSION to...

write_new_version

exit 0
