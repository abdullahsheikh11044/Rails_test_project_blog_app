# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  before do
    @user1 = create(:user)
    @user1.confirm
    sign_in(@user1)
    @post = create(:post, user_id: @user1.id)
    @comment = create(:comment, user_id: @user1.id, id: @post.id)
  end

  describe 'create#comment ' do
    it 'creates comments' do
      @user1.user!
      params = { comment: { comment: 'hello', user_id: @user1.id }, post_id: @post.id }
      post post_comments_path(params)
      expect(flash[:notice]).to redirect_to post_path(@post.id)
    end
  end
end
