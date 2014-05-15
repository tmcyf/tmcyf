require 'spec_helper'

describe "sermons/show" do
  before(:each) do
    @sermon = assign(:sermon, stub_model(Sermon,
      :title => "Title",
      :notes => "MyText",
      :audio => "Audio"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/Audio/)
  end
end
