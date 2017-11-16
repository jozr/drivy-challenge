require "json"
require_relative "main"

describe Main do
  let(:data) { JSON.parse(File.read("./level2/data.json")) }
  let(:output) { JSON.parse(File.read("./level2/output.json")) }

  it "should execute" do
    Rental.delete_all
    Car.delete_all
    main = Main.new
    expect(main.transform(data)).to eq(output)
    Rental.delete_all
    Car.delete_all
  end
end
