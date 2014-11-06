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

    it 'returns an empty hash when called on an empty hash' do
       # returning weird error
       expect({}.symbolize_keys).to eq({})
    end

    it 'when given a single-pair hash with a string key, returns a similar hash with a symbol key' do
      expect({"symbolizee" => :hash_val}.symbolize_keys).to eq({symbolizee: :hash_val})
    end

    it 'returns symbolized keys for each key when called on ' do
      expect({"symbolizee1" => :hash_val1, "symbolizee2" => :hash_val2}.symbolize_keys).to eq({symbolizee1: :hash_val1, symbolizee2: :hash_val2})
    end

    it 'returns symbolized keys for all the keys in a nested hash' do
      expect({"symbolizee1" => {"symbolizee2" => :hash_val}}.symbolize_keys).to eq({symbolizee1: {symbolizee2: :hash_val}})
    end

  end

  describe 'extract_keys' do

    it 'returns an empty array when called on an empty hash' do
      expect({}.extract_keys).to eq []
    end

    it 'returns the the key (in an array) when called on a single pair hash' do
      expect({pick_me!: :leave_me_behind}.extract_keys).to eq [:pick_me!]
    end

    it 'returns the keys when called on a hash with two pairs' do
      expect({pick_me!: :not_me, and_me!: :no_one_loves_me}.extract_keys).to eq [:pick_me!, :and_me!]
    end

    it 'returns the keys when called on a nested hash' do
      expect({pick_me!: {and_me!: :muffled_sobs}}.extract_keys).to eq [:pick_me!, :and_me!]
    end

  end

  describe 'fetch_nested' do

    it 'returns nil when called on an empty hash' do
      expect({}.fetch_nested :key).to eq nil
    end

    it "returns nil when called on a populated hash that doesn't have the right key" do
      expect({key: :val}.fetch_nested(:three_headed_monkey)).to eq nil
    end

    it 'returns the value when called with the right key on a single-pair hash' do
      expect({key: :val}.fetch_nested(:key)).to eq :val
    end

    it "returns the value when called with a key that's in a nested hash" do
      expect({easy_key: {tricky_key: :jackpot}}.fetch_nested(:tricky_key)).to eq :jackpot
    end

    it "returns the value when called with a key that's in a subsequent nested hash" do
      expect({easy_key: {less_easy_key: :fools_gold}, easy_key2: {tricky_key: :jackpot}}.fetch_nested(:tricky_key)).to eq :jackpot
    end

  end

end