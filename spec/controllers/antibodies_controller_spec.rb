require 'rails_helper'

RSpec.describe AntibodiesController, type: :controller do


  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'loads all of the antibodies into @antibodies' do
      antibody1, antibody2 = create(:antibody), create(:antibody)
      get :index
      expect(assigns(:antibodies)).to match_array([antibody1, antibody2])
    end
  end
end