require "sinatra"
require 'json'

set :bind, '0.0.0.0'

def load_gradebook
    text = File.read("gradebook.json")
    arr = JSON.parse(text)
    return arr
end

def set_gradebook
   @gradebook = load_gradebook 
end

def set_average
    sum = 0
    @gradebook.each do |student|
        sum += student["grade"]
    end
    @average = sum / @gradebook.length
end

get "/gradebook.json" do

    return load_gradebook.to_s
end


get "/gradebook" do
    set_gradebook
    erb :gradebook
end

get "/average" do
    set_gradebook
    set_average
    erb :average
end


get "/api/average" do
    set_gradebook
    set_average
    h = {}
    h["average"] = @average
    halt 200, h.to_json
end