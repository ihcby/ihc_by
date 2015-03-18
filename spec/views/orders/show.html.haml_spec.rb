require 'rails_helper'

RSpec.describe "orders/show", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :doctor => nil,
      :trial_type => nil,
      :conclusion => "Conclusion",
      :tracking_number => "Tracking Number",
      :trials => nil,
      :comment => "Comment"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Conclusion/)
    expect(rendered).to match(/Tracking Number/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Comment/)
  end
end
