class User
  attr_accessor :id, :name, :age
  
  def initialize args={}
    @id = args[:id]
    @name = args[:name]
    @age = args[:age]
  end
end