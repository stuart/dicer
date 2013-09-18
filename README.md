# Dice

A parser for Dice notation

## Installation

Add this line to your application's Gemfile:

    gem 'dice'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dice

## Usage

The supported dice notation:

* NdX - Roll N dice with X sides and add the result. e.g. 3d6, 4d10, 1d100.
* dX  - Roll one die with X sides.
* d%  - Roll one percentile (100 sided) die.
* hY  - Keep the highest Y rolls. e.g. 4d6h3 would give a roll in the range 3..18
* kY  - A synonym for h (keep).
* lZ  - Keep the lowest Z rolls. e.g. 2d6l1 would take the lowest one of two dice.

Basic arithmetic is also supported:
integers, floats, +, -, *, / and () are all allowed.

Examples:
```
  Dice.roll('3d6+6')
  Dice.roll('2d100/2')
  Dice.roll('4d6 - 3d4')
  Dice.roll('100/4d6h3')

```

Currently the gem just uses Random.rand for it's random number generation.
Other random number generators could easily be added by overriding the Dice.rng method.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
