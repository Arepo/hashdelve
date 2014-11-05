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
    inject([]) do |new_array, (key, value)|
      new_array << key
      new_array + (value.is_a?(Hash) ? value.extract_keys : [])
    end
  end

  def fetch_nested(key)
     fetch(key)
  end

end