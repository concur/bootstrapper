#!/usr/bin/env bash

{ # this ensures the entire script is downloaded #

set -e

cleanup() {
  rm -rf $TMPDIR/$FILE_NAME
}

bootstrapper_install() {
  say "Installing bootstrapper to $PREFIX ..."
  pushd $TMPDIR > /dev/null
  tar xvf "$FILE_NAME" -C "$PREFIX" --strip-components=1 > /dev/null
  if [ $? != 0 ]; then
    err "failed to extract archive"
  fi
  popd > /dev/null
}

bootstrapper_download() {
  say "Downloading bootstrapper ..."
  pushd $TMPDIR > /dev/null
  curl -q -LO --progress-bar https://s3-us-west-2.amazonaws.com/concur-public-resources/bootstrapper/$FILE_NAME
  popd > /dev/null
}

say() {
  echo "bootstrapper-install: $1"
}

err() {
  say "$1" >&2
  exit 1
}

need_cmd() {
  if ! command -v "$1" > /dev/null 2>&1
  then err "need '$1' (command not found)"
  fi
}

assert_cmds() {
  need_cmd pushd
  need_cmd popd
  need_cmd mkdir
  need_cmd curl
  need_cmd tar
}

main() {
  assert_cmds
  bootstrapper_download
  bootstrapper_install
  cleanup

  echo ""
  say "To run bootstrapper: "
  say "    cd $PREFIX"
  say "    ./bin/bootstrapper install-mac 2>&1 | tee bootstrapper.log"
  echo ""
  say "Done!"
  exit 0
}

VERSION="0.1.2"
FILE_NAME="bootstrapper-$VERSION.tar.gz"

if [ -z "$PREFIX" ]; then
  PREFIX="$HOME/.bootstrapper"
fi

if [ ! -d "$PREFIX" ]; then
  mkdir -p "$PREFIX"
fi

if [ -z "$TMPDIR" ]; then
  TMPDIR="$HOME/.tmp"
fi

if [ ! -d "$TMPDIR" ]; then
  mkdir -p "$TMPDIR"
fi

main "$@"

}
