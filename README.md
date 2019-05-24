# Cuis-Smalltalk-DWM
Tiling dynamic window management in Cuis Smalltalk, very much in the spirit of http://dwm.suckless.org

## Screenshots

Two browsers and a workspace in tiling:
![alt tag](https://raw.githubusercontent.com/len/Cuis-Smalltalk-DWM/master/screenshots/dwm-0.png)

A floating browser with halos on it (windows dont have decorations or controls, but we have halos!):
![alt tag](https://raw.githubusercontent.com/len/Cuis-Smalltalk-DWM/master/screenshots/dwm-1.png)

The pre-debugger. Halos are automatically added to new floating windows, so when the pre-debugger pops up we see the exception description in the title at the bottom of the halo; this compensates for not having window titles:
![alt tag](https://raw.githubusercontent.com/len/Cuis-Smalltalk-DWM/master/screenshots/dwm-2.png)

A browser on fullscreen:
![alt tag](https://raw.githubusercontent.com/len/Cuis-Smalltalk-DWM/master/screenshots/dwm-3.png)

## Installation

Install it as a Cuis package from a file list window. For customization, edit DWMTheme>>initialize WindowManager>>keyStroke:morph.

To activate it you must select the DWMTheme from the world menu or by doing "DWMTheme beCurrent", then close all windows.

In the screenshots I'm using the DejaVu Mono font, that can be installed from the AdditionalFonts/ directory. If you notice some green shadow in text over black background, you can "Preferences disable: #subPixelRenderColorFonts" or use 'DejaVu Mono' that currently doesn't have this problem.

## Keyboard shortcuts

Shotcuts can be customized in WindowManager>>keyStroke:morph:. Here are some default shortcuts:

alt-esc to toggle the focused (floating) window to/from full screen mode

alt-t to toggle the focused window between tiling or floating modes

alt-w to close a window

alt-1 to alt-8 to switch to another page

alt-shift-1 to alt-shift-8 to move the focused window to another page

alt-shift-B to open a browser, W open a workspace, C a changesorter, etc.
