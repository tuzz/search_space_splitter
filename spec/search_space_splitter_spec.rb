require 'spec_helper'

describe SearchSpaceSplitter do

  let(:klass) { subject.class }

  it 'does not exception for the base case' do
    expect { klass.split([]) }.to_not raise_error
  end

  it 'returns a nested array for n = 1' do
    klass.split([1..5], :into => 1).should == [
      [1..5]
    ]
  end

  it 'splits a search space in two by default' do
    klass.split([1..4]).should == [
      [1..2],
      [3..4]
    ]

    klass.split([1..2, 1..3]).should == [
      [1..1, 1..3],
      [2..2, 1..3]
    ]

    klass.split([1..3, 1..3]).should == [
      [1..2, 1..3],
      [3..3, 1..3]
    ]

    klass.split([1..6, 1..2]).should == [
      [1..3, 1..2],
      [4..6, 1..2]
    ]

    klass.split([1..3, 1..5]).should == [
      [1..3, 1..3],
      [1..3, 4..5]
    ]

    klass.split([1..3, 1..4, 1..5]).should == [
      [1..3, 1..2, 1..5],
      [1..3, 3..4, 1..5]
    ]

    klass.split([1..1, 1..2, 1..4]).should == [
      [1..1, 1..1, 1..4],
      [1..1, 2..2, 1..4]
    ]

    klass.split([1..3, 1..5, 1..7]).should == [
      [1..3, 1..5, 1..4],
      [1..3, 1..5, 5..7]
    ]

    klass.split([-1..1, 0..0, 2..3]).should == [
      [-1..1, 0..0, 2..2],
      [-1..1, 0..0, 3..3]
    ]

    klass.split([2..4, -1..0, 1..2]).should == [
      [2..4, -1..-1, 1..2],
      [2..4, 0..0, 1..2]
    ]

    klass.split([-3..-1, 0..2, -1..2, 1..2]).should == [
      [-3..-1, 0..2, -1..0, 1..2],
      [-3..-1, 0..2, 1..2, 1..2]
    ]
  end

  it 'splits a search space into the given optional argument' do
    klass.split([1..3], :into => 3).should == [
      [1..1],
      [2..2],
      [3..3]
    ]

    klass.split([1..3, 1..2], :into => 3).should == [
      [1..1, 1..2],
      [2..2, 1..2],
      [3..3, 1..2]
    ]

    klass.split([1..2, 1..3], :into => 3).should == [
      [1..2, 1..1],
      [1..2, 2..2],
      [1..2, 3..3]
    ]

    klass.split([1..6, 1..3], :into => 3).should == [
      [1..2, 1..3],
      [3..4, 1..3],
      [5..6, 1..3]
    ]

    klass.split([1..12, 1..3, 1..5], :into => 3).should == [
      [1..4, 1..3, 1..5],
      [5..8, 1..3, 1..5],
      [9..12, 1..3, 1..5]
    ]

    klass.split([1..12, 1..3, 1..5], :into => 4).should == [
      [1..3, 1..3, 1..5],
      [4..6, 1..3, 1..5],
      [7..9, 1..3, 1..5],
      [10..12, 1..3, 1..5]
    ]

    klass.split([1..12, 1..3, 1..5], :into => 5).should == [
      [1..12, 1..3, 1..1],
      [1..12, 1..3, 2..2],
      [1..12, 1..3, 3..3],
      [1..12, 1..3, 4..4],
      [1..12, 1..3, 5..5]
    ]
  end

  it 'splits non-trivial ranges as evenly as possible' do
    klass.split([1..3, 1..4, 1..5], :into => 6).should == [
      [1..1, 1..2, 1..5],
      [1..1, 3..4, 1..5],
      [2..2, 1..2, 1..5],
      [2..2, 3..4, 1..5],
      [3..3, 1..2, 1..5],
      [3..3, 3..4, 1..5]
    ]

    klass.split([1..3, 1..4, 1..5], :into => 7).should == [
      [1..3, 1..4, 1..1],
      [1..3, 1..4, 2..2],
      [1..3, 1..4, 3..3],
      [1..3, 1..2, 4..4],
      [1..3, 3..4, 4..4],
      [1..3, 1..2, 5..5],
      [1..3, 3..4, 5..5]
    ]

    klass.split([1..3, 1..4, 1..5], :into => 11).should == [
      [1..3, 1..2, 1..1],
      [1..3, 3..4, 1..1],
      [1..3, 1..2, 2..2],
      [1..3, 3..4, 2..2],
      [1..3, 1..2, 3..3],
      [1..3, 3..4, 3..3],
      [1..3, 1..2, 4..4],
      [1..3, 3..4, 4..4],
      [1..1, 1..4, 5..5],
      [2..2, 1..4, 5..5],
      [3..3, 1..4, 5..5]
    ]

    klass.split([1..2, 1..2, 1..2], :into => 7).should == [
      [1..1, 1..1, 1..2],
      [1..1, 2..2, 1..1],
      [1..1, 2..2, 2..2],
      [2..2, 1..1, 1..1],
      [2..2, 1..1, 2..2],
      [2..2, 2..2, 1..1],
      [2..2, 2..2, 2..2]
    ]
  end

  it 'can return fewer elements than the given argument' do
    klass.split([1..1, 1..2, 1..2], :into => 5).should == [
      [1..1, 1..1, 1..1],
      [1..1, 1..1, 2..2],
      [1..1, 2..2, 1..1],
      [1..1, 2..2, 2..2]
    ]
  end

  it 'totals the size of the search space' do
    search = [1..3, 1..5, 1..7, -4..11, 21..29, -11..-2]
    splits = klass.split(search, :into => 23)

    size = lambda { |r| r.map(&:count).inject(:*) }

    search_size = size[search]
    splits_size = splits.map(&size).inject(:+)

    search_size.should == splits_size
  end

end
