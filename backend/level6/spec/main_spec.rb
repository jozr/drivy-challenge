require "json"
require_relative "../main"

describe Main do
  let(:data) { JSON.parse(File.read("./level6/data.json")) }
  let(:output) { JSON.parse(File.read("./level6/output.json")) }

  after do
    Action.delete_all
    RentalModification.delete_all
    Rental.delete_all
    Car.delete_all
  end

  it "should execute" do
    main = Main.new
    expect(main.transform(data)).to eq(output)
  end
end
