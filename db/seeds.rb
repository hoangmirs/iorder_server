#Category
Category.all.destroy_all
puts "Destroy categories success !"
(1..20).each do |i|
  Category.create name: Faker::Company.name, description: Faker::Lorem.sentence,
    image: Faker::Internet.url("ioder.com", "/image#{i}.jpg");
end
puts "Create categories success !"
