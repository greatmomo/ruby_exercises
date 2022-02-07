#spec/calculator_spec.rb
require './lib/calculator'

describe Calculator do
  subject { Calculator.new }

  describe "#add" do
    it "returns the sum of two numbers" do
      expect(subject.add(5, 2)).to eql(7)
    end

    it "returns the sum of more than two numbers" do
      expect(subject.add(2, 5, 7)).to eql(14)
    end
  end

  describe "#multiply" do
    it "returns the product of two numbers" do
      expect(subject.multiply(5, 2)).to eql(10)
    end
  end
end
