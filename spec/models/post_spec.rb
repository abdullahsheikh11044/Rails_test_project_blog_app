# frozen_string_literal: true

require 'rails_helper'
require 'factory/user_factory'
require 'factory/post_factory'
require 'factory/comment_factory'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:suggestions).dependent(:destroy) }
    it { is_expected.to have_many(:reports).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:title).is_at_most(15) }
  end
end
