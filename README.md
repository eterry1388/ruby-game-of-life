# Ruby Game of Life

[Conway's Game of Life](http://en.wikipedia.org/wiki/Conway's_Game_of_Life) written in Ruby.

## Usage

```ruby
require_relative 'game_of_life'

grid = Grid.new( height: 35, width: 35 )
game = GameOfLife.new( grid )
game.run

```
