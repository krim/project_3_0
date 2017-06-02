require 'vcr'
require 'webmock'
require_relative '../load_images'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end


describe LoadImages do
  let(:valid_url) { 'https://www.shutterstock.com/' }
  let(:invalid_url) { 'asdas' }
  let(:dir) { 'spec_tmp' }

  after do
    FileUtils.rm_rf('spec_tmp')
  end

  it 'can load images' do
    VCR.use_cassette("shutterstock") do
      LoadImages.from(valid_url, dir: 'spec_tmp', debug: false)
      expect(File.directory?('spec_tmp')).to be(true)
      expect(Dir["#{dir}/*"].length).to be(24)
    end
  end

  it "expect valid URL" do
    expect{ LoadImages.from(invalid_url, debug: false) }.to raise_error(InvalidURI)
  end

  it "expect not empty URL" do
    expect{ LoadImages.from('', debug: false) }.to raise_error(BlankURI)
  end
end
