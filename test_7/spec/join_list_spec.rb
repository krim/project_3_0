require_relative '../join_list'

describe JoinList do
  let(:list1) { Set.new [1,3,8,12,15,16,27,38,40] }
  let(:list2) { Set.new [3,4,5,6,7,8,10,11,12,13,15] }
  let(:list3) { Set.new [0,4,5,16,27,30,31,35] }
  let(:union_list) { [1, 3, 4, 5, 6, 7, 8, 10, 11, 12, 13, 15, 16, 27, 38, 40] }
  let(:union_list2) { [0, 1, 3, 4, 5, 8, 12, 15, 16, 27, 30, 31, 35, 38, 40] }

  context '.simple' do
    it "must return union sorted list" do
      expect(JoinList.simple(list1, list2)).to eq(union_list)
      expect(JoinList.simple(list1, list3)).to eq(union_list2)
    end
  end

  context '.hard' do
    it "must return union sorted list" do
      expect(JoinList.hard(list1, list2)).to eq(union_list)
      expect(JoinList.hard(list1, list3)).to eq(union_list2)
    end
  end


  it "can find item" do
    expect(JoinList.exist_values?(list1.to_a, 12, nil)).to be(true)
  end

  it "can't find item" do
    expect(JoinList.exist_values?(list1.to_a, 9, nil)).to be(false)
  end
end
