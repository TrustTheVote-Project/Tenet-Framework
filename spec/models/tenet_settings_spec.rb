require 'spec_helper'

describe TenetSettings do

  before { TenetSettings.delete_all }

  it 'should return nil for option' do
    expect(get('option')).to be_nil
  end

  it 'should set option and receive it back' do
    set('option', 'abc')
    expect(get('option')).to eq 'abc'
  end

  it 'should update option' do
    set('option', 'abc')
    set('option', 'def')
    expect(get('option')).to eq 'def'
  end

  private

  def get(name)
    TenetSettings.get name
  end

  def set(name, value)
    TenetSettings.set name, value
  end

end
