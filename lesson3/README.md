# Lesson 3 - Hello Sprite

![screenshot of hellosprite](https://github.com/john-lay/tutorial-de-ensamblador/raw/master/lesson3/screenshot.gif)

# Build

## Prerequisites

Gameboy build pipeline, [RGBDS](https://github.com/rednex/rgbds/releases).

## Building the rom
Clone the repo and open a terminal in the source directory and run the following commands:
* `rgbasm -o hellosprite.o hellosprite.asm`
* `rgblink -o hellosprite.gb hellosprite.o`
* `rgbfix -v -p 0 hellosprite.gb`
