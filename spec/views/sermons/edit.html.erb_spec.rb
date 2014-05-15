require 'spec_helper'

describe "sermons/edit" do
  before(:each) do
    @sermon = assign(:sermon, stub_model(Sermon,
      :title => "MyString",
      :notes => "MyText",
      :audio => "MyString"
    ))
  end

  it "renders the edit sermon form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sermon_path(@sermon), "post" do
      assert_select "input#sermon_title[name=?]", "sermon[title]"
      assert_select "textarea#sermon_notes[name=?]", "sermon[notes]"
      assert_select "input#sermon_audio[name=?]", "sermon[audio]"
    end
  end
end
