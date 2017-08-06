#Category
Category.all.destroy_all
puts "Destroy categories success !"
errors = 0
category_names = %w(cafe trasua xienque)
category_names.each do |category_name|
  file_image = File.open(File.join(Rails.root, "db/master/seed/categories/#{category_name}.jpg"))
  category = Category.new name: category_name, description: Faker::Lorem.sentence,
    image: file_image
  if category.save
    (1..2).each do |j|
      product_image = File.open(File.join(Rails.root, "db/master/seed/products/#{category_name}_#{j}.jpg"))
      category.products.create name: "#{category_name}_#{j}", description: Faker::Lorem.sentence,
        image: product_image, price: Faker::Number.number(7), status: [*0..1].sample,
          cost_time: Faker::Number.decimal(2)
    end
  else
    errors += 1
  end
end
puts "Create categories success ! #{errors} errors"

#Sale
Sale.all.destroy_all
puts "Destroy Sales success !"
errors = 0
(1..5).each do |i|
  sale_image = File.open(File.join(Rails.root, "db/master/seed/sales/sale_#{i}.jpg"))
  sale = Sale.new name: Faker::Color.color_name, description: Faker::Lorem.sentence,
    code: Sale.generate_sales_code, genre: Sale.genres.keys.sample, num: Faker::Number.decimal(2),
      apply_all: true, image: sale_image, start_time: 1.day.ago, end_time: 1.month.from_now
  unless sale.save
    errors += 1
    next
  end
  if i.odd?
    sale.update apply_all: false
    sale.products_sales.create product: Product.where.not(id: ProductsSale.pluck(:product_id)).sample
  end
end
puts "Create Sales success!"
