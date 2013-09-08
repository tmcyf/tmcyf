require 'spec_helper'

Factory.define :user do |f|
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  f.password("secret12")
end