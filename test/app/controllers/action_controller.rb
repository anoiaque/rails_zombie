module ActionController
  class Base
    
    def initialize
      send(@@method)
    end
  
    def self.before_filter method
      @@method = method
    end
  end
  
end