# frozen_string_literal: true

require 'rails_helper'
require 'factory/user_factory'
require 'factory/post_factory'
require 'factory/comment_factory'

RSpec.describe Comment, type: :model do
  let(:user) { create :user }
  let(:post) { create :post }
  let!(:comment) { create :comment }

  describe 'assocaitions' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:comment) }
    it { should validate_length_of(:comment).is_at_most(25) }
  end

  context 'Creating comment' do
    it 'should be invalid when comment is null' do
      comment.comment = ''
      expect(comment).to be_invalid
    end

    it 'should be valid with comment not null' do
      expect(comment).to be_valid
    end
  end
end
