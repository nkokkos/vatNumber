module ValidatesGreekVatNumberFormatOf

  def self.validate_greek_vat_number(s)
    
   # vat number must be 9 digits wide.
    if s.length !=9 
      return false
    end
	
    # Check to see if the number passed conforms to the rules of the algorithm
    # More about the algorithm here:
    # http://www.taxheaven.gr/acforum/index.php?showtopic=10377
    # http://www.dotnetzone.gr/cs/blogs/equilibrium/articles/Greek_VAT_Validation_Check.aspx
	
	# algorithm starts here
	sum = 0.0
      for k in 1..7
        sum = sum + (2**(8-k)) * s[k,1].to_i
      end
  
    if sum == 0 
       return false
    end

    check = sum.modulo(11)

    if check == s[s.length-1,1].to_i 
       return true
    elsif  
       (check == 10) and (s[s.length-1,1].to_i) == 0 
       return true
    else
       return false
    end
     # algorithm ends here
  
  end

  # Validates whether the specified value is a valid greek vat number.  Returns nil if the value is valid, otherwise returns an array
  # containing one or more validation error messages.
  #
  # Configuration options:
  # * <tt>message</tt> - A custom error message (default is: "does not appear to be a valid vat number")
  # * <tt>with</tt> The regular expression to use for validating the numericality of the number </tt>
  # http://www.railsforum.com/viewtopic.php?id=19081, :regular expression for checking for digits only
  def self.validate_greek_vat_number_format(number, options={} )
      default_options = { :message => I18n.t(:invalid_greek_vat_number, :scope => [:activerecord, :errors, :messages], :default => 'does not appear to be a valid vat number'),
                          :with => /\A[+-]?\d+?(\.\d+)?\Z/ }
						  
      options.merge!(default_options) {|key, old, new| old}  # merge the default options into the specified options, retaining all specified options
      
      # first check if the string passed consists only of numbers, other characters are not allowed	  
      unless number.to_s =~ options[:with]         
		return  [ options[:message] ]		
      end
   
      if ValidatesGreekVatNumberFormatOf::validate_greek_vat_number(number)
		 return nil
      else
		 return [ options[:message] ]
	  end
	  
      return nil    # represents no validation errors

  end
  
end

module ActiveRecord
  module Validations
    module ClassMethods
      # Validates whether the value of the specified attribute is a valid email address
      #
      #   class User < ActiveRecord::Base
      #     validates_greek_vat_number_format_of :vatnumber, :on => :create
      #   end
      #
      # Configuration options:
      # * <tt>message</tt> - A custom error message (default is: "does not appear to be a valid e-mail address")
      # * <tt>on</tt> - Specifies when this validation is active (default is :save, other options :create, :update)
      # * <tt>allow_nil</tt> - Allow nil values (default is false)
      # * <tt>allow_blank</tt> - Allow blank values (default is false)
      # * <tt>if</tt> - Specifies a method, proc or string to call to determine if the validation should
      #   occur (e.g. :if => :allow_validation, or :if => Proc.new { |user| user.signup_step > 2 }).  The
      #   method, proc or string should return or evaluate to a true or false value.
      # * <tt>unless</tt> - See <tt>:if</tt>
      def validates_greek_vat_number_format_of(*attr_names)
        options = { :on => :save, 
                    :allow_nil => false,
                    :allow_blank => false }
        options.update(attr_names.pop) if attr_names.last.is_a?(Hash)

        validates_each(attr_names, options) do |record, attr_name, value|
          v = value.to_s
          errors = ValidatesGreekVatNumberFormatOf::validate_greek_vat_number_format(v, options)
          errors.each do |error|
            record.errors.add(attr_name, error)
          end unless errors.nil?
        end
      end
    end   
  end
end
