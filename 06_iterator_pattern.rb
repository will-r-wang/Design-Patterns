require 'pry'
class SortedIterator
  attr_accessor :sorted

  def initialize(collection, sorted = false)
    @collection = collection
    @sorted = sorted
  end

  def each(&block)
    return @collection.sort.each(&block) if sorted

    @collection.each(&block)
  end
end

class UniqueIterator
  attr_accessor :unique

  def initialize(collection, unique = false)
    @collection = collection
    @unique = unique
  end

  def each(&block)
    return @collection.uniq.each(&block) if unique

    @collection.each(&block)
  end
end

class NumbersCollection
  attr_accessor :collection

  def initialize(collection = [])
    @collection = collection
  end

  def iterator
    UniqueIterator.new(@collection) # alternatively SortedIterator.new(@collection)
  end

  def unique_iterator
    UniqueIterator.new(@collection, true)
  end

  def sorted_iterator
    SortedIterator.new(@collection, true)
  end

  def add_number(number)
    @collection << number
  end
end

collection = NumbersCollection.new
collection.add_number(3)
collection.add_number(1)
collection.add_number(2)
collection.add_number(2)
collection.add_number(1)

puts "Non-unique entries"
collection.iterator.each { |number| puts number }

puts "\nUnique entries"
collection.unique_iterator.each { |number| puts number }

puts "\nSorted entries"
collection.sorted_iterator.each { |number| puts number }
