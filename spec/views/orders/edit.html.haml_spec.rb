require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :doctor => nil,
      :trial_type => nil,
      :conclusion => "MyString",
      :tracking_number => "MyString",
      :trials => nil,
      :comment => "MyString"
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "input#order_doctor_id[name=?]", "order[doctor_id]"

      assert_select "input#order_trial_type_id[name=?]", "order[trial_type_id]"

      assert_select "input#order_conclusion[name=?]", "order[conclusion]"

      assert_select "input#order_tracking_number[name=?]", "order[tracking_number]"

      assert_select "input#order_trials_id[name=?]", "order[trials_id]"

      assert_select "input#order_comment[name=?]", "order[comment]"
    end
  end
end
