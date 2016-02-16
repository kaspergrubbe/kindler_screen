# kindler_screen
Ruby project to generate Kindle images and show them on a Kindle.

The `kindle_scripts` directory consists of a series of helper scripts, where the most important one is `kindle_scripts/get_image_loop.sh` that runs on the Kindle and it fetches an image in a loop, and displays it.

## Requirements

pngcrush, `brew install pngcrush`

## Usage

`cd server && bundle && bundle exec ruby generate.rb`
