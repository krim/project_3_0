require_relative '../bank'

describe Bank do
  let(:bank1) { Bank.new(10_000, 0, 10, 2) }
  let(:bank2) { Bank.new(10_000, 13, 66, 22) }
  let(:bank3) { Bank.new(10_000, 10, 12, 3) }
  let(:bank4) { Bank.new(18_934, 7, 22, 11) }
  let(:bank_fail1) { Bank.new(18_934, 7, 22, 12) }
  let(:bank_fail2) { Bank.new(10_000.35, 10, 10, 2) }

  it "period must be multiple of days count" do
    expect{ bank_fail1.return_money }.to raise_error(InvalidPeriod)
  end

  it "amount must be integer" do
    expect{ bank_fail2.return_money }.to raise_error(TypeError)
  end

  it "must return correct amounts" do
    expect(bank1.return_money).to eq([5_000, 5_000])
    expect(bank2.return_money).to eq([4355, 4355, 4355, 4355, 4355, 4355, 4355, 4355, 4355, 4355, 4355, 4355, 4354, 4354, 4354, 4354, 4354, 4354, 4354, 4354, 4354, 4354])
    expect(bank3.return_money).to eq([7334, 7333, 7333])
    expect(bank4.return_money).to eq([4372, 4372, 4372, 4371, 4371, 4371, 4371, 4371, 4371, 4371, 4371])
  end

  it "can calculate need to return" do
    expect(bank1.need_to_return).to eq(10000)
    expect(bank2.need_to_return).to eq(95800)
    expect(bank3.need_to_return).to eq(22000)
    expect(bank4.need_to_return).to eq(48084)
  end
end
