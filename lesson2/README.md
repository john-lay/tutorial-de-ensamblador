# Lesson 2 - Hello World Improved

![screenshot of helloworldimproved](https://github.com/john-lay/tutorial-de-ensamblador/raw/master/lesson2/screenshot.png)

# Build

## Prerequisites

Gameboy build pipeline, [RGBDS](https://github.com/rednex/rgbds/releases).

## Building the rom
Clone the repo and open a terminal in the source directory and run the following commands:
* `rgbasm -o helloworldimproved.o helloworldimproved.asm`
* `rgblink -o helloworldimproved.gb helloworldimproved.o`
* `rgbfix -v -p 0 helloworldimproved.gb`
