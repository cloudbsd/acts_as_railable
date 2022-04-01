class String
  def numeric?
    return true if self =~ /\A\d+\Z/
    true if Float(self) rescue false
  end

  def is_numeric?
    # `!!` converts parsed number to `true`
    !!Kernel.Float(self) 
  rescue TypeError, ArgumentError
    false
  end

  def deep_strip!
    pattern = /([[:blank:]])+/
    if self.match? pattern
      self.gsub!(pattern, ' ').strip!
    else
      self.strip!
    end
  end

  def deep_strip
    self.gsub(/([[:blank:]])+/, ' ').strip
  end
end
