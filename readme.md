## Build Me Up
This is a simple Xcode plugin that keeps track of how long Xcode takes to build your project(s). It accumulates the total time and displays in the Activity View in the Xcode toolbar.

<img src="https://raw.githubusercontent.com/edwardaux/BuildMeUp/master/screenshot.png"/>

It keeps a different running total for each Xcode project. 

### Where is the data stored?
It is basically stored in the user defaults for Xcode. To list stored values, you can use the following command:

	defaults read com.apple.dt.xcode | grep BuildMeUp

If you want to clear the total, you can use the following command from the terminal:

	defaults delete com.apple.dt.Xcode BuildMeUp_XXXX_total

where `XXXX` is your project name.

### Customising the output
BuildMeUp can output the total build time using either of the following patterns:

* Number of seconds. eg. `4567.89 secs`
* Pretty format. eg. `1h 16m 7s`

You can switch between these by running one of the following commands:

	defaults write com.apple.dt.xcode BuildMeUp_XXXX_displayInSeconds YES
	defaults write com.apple.dt.xcode BuildMeUp_XXXX_displayInSeconds NO

where `XXXX` is your project name.

### Some Notes
If you have multiple projects open and are flicking between them, things may get a bit confused. BuildMeUp uses the currently focused Xcode window to determine which project is being built. 

When you run your project using `⌘R`, the build time for that run *does* get included in the tally. However, Xcode overrides the activity text to say *Finished running XXXX*. To see the cumulative build time again, just get Xcode to re-build again using `⌘B`.

### License
Released under the MIT license.
