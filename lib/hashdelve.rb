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
    return self[key] if self[key]
    return unless each_value do |value|
      if value.is_a?(Hash)
        return value.fetch_nested(key) if value.fetch_nested(key)
      end
    end
  end

end