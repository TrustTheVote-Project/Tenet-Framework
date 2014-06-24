# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

st = State.create_with(name: 'Farallon').find_or_create_by(code: "FA")

name = "Farallon State Board of Elections"

# delete existing account
ac = Account.find_by(name: name)
ac.destroy if ac

# create account w/ admin and users
ac = Account.create!(state: st, name: name)
User.create(account: ac, login: "Farallon", first_name: "Farallon", last_name: "Admin", email: "admin@sbe.farallon.gov", admin: true, password: '0000', title: 'Farallon Admin', phone: '(000) 000-0000')
User.create(account: ac, login: "kwitwicki@sbe.farallon.gov", first_name: "Farallon", last_name: "Kwitwicki", email: "kwitwicki@sbe.farallon.gov", admin: false, password: '0000', title: 'Farallon User', phone: '(000) 000-0000')
User.create(account: ac, login: "preed@sbe.farallon.gov", first_name: "Farallon", last_name: "Preed", email: "preed@sbe.farallon.gov", admin: false, password: '0000', title: 'Farallon User', phone: '(000) 000-0000')
