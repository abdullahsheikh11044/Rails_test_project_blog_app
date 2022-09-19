# frozen_string_literal: true

require 'rails_helper'
require 'factory/factories'

RSpec.describe Comment, type: :model do
  let(:user) { create :user }
  let(:post) { create :post }
  let(:comment) { create :comment }

  describe 'assocaitions' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to belong_to(:post).class_name('Post') }
    it { is_expected.to have_many(:likes).class_name('Like') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:comment) }
    it { is_expected.to validate_length_of(:comment).is_at_most(25) }
  end

  context 'Creating comment' do
    it 'with all values null is not valid' do
      comment = described_class.new
      expect(comment).to be_invalid
    end

    it 'without comment is not valid' do
      comment.comment = ''
      expect(described_class.new(post_id: post.id, user_id: user.id)).to be_invalid
    end

    it 'with comment is valid' do
      comment.comment = 'asds'
      expect(comment).to be_valid
    end
  end
end
