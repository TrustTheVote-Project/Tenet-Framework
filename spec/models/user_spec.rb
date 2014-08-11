require 'spec_helper'

describe User do

  it 'should require public key' do
    u = build(:user, ssh_public_key: '')
    expect(u).not_to be_valid
    expect(u.errors[:ssh_public_key]).to eq [ 'is not a valid public key' ]
  end

  it 'should catch invalid public keys' do
    u = build(:user, ssh_public_key: 'invalid')
    expect(u).not_to be_valid
    expect(u.errors[:ssh_public_key]).to eq [ 'is not a valid public key' ]
  end

  it 'should validate ssh public key on create' do
    u = build(:user, ssh_public_key: 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEA1uVTQU9G4IV0x0SnEpuNbME/XMArXcNYXTPJReLlcFYEOFr3WVV5eP6kbXRgTbtlMvVCnxJ/vGRk6K1pIIw45QOBWbPjXPV7K538nRJaWgegEwVfRNvEN1gZJltEDQC9RJyg4kv76gTBzc/dPndQ8M18ZBQqDQIGQT+d2cw9B9M= recess@flex.websitewelcome.com')
    u.valid?
    expect(u.errors[:ssh_public_key]).to be_blank
  end

end
