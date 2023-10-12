# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

Position.create({
  name: "Junior",
  super: false
})

Position.create({
  name: "Senior",
  super: true
})

Position.create({
  name: "Manager",
  super: true
})

EmploymentStatus.create({
  name:"Active"
})

EmploymentStatus.create({
  name:"Retired"
})

EmploymentStatus.create({
  name:"On Vacation"
})
10.times do

  first_name, last_name = Faker::Name.name.split(" ")
  jmbg = 13.times.map { rand(10) }.join
  address = Faker::Address.street_address
  date = Faker::Date.between(from: '2014-09-23', to: '2020-09-25')
  email = Faker::Internet.email(name: first_name)
  position_id = Position.pluck(:id).sample
  employment_status_id = EmploymentStatus.pluck(:id).sample
  #superior_id = Employee.find(Employee.pluck(:id).sample)
  emp = Employee.create({
    first_name: first_name,
    last_name: last_name,
    JMBG: jmbg,
    address: address,
    employment_date: date,
    email: email,
    position_id: position_id,
    employment_status_id: employment_status_id
  })
  p [first_name, last_name, jmbg, address, date,email, position_id, employment_status_id]
  p emp.errors
end