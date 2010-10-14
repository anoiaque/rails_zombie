require 'help_test'
require 'active_support/inflector'

class TestRailsZombie < Test::Unit::TestCase
  
  def setup
    UsersController.any_instance.stubs(:params).returns({:id => 1, :company_id => 1})
    @user = User.new(:id => 1, :name => "Marie", :age => 30)
    @company = Company.new(:id => 1, :name => "Apple")
    User.stubs(:find_by_id).with(1).returns(@user)
    Company.stubs(:find_by_id).with(1).returns(@company)
  end
  
  def test_rails_zombie_is_waken!
    UsersController.any_instance.expects(:wake_rails_zombie)
    UsersController.new
  end
  
  def test_user_controller_has_user_instance_variable
    controller = UsersController.new
    assert controller.instance_variable_defined?(:@user)
  end
  
  def test_user_instance_variable_is_set_with_result_of_find_with_id
    controller = UsersController.new
    assert_equal @user, controller.instance_variable_get(:@user)
  end
  
  def test_user_instance_variable_is_set_to_nil_and_no_exeption_is_thrown_when_record_not_found
    User.stubs(:find_by_id).raises
    
    assert_nothing_raised do 
      controller = UsersController.new
      assert_equal nil, controller.instance_variable_get(:@user)#hmmm , not defined so nil ..
    end
  end
  
  def test_should_retrieve_nested_instance_variable
    controller = UsersController.new
    
    assert_equal @company, controller.instance_variable_get(:@company)
  end
  
  def test_should_not_raise_and_not_create_nested_instance_variable_if_model_does_not_exist
    UsersController.any_instance.stubs(:params).returns({:id => 1, :company_id => 1, :post_id => 1})
    
    assert_nothing_raised do 
      controller = UsersController.new
      assert_equal @company, controller.instance_variable_get(:@company)
      assert !controller.instance_variable_defined?(:@post)
    end
  end
  
end