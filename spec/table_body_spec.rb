require File.dirname(__FILE__) + '/spec_helper.rb'

describe "TableBody" do

  before :all do
    @browser = Browser.new(:log_level => LOG_LEVEL)
  end

  before :each do
    @browser = Browser.new(:log_level => LOG_LEVEL)
    @browser.goto(HTML_DIR + "/tables.html")
  end

  describe "#exists" do
    it "returns true if the table body exists (page context)" do
      @browser.body(:id, 'first').should exist
      @browser.body(:id, /first/).should exist
      @browser.body(:name, 'second').should exist
      @browser.body(:name, /second/).should exist
      @browser.body(:index, 1).should exist
      @browser.body(:xpath, "//tbody[@id='first']").should exist
    end

    it "returns true if the table body exists (table context)" do
      @browser.table(:index, 1).body(:id, 'first').should exist
      @browser.table(:index, 1).body(:id, /first/).should exist
      @browser.table(:index, 1).body(:name, 'second').should exist
      @browser.table(:index, 1).body(:name, /second/).should exist
      @browser.table(:index, 1).body(:index, 1).should exist
      @browser.table(:index, 1).body(:xpath, "//tbody[@id='first']").should exist
    end

    it "returns true if the element exists (default how = :id)" do
      @browser.body("first").should exist
      @browser.table(:index, 1).body("first").should exist
    end

    it "returns false if the table body exists (page context)" do
      @browser.body(:id, 'no_such_id').should_not exist
      @browser.body(:id, /no_such_id/).should_not exist
      @browser.body(:name, 'no_such_name').should_not exist
      @browser.body(:name, /no_such_name/).should_not exist
      @browser.body(:index, 1337).should_not exist
      @browser.body(:xpath, "//tbody[@id='no_such_id']").should_not exist
    end

    it "returns false if the table body exists (table context)" do
      @browser.table(:index, 1).body(:id, 'no_such_id').should_not exist
      @browser.table(:index, 1).body(:id, /no_such_id/).should_not exist
      @browser.table(:index, 1).body(:name, 'no_such_name').should_not exist
      @browser.table(:index, 1).body(:name, /no_such_name/).should_not exist
      @browser.table(:index, 1).body(:index, 1337).should_not exist
      @browser.table(:index, 1).body(:xpath, "//tbody[@id='no_such_id']").should_not exist
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { @browser.body(:id, 3.14).exists? }.should raise_error(TypeError)
      lambda { @browser.table(:index, 1).body(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { @browser.body(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
      lambda { @browser.table(:index, 1).body(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  describe "#length" do
    it "returns the correct number of table bodies (page context)" do
      @browser.body(:id, 'first').length.should == 3
      @browser.body(:name, 'second').length.should == 3
    end

    it "returns the correct number of table bodies (table context)" do
      @browser.table(:index, 1).body(:id, 'first').length.should == 3
      @browser.table(:index, 1).body(:name, 'second').length.should == 3
    end
  end

  describe "#[]" do
    it "returns the row at the given index (page context)" do
      @browser.body(:id, 'first')[1].text.should == 'March 2008'
      @browser.body(:id, 'first')[2][1].text.should == 'Gregory House'
      @browser.body(:id, 'first')[3][1].text.should == 'Hugh Laurie'
    end

    it "returns the row at the given index (table context)" do
      @browser.table(:index, 1).body(:id, 'first')[1].text.should == 'March 2008'
      @browser.table(:index, 1).body(:id, 'first')[2][1].text.should == 'Gregory House'
      @browser.table(:index, 1).body(:id, 'first')[3][1].text.should == 'Hugh Laurie'
    end
  end

  describe "#each" do
    it "iterates through rows correctly" do
      body = @browser.table(:index, 1).body(:id, 'first')
      expected_texts = ["march", "gregory", "hugh"]

      body.each_with_index do |row, idx|
        row.id.should == expected_texts[idx]
      end

    end
  end

  after :all do
    @browser.close
  end

end