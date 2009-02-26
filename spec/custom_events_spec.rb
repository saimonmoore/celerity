require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Mootools Custom Events" do

  before :all do
    @browser = Browser.new(:browser => :firefox, :resynchronize => false, :css => false, :log_level => :off, :javascript_exceptions => true)
  end
  
  before :each do
    @browser.goto(HTML_DIR + "/custom_events.html")
    @browser.wait
    @link1 = @browser.link(:id, 'link1');
    @link1.should_not be_nil
    
    @link2 = @browser.link(:id, 'link2');
    @link2.should_not be_nil
    
    @link3 = @browser.link(:id, 'link3');
    @link3.should_not be_nil
    
    @link4 = @browser.link(:id, 'link4');
    @link4.should_not be_nil
    
    @link5 = @browser.link(:id, 'link5');
    @link5.should_not be_nil    
    
    @link6 = @browser.link(:id, 'link6');
    @link6.should_not be_nil    
  end  
  
  describe "on dom loaded event" do
    it "should be logged" do
      @log = @browser.ul(:id, 'log');      
      @log.lis.any? {|li| li.text.include?('inited') }.should be_true      
    end
  end  
  
  describe "click event with onlick attribute" do
    it "should trigger click event" do
      @link3.click
      @log = @browser.ul(:id, 'log');      
      @log.lis.any? {|li| li.text.include?('click link: link3') }.should be_true      
    end
  end
  
  describe "click event with addEvent via delegation" do
    it "should trigger click event" do
      @link5.click
      @log = @browser.ul(:id, 'log');      
      @log.lis.any? {|li| li.text.include?('click link: link5') }.should be_true      
    end
  end  

  describe "click event with addEvent" do
    it "should trigger click event" do
      @link4.click
      @log = @browser.ul(:id, 'log');      
      @log.lis.any? {|li| li.text.include?('click link: link4') }.should be_true      
    end
  end
    
  describe "click event with addEvents" do
    it "should trigger click event" do
      @link1.click
      @log = @browser.ul(:id, 'log');      
      @log.lis.any? {|li| li.text.include?('click link: link1') }.should be_true      
    end
    
    it "should trigger click once event (via addEvents)" do
      @link1.click
      @log = @browser.ul(:id, 'log');      
      @log.lis.any? {|li| li.text.include?('click link: link1') }.should be_true
      @log.lis.any? {|li| li.text.include?('click once link: link1') }.should be_true
    end
    
    it "should trigger click twice event (via addEvents)" do
      @link1.double_click
      @log = @browser.ul(:id, 'log');      
      @log.lis.any? {|li| li.text.include?('dblclick link: link1') }.should be_true
      @log.lis.any? {|li| li.text.include?('click twice link: link1') }.should be_true
    end    
    
    it "should trigger dblclick event (via addEvents)" do
      @link1.double_click
      @log = @browser.ul(:id, 'log');      
      @log.lis.any? {|li| li.text.include?('dblclick link: link1') }.should be_true
    end
    
    it "should trigger click event on dblclick event (via addEvents)" do
      @link1.double_click
      @log = @browser.ul(:id, 'log');      
      @log.lis.any? {|li| li.text.include?('click link: link1') }.should be_true
    end    
    
    it "should trigger dblclick event (via addEvent)" do
      @link4.double_click
      @log = @browser.ul(:id, 'log');      
      @log.lis.any? {|li| li.text.include?('dblclick link: link4') }.should be_true
    end
    
    it "should trigger dblclick event (via addEvent with delegation)" do
      @link5.double_click
      @log = @browser.ul(:id, 'log');      
      @log.lis.any? {|li| li.text.include?('dblclick link: link5') }.should be_true
    end    
  end

  after :all do
    @browser.close
  end

end
