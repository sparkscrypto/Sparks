
Debian
====================
This directory contains files used to package Sparksd/Sparks-qt
for Debian-based Linux systems. If you compile Sparksd/Sparks-qt yourself, there are some useful files here.

## Sparks: URI support ##


Sparks-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install Sparks-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your Sparks-qt binary to `/usr/bin`
and the `../../share/pixmaps/Sparks128.png` to `/usr/share/pixmaps`

Sparks-qt.protocol (KDE)

