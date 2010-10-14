class Zombie
  
  def initialize controller
    @controller = controller
  end
  
  def set_resource_instance_variable
    set_inner_instance_variable(@controller.class.name.gsub("Controller","").chop, @controller.params[:id])
  end
  
  def set_nested_resources_instance_variables
    nested_models.each do |klass_name, id|
      set_inner_instance_variable(klass_name, id)
    end
  end
  
  def set_inner_instance_variable model_klass_name, id
    begin
      klass = model_klass_name.constantize
    end
    instance_variable_name = model_klass_name.underscore
    instance_variable_value = klass.find_by_id(id)
    @controller.instance_variable_set("@#{instance_variable_name}", instance_variable_value)
    rescue
      #model not found
  end
  
  private
  
  #TODO : get nested model from routes
  def nested_models
    @controller.params.map {|key, value| [key.to_s.gsub('_id','').camelize, value] if key.to_s =~ /_id$/}.compact
  end
  
end

module RailsZombie
  def self.included(application) 
    application.send(:before_filter, :wake_rails_zombie)

    def wake_rails_zombie
      zombie = Zombie.new(self)
      zombie.set_resource_instance_variable
      zombie.set_nested_resources_instance_variables
    end
  end
end
