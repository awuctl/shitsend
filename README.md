# fckngsht

I sincerely cannot believe I had to write this..

This piece of garbage is a `zsh` script allows you to send files over the network in parallel with OpenBSD netcat `nc` in the most braindead way possible.

This trash will not create directories, preserve permissions or do anything beyond sending the flat list of files to a directory.

Permissions/Directories/Extended attributes/[...] are not preserved - if you want directories and permissions just `tar` your stuff before sending.

# Usage

## Receiver:
```sh
receive.sh <port> <destination directory>
```

This starts to listen on port `<port>` for a connection with a newline-separated list of `n` filenames to process. It proceeds to open the next `n` ports after the first one, waiting for an incoming connection on each to receive the corresponding file.

## Sender

```sh
send.sh <receiver host/IP> <receiver port> <files..>
```

This sends the list of **basenames** to the server and sends files over the appropriate ports, in order. Progress monitoring via `pv`.

The idea is that the "protocol" is so simple that you can play the sender by hand with no effort.

# Motivation

There is not a single non-insane unsafe way to send files over a local network. I have no idea why and I should not have to wonder why.

Some things I've considered:

 - `SFTP` (OpenSSH) - slow as shit, needs SSH set up
 - `FTP` (ProFTPd) - pain to set up; shits up your system; breaks permissions
 - `TFTP` (atftpd), ancient software
 - `SMB/CIFS`, are you insane?
 - `NFS`, see above

# Questions

The questions are not real - alas, they have been revealed to me in a dream - someone would have asked them had I not already given the answers here. You're welcome.

> Why not put `[shit ftp/[...] server]` in a container?

Because I should not need root rights (or set up rootless containers) to share **two. local. fucking. files** I fucking **own** over my **local** fucking network.

> Why not just tar/7z your entire transfer netcat it?

"Normal" archive formats feel weird on Linux and tars are cumbersome, slow and painful to interact with.. I avoid them like the plague unless I need to preserve permissions/attributes/[...].

Besides I need multiple connections and simultaneous transfer for the slight *illusion* of extra speed..

> Why not set up ownCloud/Nextcloud or send it encrypted over some cloud provider?

You people are fucking insane.

> Why not use a pendrive?

I have a local network.

> Why write it in the shell of all things?

netcat funny. bash tcp version otw..
