require File.dirname(__FILE__) + '/test_helper.rb'

module ActiveRecord
  class RecordNotFound < StandardError; end
end

class TestEasyEnums < Test::Unit::TestCase

  module ActiveRecordMock
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def validates_presence_of(*args); end
      def exists?(args); false; end
      def find(*args); @values; end
      
      def create!(options)
        @values ||= []
        @values << new(options[:name])
      end
    end
    
    attr_reader :name
    def initialize(name)
      @name = name
    end
    
    def ==(other)
      name == other.name
    end
  end
  
  class Enumbed
    include ActiveRecordMock
    include EasyEnumerations
    
    enumerates do |e|
      e.value :name => 'red'
      e.value :name => 'green'
      e.value :name => 'blue'
    end
  end
  
  class Season
    include ActiveRecordMock
    include EasyEnumerations
    
    enumerates do |e|
      e.value :name => 'Spring'
      e.value :name => 'Summer'
      e.value :name => 'Fall'
      e.value :name => 'Winter'
    end
  end
  
  def test_array_access
    assert_equal Enumbed.new('red'), Enumbed[:red]
    assert_equal Enumbed.new('red'), Enumbed['red']
    assert_nil Enumbed[:magenta]
  end

  def test_find_by_name
    assert_equal Enumbed.new('red'), Enumbed.find_by_name(:red)
    assert_equal Enumbed.new('red'), Enumbed.find_by_name('red')
    assert_nil Enumbed.find_by_name(:magenta)
  end

  def test_find_by_name!
    assert_raise(ActiveRecord::RecordNotFound) do
      Enumbed.find_by_name!(:magenta)
    end
  end
  
  def test_count
    assert_equal 3, Enumbed.count
  end
  
  def test_all
    assert_equal ['blue', 'green', 'red'],
      Enumbed.all.map { |e| e.name }.sort
  end
  
  def test_names
    assert_equal ['blue', 'green', 'red'],
      Enumbed.names.sort
  end

  def test_two_enums_do_not_interfere
    assert_equal ["Fall", "Spring", "Summer", "Winter"],
      Season.all.map { |e| e.name }.sort
  end

  def test_reload
    Enumbed.create!(:name => 'pink')
    Enumbed.reload
    assert_equal ['blue', 'green', 'pink', 'red'],
      Enumbed.all.map { |e| e.name }.sort
    assert_equal ['blue', 'green', 'pink', 'red'],
      Enumbed.names.sort
  end

  def test_valid_name_for_valid_name
    assert_nothing_raised do
      Enumbed.valid_name!('red')
    end
  end

  def test_valid_name_for_invalid_name
    assert_raises ArgumentError do
      Enumbed.valid_name!('black')
    end
  end
end
