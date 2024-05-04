#!/usr/bin/env zsh

if [ $# -lt 3 ]; then
    print 'this is not how you use this program.'
    print 'usage: sender.sh <host> <port> <files..>\n'
    exit 1
fi

if ! command -v pv &>/dev/null; then
    print 'you "need" pv to run this trash\n'
    exit 1
fi

{for i in ${@:3}; do basename $i; done} | nc -q0 $1 $2
sleep 1

print 'sending all files in parallel'
for i in {1..$[$# - 2]}; do pv -petrc $@[2+i] | nc -q0 $1 $[$2 + i] & done
wait
print 'sent all files..'
