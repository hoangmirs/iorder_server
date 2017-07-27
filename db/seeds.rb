#Category
Category.all.destroy_all
puts "Destroy categories success !"
(1..3).each do |i|
  image_names = %w(cafe trasua xienque)
  file_image = File.open(File.join(Rails.root, "db/master/seed/#{image_names[i-1]}.jpg"))
  category = Category.new name: Faker::Company.name, description: Faker::Lorem.sentence,
    image: file_image
  category.save
end
puts "Create categories success !"
