require 'rails_helper'

describe Antibody do
  describe 'validation' do
    it { expect validate_uniqueness_of(:name) }
    it { expect validate_presence_of(:name) }
  end

end