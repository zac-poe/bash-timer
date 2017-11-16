## Overview
The purpose of these scripts is to provide simple command line utilities for timers.

## Timer Usage
The *timer.sh* script has the following options:
* -s seconds: seconds to add to countdown
* -m minutes: minutes to add to countdown
* -h hours: hours to add to countdown
* -q: run in quiet mode with no output
* -f: visually flash terminal upon completion

```timer.sh -s 30````
Runs a visual countdown timer for 30 seconds

```timer.sh -m 1 -q -f```
Runs a timer for 1 minute with no output, but flashes terminal upon completion

