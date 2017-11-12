require "json"
require_relative "main"

describe Director do
  it "should execute" do
    director = Director.new
    expect(JSON.parse(director.json)).to eq(
      JSON.parse(File.read("./level1/output.json"))
    )
  end
end
