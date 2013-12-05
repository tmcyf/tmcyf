FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password("secret12")
    # might want to consider making this optional, having "should confirm" as
    # an argument to the factory call
    confirmed_at(DateTime.now)
  end

  factory :retreat do
    sequence(:title, 2013) {|n| "Retreat #{n}" }
    location "Houston"
    body "A retreat."
    created_at DateTime.now
    startdt DateTime.now
    cost 100.0
    enddt DateTime.now + 3.days
  end
  factory :retreat_registration do
    user
    retreat
    emergency_contact "prolly ivan"
    emergency_phone "7139683673"
    emergency_relation "prolly ur mom"
    insurance_policy_number "8675309"
    days_attending 2
  end
  factory :payment do
    user
  end
end
