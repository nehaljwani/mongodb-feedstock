#!/bin/bash
set -x

# https://jira.mongodb.org/browse/SERVER-30893
if [[ $target_platform == linux-aarch64 ]]; then
   export CFLAGS="${CFLAGS:-} -march=armv8-a+crc"
fi

declare -a _scons_xtra_flags
_scons_xtra_flags+=(--dbg=off)
_scons_xtra_flags+=(--disable-warnings-as-errors)
_scons_xtra_flags+=(--enable-free-mon=on)
_scons_xtra_flags+=(--enable-http-client=on)
_scons_xtra_flags+=(--opt=on)
_scons_xtra_flags+=(--release)
_scons_xtra_flags+=(--server-js=on)
_scons_xtra_flags+=(--ssl=on)
_scons_xtra_flags+=(--wiredtiger=on)
_scons_xtra_flags+=(CC="$CC" CXX="$CXX" OBJCOPY="$OBJCOPY")
_scons_xtra_flags+=(CCFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" LINKFLAGS="$LDFLAGS")
_scons_xtra_flags+=(CPPDEFINES="BOOST_LOG_DYN_LINK")
_scons_xtra_flags+=(HOST_ARCH="$HOST")
_scons_xtra_flags+=(RPATH="$PREFIX/lib")
_scons_xtra_flags+=(VERBOSE=on)
_scons_xtra_flags+=(DESTDIR="$PREFIX")
_scons_xtra_flags+=(--use-system-{boost,icu,pcre,snappy,yaml,zlib,zstd,abseil-cpp})

$PYTHON buildscripts/scons.py install-core "${_scons_xtra_flags[@]}"
