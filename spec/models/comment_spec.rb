# frozen_string_literal: true

require 'rails_helper'
require 'factory/user_factory'
require 'factory/post_factory'
require 'factory/comment_factory'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:comment) }
    it { is_expected.to validate_length_of(:comment).is_at_most(25) }
  end
end
