# frozen_string_literal: true

require 'rails_helper'
require 'factory/user_factory'
RSpec.describe User, type: :model do
  describe 'assocaitions' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy)  }
    it { should have_many(:suggestions).dependent(:destroy) }
    it { should have_many(:reports).dependent(:destroy)  }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
  
end
