# coding: utf-8

User.create!(name: "Sample user",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)
             
             
3.times do |n|
  name = "上長#{n+1}"
  email = "superior-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               superior: true)
end

20.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

9.times do |n|
  id = "#{n+1}"
  name = "拠点#{n+1}"
  type = "退勤"
  Base.create!(
               id: id,
               base_name: name,
               base_type: type)
end
  