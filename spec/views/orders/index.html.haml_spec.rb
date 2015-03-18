require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        :doctor => nil,
        :trial_type => nil,
        :conclusion => "Conclusion",
        :tracking_number => "Tracking Number",
        :trials => nil,
        :comment => "Comment"
      ),
      Order.create!(
        :doctor => nil,
        :trial_type => nil,
        :conclusion => "Conclusion",
        :tracking_number => "Tracking Number",
        :trials => nil,
        :comment => "Comment"
      )
    ])
  end

  it "renders a list of orders" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Conclusion".to_s, :count => 2
    assert_select "tr>td", :text => "Tracking Number".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
  end
end
