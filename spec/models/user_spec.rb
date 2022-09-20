# frozen_string_literal: true

require 'rails_helper'
require 'factory/factories'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe 'assocaitions' do
    it { should have_many(:posts).class_name('Post') }
    it { should have_many(:comments).class_name('Comment') }
    it { should have_many(:likes).class_name('Like') }
    it { should have_many(:suggestions).class_name('Suggestion') }
    it { should have_many(:reports).class_name('Report') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
