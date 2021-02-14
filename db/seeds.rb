# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(name:  "竹内涼真",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  address: "tokyo",
  admin: true)



password = "password"
history = Random.new(50)
randomAva = Random.new(4)
today = Date.today

77.times do |n|
  name = Faker::Name.name
  email = "talent-#{n+1}@railstutorial.org"
  address = n % 3 == 0? "osaka" : "tokyo"
  isPublic = n % 10 == 0? "false" : "true"
  user = User.create!(name:  name,
      email: email,
      password:              password,
      password_confirmation: password,
      isTalent: true,
      isPublic: isPublic,
      address: address)
  user.create_talent_profile(
  history: history.rand(50),
  belongs: "CreativeAgency",
  character: "Hello!!Iam a Man...Perfect Human!!",
  free_write: "こんにちは。わたしはお笑い芸人です。"
  )
  30.times do |d|
    user.schedules.create(
    start_time: today+d,
    inDate: (today+d).strftime("%Y-%m-%d"),
    availability: randomAva.rand(4)
    )
  end
end

#何人かフォローさせる
13.times do |n|
  email = "pumpee-#{n+1}@railstutorial.org"
  address = n % 3 == 0? "osaka" : "tokyo"
  User.create!(name:  name,
      email: email,
      password:              password,
      password_confirmation: password,
      address: address)
end


talent_user = User.create!(name:  "ごりら番長",
  email: "gorira@gorira.com",
  password:              "gorira",
  password_confirmation: "gorira",
  isTalent: true,
  isPublic: true,
  address: "tokyo")
talent_user.create_talent_profile(
history: 22,
belongs: "ザ・森東株式会社",
character: "なかなかの腕前でイカを裁くという芸をしています。
また、極彩色のきのこを探究していて、
日々、好きなことをしています。
日々是好日！！",
free_write: "I am free man!!
I am a man!!
I am Gorira!!
I am a perfect human!!!!
OK!!Google!!!
Have a nice day!!!")
30.times do |d|
  talent_user.schedules.create(
  start_time: today+d,
  inDate: (today+d).strftime("%Y-%m-%d"),
  availability: randomAva.rand(4)
  )
end
