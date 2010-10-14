class Company
  attr_accessor :id, :name
  
  def initialize args={}
    @id = args[:id]
    @name = args[:name]
  end
end