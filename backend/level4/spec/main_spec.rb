require "json"
require_relative "../main"

describe Main do
  let(:data) { JSON.parse(File.read("./level4/data.json")) }
  let(:output) { JSON.parse(File.read("./level4/output.json")) }

  after do
    Rental.delete_all
    Car.delete_all
  end

  it "should execute" do
    main = Main.new
    expect(main.transform(data)).to eq(output)
  end
end
