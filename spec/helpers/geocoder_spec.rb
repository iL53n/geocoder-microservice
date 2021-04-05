RSpec.describe Geocoder do
  subject { described_class }

  before do
    stub_const("#{described_class}::DATA_PATH",
               Application.root.concat('/spec/fixtures/city.csv'))
  end

  let(:city) { 'City 17' }

  context 'existing city' do
    it 'return coordinates' do
      expect(subject.geocode(city))
        .to eq([45.05, 90.05])
    end
  end

  context 'missing city' do
    it 'return nil' do
      expect(subject.geocode('NilCity'))
        .to eq(nil)
    end
  end
end
