class Hash

  def symbolize_keys
    symbolized_hash = {}
    each_pair do |key, value| 
      symbolized_hash[key.to_sym] = 
      (value.is_a?(Hash) ? value.symbolize_keys : value)
    end
    symbolized_hash
  end

  def extract_keys

  end

end