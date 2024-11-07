require_relative 'valid_ipv4'
require 'rspec'

RSpec.describe '#valid_ipv4?' do
  it 'returns true for a valid IP address like 192.168.0.1' do
    expect(valid_ipv4?('192.168.0.1')).to be true
  end

  it 'returns true for a valid IP address like 255.255.255.255' do
    expect(valid_ipv4?('255.255.255.255')).to be true
  end

  it 'returns false for an IP address with an octet out of range like 256.100.50.0' do
    expect(valid_ipv4?('256.100.50.0')).to be false
  end

  it 'returns false for an IP address with leading zeros in an octet like 192.168.01.1' do
    expect(valid_ipv4?('192.168.01.1')).to be false
  end

  it 'returns false for an incomplete IP address like 23.168.0' do
    expect(valid_ipv4?('23.168.0')).to be false
  end

  it 'returns false for non-numeric characters in IP address like abc.def.ghi.jkl' do
    expect(valid_ipv4?('abc.def.ghi.jkl')).to be false
  end

  it 'returns false for an IP address with more than four octets like 192.168.0.1.1' do
    expect(valid_ipv4?('192.168.0.1.1')).to be false
  end
end
