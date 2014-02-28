
require 'spec_helper'

describe "Admin" do
  before(:each) do
    @admin = create(:admin)
  end

  it "should be inaccessible before sign-in" do
    visit "/admin2"
    page.status_code.should == 403
  end
end
