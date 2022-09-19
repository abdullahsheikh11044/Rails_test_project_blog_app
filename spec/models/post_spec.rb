# frozen_string_literal: true

require 'rails_helper'
require 'factory/factories'

RSpec.describe Post, type: :model do
  let(:user) { create :user }
  let(:post) { create :post }

  describe 'assocaitions' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to have_many(:comments).class_name('Comment') }
    it { is_expected.to have_many(:likes).class_name('Like') }
    it { is_expected.to have_many(:suggestions).class_name('Suggestion') }
    it { is_expected.to have_many(:reports).class_name('Report') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:title).is_at_most(15) }
  end

  context 'Creating post' do
    it 'with all values null is not valid' do
      post = described_class.new
      expect(post).to be_invalid
    end

    it 'with title only is not valid' do
      post.body = ''
      expect(described_class.new(title: 'First post', user_id: user.id)).to be_invalid
    end

    it 'with body only is not valid' do
      post.title = ''
      expect(post).to be_invalid
    end

    it 'with no title is not valid' do
      post.title = ''
      expect(post).to be_invalid
    end
  end
end
