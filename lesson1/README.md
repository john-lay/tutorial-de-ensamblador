# Lesson 1 - Hello World

![screenshot of helloworld](https://github.com/john-lay/tutorial-de-ensamblador/raw/master/lesson1/screenshot.png)

# Build

## Prerequisites

Gameboy build pipeline, [RGBDS](https://github.com/rednex/rgbds/releases).

## Building the rom
Clone the repo and open a terminal in the source directory and run the following commands:
* `rgbasm -o helloworld.o helloworld.asm`
* `rgblink -o helloworld.gb helloworld.o`
* `rgbfix -v -p 0 helloworld.gb`
