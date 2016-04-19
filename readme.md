## Build Me Up
This is a simple Xcode plugin that keeps track of how long Xcode takes to build your project(s). It accumulates
the total time and displays in the Activity View in the Xcode toolbar.

<img src="https://raw.githubusercontent.com/edwardaux/BuildMeUp/master/screenshot.png"/>

It keeps a different running total for each Xcode project. 

### Where is the data stored?
It is basically stored in the user defaults for Xcode. To list stored values, you can use the following 
command:

	defaults read com.apple.dt.xcode | grep BuildMeUp

If you want to clear the total, you can use the
following command from the terminal:

	defaults delete com.apple.dt.Xcode BuildMeUp_XXXX_total

where `XXXX` is your project name.

### Important Notes
If you have multiple projects open and are flicking between them, things may get a bit confused. BuildMeUp
uses the currently focused Xcode window to determine which project is being built. 

### License
Released under the MIT license.
