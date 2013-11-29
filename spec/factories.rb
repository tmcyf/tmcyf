FactoryGirl.define do
  factory :user do |f|
    f.sequence(:email) { |n| "foo#{n}@example.com" }
    f.password("secret12")
    # might want to consider making this optional, having "should confirm" as
    # an argument to the factory call
    f.confirmed_at(DateTime.now)
  end
  
  factory :retreat do |f|
    f.sequence(:title, 2013) {|n| "Retreat #{n}" }
    f.location("Houston")
    f.body("A retreat.")
    f.created_at(DateTime.now)
    f.startdt(DateTime.now)
    f.enddt(DateTime.now + 3.days)
  end
end
