# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
    let(:ali) { FactoryBot.create(:user) }
    let(:moderator) { FactoryBot.create(:user, role: 2) }
    let(:admin) { FactoryBot.create(:user, role: 1) }
    let(:ali_post) { FactoryBot.create(:post,user_id: ali.id) }
    let!(:comment) { FactoryBot.create(:comment,id: ali_post.id, user_id: ali.id) }

  describe 'create#comment ' do
    context 'When user is signed in' do
      before do
        sign_in(ali)
        sign_in(moderator)
        sign_in(admin)
      end
      it 'creates comment when user is signed in and role is user' do
        params = { comment: { comment: 'hello', user_id: ali.id }, post_id: ali_post.id }
        post post_comments_path(params)
        expect(response).to redirect_to post_path(ali_post.id)
      end  
      it 'should not create comment when comment is blank' do
        params = { comment: { comment: "", user_id: ali.id }, post_id: ali_post.id }
        post post_comments_path(params), xhr: true
      end

      it 'creates comment when user is signed in and role is moderator' do
        params = { comment: { comment: 'hello', user_id: moderator.id }, post_id: ali_post.id }
        post post_comments_path(params)
        expect(response).to redirect_to post_path(ali_post.id)
      end 

      it 'creates comment when user is signed in and role is admin' do
        params = { comment: { comment: 'hello', user_id: admin.id }, post_id: ali_post.id }
        post post_comments_path(params)
        expect(response).to redirect_to post_path(ali_post.id)
      end 
    end
    context "When user is not signed in" do
      before do
      sign_out(ali)
      sign_out(moderator)
      sign_out(admin)
      end
      it 'should not create comment when user is not signed in and role is user' do
        params = { comment: { comment: 'hello', user_id: ali.id }, post_id: ali_post.id }
        post post_comments_path(params)
        expect(response).to redirect_to new_user_session_path
      end

      it 'should not create comment when user is not signed in and role is moderator' do
        params = { comment: { comment: 'hello', user_id: moderator.id }, post_id: ali_post.id }
        post post_comments_path(params)
        expect(response).to redirect_to new_user_session_path
      end

      it 'should not create comment when user is not signed in and role is admin' do
        params = { comment: { comment: 'hello', user_id: admin.id }, post_id: ali_post.id }
        post post_comments_path(params)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
