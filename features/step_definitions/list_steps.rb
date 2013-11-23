Given /^I am logged in$/ do
  user = User.new(
    email:    'member@example.com', 
    password: 'helloworld',
    password_confirmation: 'helloworld')
  user.save
  visit root_path
  click_on 'Sign In'
  fill_in 'user_email', with: 'member@example.com'
  fill_in 'user_password', with: 'helloworld'
  click_button 'Sign in'
end

When /^I click "([^"]*)"$/ do |link|
  click_on link
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content text
end

Given /^I am at the "([^"]*)" page$/ do |view|
  string = view.gsub!(' ', '_')
  visit url_for string.to_sym 
  current_path.should == new_list_path
end

When /^I create a new list titled "([^"]*)"$/ do |title|
  fill_in :list_title, with: title
  fill_in :list_event, with: "xmas"
  select 2015, from: 'list_event_date_1i'

  click_on "Submit"
end

Then /^I should see "([^"]*)" after saving$/ do |title|
  page.should have_content title
end


Given /^I have a page titled "([^"]*)"$/ do |title|
  user = User.create(
    email:    'member@example.com', 
    password: 'helloworld',
    password_confirmation: 'helloworld')
  visit new_list_path
    fill_in :list_title, with: title
  fill_in :list_event, with: "xmas"
  select 2015, from: 'list_event_date_1i'
  click_on "Submit"
  page.should have_content title
end

Then /^I should see my index$/ do
  visit lists_path
  page.should have_content "In your profile you can"
end