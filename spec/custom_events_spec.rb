require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Mootools Custom Events" do

  before :all do
    @browser = Browser.new(:resynchronize => false, :css => false, :log_level => :all, :javascript_exceptions => true)
  end
  
  before :each do
    @browser.goto(HTML_DIR + "/custom_events.html")    
    @link1 = @browser.link(:id, 'link1');
    @link1.should_not be_nil
    
    @link2 = @browser.link(:id, 'link2');
    @link2.should_not be_nil
    
    @link3 = @browser.link(:id, 'link3');
    @link3.should_not be_nil    
  end  
  
  describe "click event with onlick attribute" do
    it "should trigger click event" do
      @link3.click
      @log = @browser.ul(:id, 'log');      
      @log.lis.any? {|li| li.text.include?('click link: link3') }.should be_true      
    end
  end
  
  describe "click event with addEvents" do
    it "should trigger click event" do
      @link1.click
      @log = @browser.ul(:id, 'log');      
      @log.lis.any? {|li| li.text.include?('click link: link1') }.should be_true      
    end
  end  

  after :all do
    @browser.close
  end

end
