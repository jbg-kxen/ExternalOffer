# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  @myOrg = '00DE0000000cTHgMAM'
  Offer.create([
    {orgId: @myOrg, name: 'Brokerage Account', script: 'Brokerage account script...'},
    {orgId: @myOrg, name: 'Checking Account', script: 'Checking account script...'},
    {orgId: @myOrg, name: 'Retirement Account', script: 'Retirement account script...'},
    {orgId: @myOrg, name: 'Savings Account', script: 'Savings account script...'},
    {orgId: @myOrg, name: 'Visa Account', script: 'Visa account script...'},
  ])