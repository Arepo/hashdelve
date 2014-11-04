class Hash

  def symbolize_keys
    symbolized_hash = {}
    self.each_pair do |key, value| 
    	symbolized_hash[key.to_sym] = value
    end
    symbolized_hash
  end

end