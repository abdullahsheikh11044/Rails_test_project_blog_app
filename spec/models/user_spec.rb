# frozen_string_literal: true

require 'rails_helper'
require 'factory/factories'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe 'assocaitions' do
    it { is_expected.to have_many(:posts).class_name('Post') }
    it { is_expected.to have_many(:comments).class_name('Comment') }
    it { is_expected.to have_many(:likes).class_name('Like') }
    it { is_expected.to have_many(:suggestions).class_name('Suggestion') }
    it { is_expected.to have_many(:reports).class_name('Report') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
