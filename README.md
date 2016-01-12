# Ruby Game of Life

[Conway's Game of Life](http://en.wikipedia.org/wiki/Conway's_Game_of_Life) written in Ruby.

The Game of Life, also known simply as Life, is a cellular automaton devised by the British mathematician John Horton Conway in 1970. The "game" is a zero-player game, meaning that its evolution is determined by its initial state, requiring no further input. One interacts with the Game of Life by creating an initial configuration and observing how it evolves or, for advanced players, by creating patterns with particular properties.

## Usage

```ruby
require_relative 'game_of_life'

grid = Grid.new( height: 35, width: 35 )
game = GameOfLife.new( grid )
game.run

```
