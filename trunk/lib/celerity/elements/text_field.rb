module Celerity
  #
  # Class representing text field elements
  #
  # This class is the main class for Text Fields
  # Normally a user would not need to create this object as it is returned by the Watir::Container#text_field method
  class TextField < InputElement
    TAGS = [ Identifier.new('textarea'), 
             Identifier.new('input', :type => %w(text password))  ]

    def clear
      assert_exists
      case @object.getTagName
      when 'textarea'
        @object.setText('')
      when 'input'
        @object.setValueAttribute('')
      end
    end
  
    def set(value)
      assert_enabled
      assert_not_readonly
      clear
      # not sure what else to do here
      if @object.class == com.gargoylesoftware.htmlunit.html.HtmlPasswordInput
        @object.setValueAttribute(value.to_s)
      else
        value.to_s.to_java_bytes.each do |char| 
          @container.update_page @object.type(char) 
        end
      end
    end
    
    def value=(value)
      assert_enabled
      assert_not_readonly
      clear
      case @object.getTagName
      when 'textarea'
        @object.setText(value.to_s)
      when 'input'
        @object.setValueAttribute(value.to_s)
      end
    end

    def append(value)
      assert_enabled
      assert_not_readonly
      value.to_s.to_java_bytes.each { |char| @container.update_page @object.type(char) }
    end

    # This bascially just moves the text to the other text field using TextField#append
    # Should check if the HtmlUnit API supports some kind of dragging.
    def drag_contents_to(how, what)
      assert_exists # assert_enabled?
      val = self.value
      self.value = ''
      @container.text_field(how, what).append(val)
    end
    alias_method :dragContentsTo, :drag_contents_to
  
    def get_contents
      self.value
    end
    alias_method :getContents, :get_contents

    def verify_contains(expected)
      assert_exists
      !!contains_text(expected)
    end
  end
  
  # this class can be used to access hidden field objects
  # Normally a user would not need to create this object as it is returned by the Watir::Container#hidden method
  class Hidden < TextField
    TAGS = [ Identifier.new('input', :type => %w(hidden)) ]
  end
  
end