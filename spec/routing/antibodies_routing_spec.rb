require 'spec_helper'

describe AntibodiesController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/antibodies').to route_to('antibodies#index')
    end

    it 'routes to #new' do
      expect(get: '/antibodies/new').to route_to('antibodies#new')
    end

    it 'routes to #show' do
      expect(get: '/antibodies/1').to route_to('antibodies#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/antibodies/1/edit').to route_to('antibodies#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/antibodies').to route_to('antibodies#create')
    end

    it 'routes to #update' do
      expect(put: '/antibodies/1').to route_to('antibodies#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/antibodies/1').to route_to('antibodies#destroy', id: '1')
    end

  end
end
