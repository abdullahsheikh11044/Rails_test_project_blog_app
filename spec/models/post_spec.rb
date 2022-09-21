# frozen_string_literal: true

require 'rails_helper'
require 'factory/user_factory'
require 'factory/post_factory'
require 'factory/comment_factory'

RSpec.describe Post, type: :model do
  let!(:post) { create :post }

  describe 'assocaitions' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy)  }
    it { should have_many(:suggestions).dependent(:destroy)  }
    it { should have_many(:reports).dependent(:destroy)  }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:title).is_at_most(15) }
  end

  context 'Creating post' do
    it 'should be invalid with null body' do
      post.body = ''
      expect(post).to be_invalid
    end

    it 'should be invalid with null title' do
      post.title = ''
      expect(post).to be_invalid
    end
  end
end
