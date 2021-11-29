RSpec.shared_examples 'sizeable' do
  let(:instance) { described_class.new }

  it 'knows that one-point story is small' do
    allow(instance).to receive(:size).and_return(1)
    expect(instance).to be_small
  end

  it 'knows that two-point story is not small' do
    allow(instance).to receive(:size).and_return(2)
    expect(instance).not_to be_small
  end

  it 'knows that five-point story is epic' do
    allow(instance).to receive(:size).and_return(5)
    expect(instance).to be_an_epic
  end

  it 'knows that four-point story is not an epic' do
    allow(instance).to receive(:size).and_return(4)
    expect(instance).not_to be_an_epic
  end
end
