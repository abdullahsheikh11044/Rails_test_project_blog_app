# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
    let(:user1) { FactoryBot.create(:user) }
    let(:post1) { FactoryBot.create(:post,user_id: user1.id) }
    let(:comment) { FactoryBot.create(:comment,id: post1.id, user_id: user1.id) }

    describe 'GET #index' do
      it 'displays comments when user signed in' do
          sign_in(user1)
          get post_comments_path(post1), xhr: true
          expect(response).to have_http_status(:success)
      end
  
      it 'post page redirect to sign in with no user' do
        sign_out(user1)
        get post_comments_path(post1)
        expect(response).to redirect_to new_user_session_path
      end
    end

  describe 'create#comment ' do
    it 'creates comments when user is signed in' do
      sign_in(user1)
      params = { comment: { comment: 'hello', user_id: user1.id }, post_id: post1.id }
      post post_comments_path(params)
      expect(flash[:notice]).to redirect_to post_path(post1.id)
    end
    it 'should not creates comments when user is not signed in' do
      sign_out(user1)
      params = { comment: { comment: 'hello', user_id: user1.id }, post_id: post1.id }
      post post_comments_path(params)
      expect(flash[:notice]).to redirect_to new_user_session_path
    end

    it 'should not creates comments when comment is blank' do
      sign_in(user1)
      params = { comment: { comment: "", user_id: user1.id }, post_id: post1.id }
      post post_comments_path(params), xhr: true
    end
  end
end
