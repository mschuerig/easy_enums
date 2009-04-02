
module EasyEnumerations
  VERSION = '0.0.1'
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def enumerates
      extend SingletonMethods
      validates_presence_of :name
      creator = EnumerationCreator.new(self)
      yield creator
      @enum_cache = creator.cache
    end
  end
  
  module SingletonMethods
    def all
      @enum_cache.values
    end
    
    def count(*args)
      if args.empty?
        @enum_cache.size
      else
        super
      end
    end
    
    def reload
      @enum_cache.reload
    end
    
    def find_by_name(name)
      @enum_cache[name]
    end
    alias :[] :find_by_name
    
    def find_by_name!(name)
      find_by_name(name) or
        raise ::ActiveRecord::RecordNotFound, "Couldn't find #{self.name} with name = #{name}"
    end
    
    def each_name
      all.each do |role_type|
        yield role_type.name
      end
    end
  end 
  
  class EnumerationCreator
    def initialize(model)
      @model = model
    end
    
    def create(options)
      unless @model.exists?(:name => options[:name])
        @model.create!(options)
      end
    end
    
    def cache
      Cache.new(@model)
    end
    
    private

    class Cache
      def initialize(model)
        @model = model
        reload
      end
    
      def reload
        @cache = @model.find(:all).inject({}) do |c, e|
          c[e.name] = e
          c
        end
      end
      
      def values
        @values ||= @cache.values
      end
      
      def [](name)
        @cache[name.to_s]
      end
      
      def size
        values.size
      end
    end
  end
end
