# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before do
    @user1 = create(:user)
    @user1.confirm
    sign_in(@user1)
    @post1 = create(:post, user_id: @user1.id)
  end

  describe 'GET #index' do
    it 'displays published posts when user signed in' do
      get posts_path
      expect(response).to render_template(:index)
    end

    it 'post page redirect to sign in with no user' do
      sign_out(@user1)
      get posts_path
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'create#post ' do
    it 'creates posts only when role is user' do
      @user1.user!
      params = { post: { title: 'hello', body: '!111', status: 'publish', user_id: @user1.id } }
      post posts_path(params)
      expect(flash[:notice]).to eq('Post is susscessfuly  created')
    end
  end

  describe 'destroy#post ' do
    it 'deletes posts only when role is user' do
      @user1.user!
      delete post_path(@post1.id)
      expect(response).to redirect_to posts_path
    end
  end

  describe 'update#post ' do
    it 'updates posts only when role is user' do
      @user1.user!
      params = { post: { title: 'hello', body: '!111' }, user_id: @user1.id, id: @post1.id }
      patch post_path(params)
      expect(response).to redirect_to post_path(@post1.id)
    end
  end
end
