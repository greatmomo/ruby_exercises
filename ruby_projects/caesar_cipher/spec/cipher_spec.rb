#spec/cipher_spec.rb
require './lib/cipher'

RSpec.describe "#caesar_cipher" do
  context "with a positive shift" do
    it "shifts 'What a string!' to the right 5 times" do
      expect(caesar_cipher("What a string!", 5)).to eql("Bmfy f xywnsl!")
    end
  end

  context "with a negative shift" do
    it "shifts 'Another test?' to the left 13 times" do
      expect(caesar_cipher("Another test?", -13)).to eql("4abg[Xe gXfg?")
    end
  end

  context "with no shift" do
    it "shifts 'Yet another test' 0 times" do
      expect(caesar_cipher("Yet another test", 0)).to eql("Yet another test")
    end
  end
end
