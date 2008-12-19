require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Button" do

  before :all do
    @browser = Browser.new
  end

  before :each do
    @browser.goto(TEST_HOST + "/forms_with_input_elements.html")
  end

  # Exists method
  describe "#exists?" do
    it "should return true if the button exists" do
      @browser.button(:id, "new_user_submit").should exist
      @browser.button(:id, /new_user_submit/).should exist
      @browser.button(:name, "new_user_reset").should exist
      @browser.button(:name, /new_user_reset/).should exist
      @browser.button(:value, "Button 2").should exist
      @browser.button(:value, /Button 2/).should exist
      @browser.button(:src, "images/button.jpg").should exist
      @browser.button(:src, /button.jpg/).should exist
      @browser.button(:text, "Button 2").should exist
      @browser.button(:text, /Button 2/).should exist
      @browser.button(:class, "image").should exist
      @browser.button(:class, /image/).should exist
      @browser.button(:index, 1).should exist
      @browser.button(:xpath, "//input[@id='new_user_submit']").should exist
    end

    it "should return true if the button exists (how = :caption)" do
      @browser.button(:caption, "Button 2").should exist
      @browser.button(:caption, /Button 2/).should exist
    end

    it "should return true if the button exists (default how = :value)" do
      @browser.button("Submit").should exist
    end

    it "should return false if the button doesn't exist" do
      @browser.button(:id, "no_such_id").should_not exist
      @browser.button(:id, /no_such_id/).should_not exist
      @browser.button(:name, "no_such_name").should_not exist
      @browser.button(:name, /no_such_name/).should_not exist
      @browser.button(:value, "no_such_value").should_not exist
      @browser.button(:value, /no_such_value/).should_not exist
      @browser.button(:src, "no_such_src").should_not exist
      @browser.button(:src, /no_such_src/).should_not exist
      @browser.button(:text, "no_such_text").should_not exist
      @browser.button(:text, /no_such_text/).should_not exist
      @browser.button(:class, "no_such_class").should_not exist
      @browser.button(:class, /no_such_class/).should_not exist
      @browser.button(:index, 1337).should_not exist
      @browser.button(:xpath, "//input[@id='no_such_id']").should_not exist
    end

    it "should raise TypeError when 'what' argument is invalid" do
      lambda { @browser.button(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "should raise MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { @browser.button(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods
  describe "#class_name" do
    it "should return the class name of the button" do
      @browser.button(:name, "new_user_image").class_name.should == "image"
    end

    it "should return an empty string if the button has no class name" do
      @browser.button(:name, "new_user_submit").class_name.should == ""
    end
  end

  describe "#id" do
    it "should return the id if the button exists" do
      @browser.button(:index, 1).id.should == 'new_user_submit'
      @browser.button(:index, 2).id.should == 'new_user_reset'
      @browser.button(:index, 3).id.should == 'new_user_button'
    end

    it "should raise UnknownObjectException if button does not exist" do
      lambda { @browser.button(:index, 1337).id }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :index and 1337')
    end
  end

  describe "#name" do
    it "should return the name if button exists" do
      @browser.button(:index, 1).name.should == 'new_user_submit'
      @browser.button(:index, 2).name.should == 'new_user_reset'
      @browser.button(:index, 3).name.should == 'new_user_button'
    end

    it "should raise UnknownObjectException if the button does not exist" do
      lambda { @browser.button(:name, "no_such_name").name }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :name and "no_such_name"')
    end
  end

  describe "#src" do
    it "should return the url for the button image" do
      @browser.button(:name, "new_user_image").src.should == "images/button.jpg"
    end

    it "should raise UnknownObjectException if the button does not exist" do
      lambda { @browser.button(:name, "no_such_name").src }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :name and "no_such_name"')
    end
  end

  describe "#style" do
    it "should return the style attribute if the button exists" do
      @browser.button(:id, 'delete_user_submit').style.should == "border: 4px solid red;"
    end

    it "should return an empty string if the element exists and the attribute doesn't" do
      @browser.button(:id, 'new_user_submit').style.should == ""
    end

    it "should raise UnknownObjectException if the button does not exist" do
      lambda { @browser.button(:name, "no_such_name").style }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :name and "no_such_name"')
    end
  end

  describe "#title" do
    it "should return the title of the button" do
      @browser.button(:index, 1).title.should == 'Submit the form'
    end

    it "should return an empty string for button without title" do
      @browser.button(:index, 2).title.should == ''
    end
  end

  describe "#type" do
    it "should return the type if button exists" do
      @browser.button(:index, 1).type.should == 'submit'
      @browser.button(:index, 2).type.should == 'reset'
      @browser.button(:index, 3).type.should == 'button'
    end

    it "should raise UnknownObjectException if button does not exist" do
      lambda { @browser.button(:name, "no_such_name").type }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :name and "no_such_name"')
    end
  end

  describe "#value" do
    it "should return the value if button exists" do
      @browser.button(:index, 1).value.should == 'Submit'
      @browser.button(:index, 2).value.should == 'Reset'
      @browser.button(:index, 3).value.should == 'Button'
    end

    it "should raise UnknownObjectException if button does not exist" do
      lambda { @browser.button(:name, "no_such_name").value }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :name and "no_such_name"')
    end
  end

  describe "#respond_to?" do
    it "should return true for all attribute methods" do
      @browser.button(:index, 1).should respond_to(:class_name)
      @browser.button(:index, 1).should respond_to(:id)
      @browser.button(:index, 1).should respond_to(:name)
      @browser.button(:index, 1).should respond_to(:src)
      @browser.button(:index, 1).should respond_to(:style)
      @browser.button(:index, 1).should respond_to(:title)
      @browser.button(:index, 1).should respond_to(:type)
      @browser.button(:index, 1).should respond_to(:value)
    end
  end

  # Access methods
  describe "#enabled?" do
    it "should return true if the button is enabled" do
      @browser.button(:name, 'new_user_submit').should be_enabled
    end

    it "should return false if the button is disabled" do
      @browser.button(:name, 'new_user_submit_disabled').should_not be_enabled
    end

    it "should raise UnknownObjectException if the button doesn't exist" do
      lambda { @browser.button(:name, "no_such_name").enabled? }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :name and "no_such_name"')
    end
  end

  describe "#disabled?" do
    it "should return false when button is enabled" do
      @browser.button(:name, 'new_user_submit').should_not be_disabled
    end

    it "should return true when button is disabled" do
      @browser.button(:name, 'new_user_submit_disabled').should be_disabled
    end

    it "should raise UnknownObjectException if button does not exist" do
      lambda { @browser.button(:name, "no_such_name").disabled? }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :name and "no_such_name"')
    end
  end

  # Celerity API
  describe "#click_and_attach" do
    it "should return a new browser instance with the popup page" do
      b = @browser.button(:name, 'new_popup_window').click_and_attach
      b.should_not == @browser
      b.title.should == "Tables"
      @browser.title.should == "Forms with input elements"
    end
  end

  # Manipulation methods
  describe "#click" do
    it "should click the button if it exists" do
      @browser.button(:id, 'new_user_submit').click
      @browser.text.should include("You posted the following content:")
    end

    it "should fire events" do
      @browser.button(:id, 'new_user_button').click
      @browser.button(:id, 'new_user_button').value.should == 'new_value_set_by_onclick_event'
    end

    it "should raise UnknownObjectException when clicking a button that doesn't exist" do
      lambda { @browser.button(:value, "no_such_value").click }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :value and "no_such_value"')
      lambda { @browser.button(:id, "no_such_id").click }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :id and "no_such_id"')
    end

    it "should raise ObjectDisabledException when clicking a disabled button" do
      lambda { @browser.button(:value, "Disabled").click }.should raise_error(ObjectDisabledException)
    end
  end

  after :all do
    @browser.close
  end
end