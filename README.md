# kindler_screen
Ruby project to generate Kindle images and show them on a Kindle.

The `kindle` directory consists of a series of helper scripts, where the most important one is `kindle/get_image_loop.sh` that fetches an image in a loop, and displays it.

The `server` directory is the Ruby project that generates the picture.

## Requirements

pngcrush, `brew install pngcrush`

## Usage

`cd server && bundle && bundle exec ruby generate.rb`
