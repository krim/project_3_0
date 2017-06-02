require_relative '../find_nums'

describe FindNums do
  let(:numbers1) { [1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,19,20,22,23,25] }
  let(:numbers2) { [13,14,15,16,17,18,19,21,23,25] }
  let(:numbers3) { [13,14,15,16,17,18,19,20,21,22,23,24,25] }

  describe ".simple" do
    it "can find two numbers" do
      expect(FindNums.simple(numbers1)).to eq([13, 21])
      expect(FindNums.simple(numbers2)).to eq([20, 22])
    end

    it "can't find two numbers" do
      expect(FindNums.simple(numbers3)).to be_empty
    end
  end

  describe ".iterator" do
    it "can find two numbers" do
      expect(FindNums.hard(numbers1)).to eq([13, 21])
      expect(FindNums.hard(numbers2)).to eq([20, 22])
    end

    it "can't find two numbers" do
      expect(FindNums.hard(numbers3)).to be_empty
    end
  end
end
