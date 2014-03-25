module Features
  module AuthHelpers

    def register
      visit "/register"
      expect(page).to have_content "Register"
      user = FactoryGirl.build(:user)
      fill_in "user_fname", with: user.fname
      fill_in "user_lname", with: user.lname
      fill_in "user_line1", with: user.line1
      fill_in "user_city", with: user.city
      fill_in "user_state", with: user.state
      fill_in "user_zip", with: user.zip
      fill_in "user_phone", with: user.phone
      select user.gender, from: "user_gender"
      select "August", from: "user_birthday_2i"
      select "22", from: "user_birthday_3i"
      select "1992", from: "user_birthday_1i"
      select user.shirtsize, from: "user_shirtsize"
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password
      click_button "Sign up"

      return user
    end

    def sign_in
      visit "/login"
      user = FactoryGirl.create(:user)
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "Sign in"

      return user
    end

    def sign_in_admin
      visit "/login"
      user = FactoryGirl.create(:admin)
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "Sign in"

      return user
    end

  end
end