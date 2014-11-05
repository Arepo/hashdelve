# Monkey Patch the Hash class to add the following methods -
# A symbolize keys method that transforms all keys in any arbitrarily complex nested hash from strings to symbols
# A method for extracting all keys from an arbitrarily complex nested hash
# A method for finding the value of a key from an arbitrarily complex nested hash
# The arbitrarily complex nested hash:

# { 'a' => { 'b' => 'Hello', 'c' => { 'd' => { 'e' => 'Nesting' }, 'f' => { 'g' => [1, 2, 3] }, 'h' => 'Very silly hash' }, 'i' => 15 } }

# The result of symbolize keys should be this: {:a=>{:b=>"Hello", :c=>{:d=>{:e=>"Nesting"}, :f=>{:g=>[1, 2, 3]}, :h=>"Very silly hash"}, :i=>15}}

# The result of extracting all keys should be this: ["a", "b", "c", "d", "e", "f", "g", "h", "i"]

# The result of passing in any key that exists in the hash to the find value method should return that value, i.e. passing it 'e' will return 'Nesting'
require 'hashdelve'
require 'byebug'

describe 'hashdelve' do 

  describe 'symbolize_keys' do

    xit 'returns an empty hash when called on an empty hash' do
       # returning weird error
       expect({}.symbolize_keys).to eq {}

    end

    it 'returns {a: :b} when called on {"a" => :b}' do
      
      expect({"hash_key1" => :hash_val1}.symbolize_keys).to eq({hash_key1: :hash_val1})

    end

    it 'returns {c: :d, e: :f} when called on {"c" => :d, "e" => :f}' do
      
      expect({"hash_key1" => :hash_val1, "hash_key2" => :hash_val2}.symbolize_keys).to eq({hash_key1: :hash_val1, hash_key2: :hash_val2})

    end

    it 'returns {a: {b: :c}} when called on {"a" => {"b" => :c}}' do

      expect({"a" => {"b" => :c}}.symbolize_keys).to eq({a: {b: :c}})

    end

  end

end