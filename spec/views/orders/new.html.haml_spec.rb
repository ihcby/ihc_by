require 'rails_helper'

RSpec.describe "orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      :doctor => nil,
      :trial_type => nil,
      :conclusion => "MyString",
      :tracking_number => "MyString",
      :trials => nil,
      :comment => "MyString"
    ))
  end

  it "renders new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do

      assert_select "input#order_doctor_id[name=?]", "order[doctor_id]"

      assert_select "input#order_trial_type_id[name=?]", "order[trial_type_id]"

      assert_select "input#order_conclusion[name=?]", "order[conclusion]"

      assert_select "input#order_tracking_number[name=?]", "order[tracking_number]"

      assert_select "input#order_trials_id[name=?]", "order[trials_id]"

      assert_select "input#order_comment[name=?]", "order[comment]"
    end
  end
end
