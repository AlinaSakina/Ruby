require 'rspec'
require_relative 'leap_year'

RSpec.describe '#leap_year?' do
  it 'returns true for a year divisible by 4 but not by 100' do
    expect(leap_year?(2024)).to eq(true)
  end

  it 'returns false for a year not divisible by 4' do
    expect(leap_year?(2023)).to eq(false)
  end

  it 'returns false for a year divisible by 100 but not by 400' do
    expect(leap_year?(1900)).to eq(false)
  end

  it 'returns true for a year divisible by 400' do
    expect(leap_year?(2000)).to eq(true)
  end

  it 'raises an error for negative years' do
    expect { leap_year?(-100) }.to raise_error(ArgumentError)
  end

  it 'raises an error for non-integer input' do
    expect { leap_year?('year') }.to raise_error(ArgumentError)
  end
end
