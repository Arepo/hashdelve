class Hash

  def symbolize_keys
    symbolized_hash = {}
    each_pair do |key, value| 
    	symbolized_hash[key.to_sym] = (
    		if value.is_a? Hash
    		  value.symbolize_keys
    		else
    		  value
    		end)
    end
    symbolized_hash
  end

end