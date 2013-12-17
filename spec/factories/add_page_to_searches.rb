# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :add_page_to_search, :class => 'AddPageToSearches' do
    page 1
  end
end
