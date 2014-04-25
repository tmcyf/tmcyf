FactoryGirl.define do
  factory :user do
    fname "Baz"
    lname "Qux"
    line1 "5810 Almeda-Genoa Rd"
    city "Houston"
    state "TX"
    zip "77048"
    phone "7139911557"
    gender "Male"
    birthday { 18.years.ago }
    shirtsize "L"
    sequence(:email) { |n| "foo#{n}@example.com" }
    password("secret12")
    password_confirmation "secret12"
    # might want to consider making this optional, having "should confirm" as
    # an argument to the factory call
    confirmed_at(DateTime.now)
    factory :admin do
      admin true
    end
  end

  factory :event do
    sequence(:title) { |n| "Event #{n}" }
    location "Ur Mom's Place"
    startdt DateTime.now
    enddt { startdt + 1.day }
  end
end
