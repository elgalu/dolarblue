require 'spec_helper'

describe Dolarblue::Inflector do

  subject { Dolarblue::Inflector }

  it 'demodulizes simple 1-level unnested classes' do
    expect(subject.demodulize('Account')).to eq('Account')
    expect(subject.demodulize('Inflections')).to eq('Inflections')
  end

  it 'demodulizes larger 3-levels nested classes' do
    expect(subject.demodulize('MyApplication::Billing::Account')).to eq('Account')
  end

  it 'demodulizes 2-levels nested classes' do
    expect(subject.demodulize('Dolarblue::Card')).to eq('Card')
  end

  it 'demodulizes larger 4-levels nested classes' do
    expect(subject.demodulize('ActiveRecord::CoreExtensions::String::Inflections')).to eq('Inflections')
  end

  it 'demodulizes empty unnested string' do
    expect(subject.demodulize('')).to eq('')
  end

end
