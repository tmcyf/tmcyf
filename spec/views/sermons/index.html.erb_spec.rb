require 'spec_helper'

describe "sermons/index" do
  before(:each) do
    assign(:sermons, [
      stub_model(Sermon,
        :title => "Title",
        :notes => "MyText",
        :audio => "Audio"
      ),
      stub_model(Sermon,
        :title => "Title",
        :notes => "MyText",
        :audio => "Audio"
      )
    ])
  end

  it "renders a list of sermons" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Audio".to_s, :count => 2
  end
end
