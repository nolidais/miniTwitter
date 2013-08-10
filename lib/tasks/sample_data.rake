namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_microposts
		make_relations
	end

	def make_users
		User.create!(name: "Isami Aoki", email: "nolidais@gmail.com", password: "prueba", password_confirmation: "prueba", admin: true)
		99.times do |n|
			name  = Faker::Name.name
			email = "user-#{n+1}@example.com"
			password  = "password"
			User.create!(name: name, email: email, password: password, password_confirmation: password, admin: false)
		end
	end
	
	def make_microposts
		users = User.all(limit: 10)
		users.each do |user| 
			rand(1-50).times do
				content = Faker::Lorem.sentence(5)
				user.microposts.create!(content: content)
			end
		end
	end
	def make_relations
		users = User.all
		user  = users.first
		followed_users = users[2..50]
		followers      = users[3..40]
		followed_users.each { |followed| user.follow!(followed) }
		followers.each      { |follower| follower.follow!(user) }
	end
end