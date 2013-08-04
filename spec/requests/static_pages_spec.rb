require 'spec_helper'

describe "Static pages" do
	let(:base_title) { "Mini Twitter app" }
	
	subject { page }

	describe "index" do
		before do
			sign_in FactoryGirl.create(:user)
			FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
			FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
			visit users_path
		end

		it { should have_title('All users') }
		it { should have_content('All users') }

		it "should list each user" do
			User.all.each do |user|
				expect(page).to have_selector('li', text: user.name)
			end
		end
	end
	
	describe "Home page" do
		before { visit root_path }
		it { should have_content('Mini Twitter') }
		it { should have_title full_title '' }
		it { should_not have_title(" | Home") }
		describe "for signed-in users" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
				FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
				sign_in user
				visit root_path
			end

			it "should render the user's feed" do
				user.feed.each do |item|
					expect(page).to have_selector("li##{item.id}", text: item.content)
				end
			end
		end
	end

	describe "Help page" do
		before { visit help_path }
		it { should have_content('Help') }
		it { should have_title full_title 'Help' }
	end
	describe "About page" do
		before { visit about_path }
		it { should have_content('About Us') }
		it { should have_title full_title 'About Us' }
	end
	describe "Contact page" do
		before { visit contact_path }
		it { should have_selector('h1', text: 'Contact') }
		it { should have_content('Contact') }
		it { should have_title full_title 'Contact' }
	end
	it "should have the right links on the layout" do
		visit root_path
		click_link "About"
		expect(page).to have_title(full_title('About Us'))
		click_link "Help"
		expect(page).to have_title(full_title('Help'))
		click_link "Contact"
		expect(page).to have_title(full_title('Contact'))
		click_link "Home"
		click_link "Sign up now!"
		expect(page).to have_title(full_title('Sign up'))
		click_link "Mini Twitter"
		expect(page).to have_title(full_title(''))
	end
end