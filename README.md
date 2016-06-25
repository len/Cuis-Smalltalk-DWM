# Cuis-Smalltalk-DWM
Tiling dynamic window management in Cuis, very much in the spirit of http://dwm.suckless.org

Still very experimental, will change in the future as I go along using it. 

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

To activate it you must select the DWMTheme. From the world menu: Preferences -> Themes -> DWMTheme. Then close all windows, and if you want you can change the world color to black by getting the halos on the world, inspecting it (from the debug halo) and doing "self color: Color black". In the screenshots I'm using the DejaVu Mono font, that can
be installed from the AdditionalFonts/ directory. For customization, edit WindowManager>>keyStroke:morph and DWMTheme>>initialize.

## Keyabord shortcuts

Shotcuts can be customized in WindowManager>>keyStroke:morph:. Here are some default shortcuts:

alt-esc to toggle the focused (floating) window to/from full screen mode

alt-t to toggle the focused window between tiling or floating modes

alt-w to close a window

alt-1 to alt-8 to switch to another page

alt-shift-1 to alt-shift-8 to move the focused window to another page

alt-shift-B to open a browser, W open a workspace, C a changesorter, etc.
