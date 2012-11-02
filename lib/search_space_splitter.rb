require 'rational'
require 'range_splitter'

class SearchSpaceSplitter
  def self.split(ranges, params = {})
    into = params[:into] || 2

    atomic = ranges.all? { |r| r.count == 1 }
    return ranges if into == 1 || atomic

    ri = ranges.each_with_index
    divisible = lambda { |c| (into % c).zero? || (c % into).zero? }

    range, index = ri.detect { |r, i| r.count != 1 && divisible[r.count] }
    range, index = ri.max_by { |r, i| r.count } unless index

    splits = range.split(:into => into).map do |r|
      dup = ranges.dup
      dup[index] = r
      dup
    end

    current = splits.size
    div, mod = into.divmod(current)

    splits.each_with_index.map do |r, i|
      into = div + (i < (current - mod) ? 0 : 1)
      p = params.merge(:into => into)

      split(r, p)
    end.flatten.each_slice(ranges.size).to_a
  end
end
