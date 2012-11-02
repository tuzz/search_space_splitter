## Search Space Splitter

Splits a search space into n pieces.


## Usage

Splits a search space, represented by an array of ranges, into similarly sized sections.

```ruby
require 'search_splace_splitter'

SearchSpaceSplitter.split([1..2, 1..3])
#=> [[1..1, 1..3], [2..2, 1..3]]

SearchSpaceSplitter.split([1..3, 1..5])
#=> [[1..3, 1..3], [1..3, 4..5]]

SearchSpaceSplitter.split([1..3, 1..4, 1..5])
#=> [[1..3, 1..2, 1..5], [1..3, 3..4, 1..5]]

SearchSpaceSplitter.split([-1..1, 0..0, 2..3])
#=> [[-1..1, 0..0, 2..2], [-1..1, 0..0, 3..3]]

SearchSpaceSplitter.split([1..3, 1..2], :into => 3)
#=> [[1..1, 1..2], [2..2, 1..2], [3..3, 1..2]]

SearchSpaceSplitter.split([1..3, 1..4, 1..5], :into => 6)
#=> [[1..1, 1..2, 1..5],
#    [1..1, 3..4, 1..5],
#    [2..2, 1..2, 1..5],
#    [2..2, 3..4, 1..5],
#    [3..3, 1..2, 1..5],
#    [3..3, 3..4, 1..5]]

SearchSpaceSplitter.split([1..3, 1..4, 1..5], :into => 11)
#=> [[1..3, 1..2, 1..1],
#    [1..3, 3..4, 1..1],
#    [1..3, 1..2, 2..2],
#    [1..3, 3..4, 2..2],
#    [1..3, 1..2, 3..3],
#    [1..3, 3..4, 3..3],
#    [1..3, 1..2, 4..4],
#    [1..3, 3..4, 4..4],
#    [1..1, 1..4, 5..5],
#    [2..2, 1..4, 5..5],
#    [3..3, 1..4, 5..5]]

SearchSpaceSplitter.split([1..2], :into => 999)
#=> [[1..1], [2..2]]
```

## Contribution

Feel free to contribute. No commit is too small.

You should follow me: [@cpatuzzo](https://twitter.com/cpatuzzo)
