FactoryGirl.define do
  factory :user do
    fname "Baz"
    lname "Qux"
    sequence(:email) { |n| "foo#{n}@example.com" }
    password("secret12")
    # might want to consider making this optional, having "should confirm" as
    # an argument to the factory call
    confirmed_at(DateTime.now)
    factory :admin do
      admin true
    end
  end
end
