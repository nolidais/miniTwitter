namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(name: "Isami Aoki",
								 email: "nolidais@gmail.com",
								 password: "prueba",
								 password_confirmation: "prueba",
								 admin: true)
		99.times do |n|
			name  = Faker::Name.name
			email = "user-#{n+1}@example.com"
			password  = "password"
			User.create!(name: name,
									 email: email,
									 password: password,
									 password_confirmation: password,
									 admin: false)
		end
		users = User.all(limit: 10)
		users.each do |user| 
			rand(1-50).times do
				content = Faker::Lorem.sentence(5)
				user.microposts.create!(content: content)
			end
		end
	end
end