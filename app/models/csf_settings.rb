class CsfSettings < ActiveRecord::Base

  validates :name, presence: true, uniqueness: { allows_blank: true }

  def self.admin_salt
    get('admin_salt')
  end

  def self.admin_salt=(value)
    set('admin_salt', value)
  end

  def self.admin_crypted_password
    get('admin_crypted_password')
  end

  def self.admin_crypted_password=(value)
    set('admin_crypted_password', value)
  end

  def self.get(name)
    where(name: name).first.try(:value)
  end

  def self.set(name, value)
    s = create_with(value: value).find_or_initialize_by(name: name)
    s.value = value
    s.save
  end

end
