#!/usr/bin/env zsh

if [ $# != 2 ] || [ $1 -gt 65535 ] || [ $1 -lt 1 ] || [ ! -d $2 ]; then
    print 'this is not how you use this program.'
    print 'usage: receiver.sh <port> <destination directory>\n'
    exit 1
fi

if ! command -v nc &>/dev/null; then
    print 'you need netcat to run this trash\n'
    exit 1
fi

print 'listening for command at port' $1
COMMAND=`nc -l $1`

print "receiving `print $COMMAND | wc -l` files.."

for i in {1..`print $COMMAND | wc -l`}; do
    FILENAME=`sed -n "$i{p;q}"<<<$COMMAND`
    print 'preparing port' $[$1 + $i] 'for recv of' $FILENAME '...'
    nc -l $[$1 + $i] > $2/$FILENAME 2>/dev/null &
done

print 'waiting to receive all files..'
wait
print 'received all files (hopefully)'

