require_relative '../array_separate'

describe ArraySeparate do
  let(:arr1) { [1,3,8,12,15,16,27,38,40] }
  let(:arr2) { [0,4,5,16,27,30,31,35] }

  it 'can separate arrays' do
    new_arr1, new_arr2 = ArraySeparate.start(arr1, arr2)
    expect(new_arr1.sort).to eq([0, 1, 3, 4, 5, 8, 12, 15, 16, 16])
    expect(new_arr2.sort).to eq([27, 27, 30, 31, 35, 38, 40])
  end
end
