# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:user3) { FactoryBot.create(:user, role: 2) }
    let(:post1) { FactoryBot.create(:post,user_id: user1.id) }
    
      describe 'GET #new' do
        it 'should creates post only when user is signed in' do
          sign_in(user1)
          get new_post_path
          expect(response).to have_http_status(:ok)
          expect(response).to render_template('new')
        end
        it 'should not creates post when user is not signed in' do
          sign_out(user1)
          get new_post_path
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe 'GET #show' do
        it 'should show post only when user is signed in' do
          sign_in(user1)
          get post_path(post1)
          expect(response).to have_http_status(:ok)
        end
        it 'should not show post when user is not signed in' do
          sign_out(user1)
          get post_path(post1)
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe 'GET #edit' do
        it 'should show post only when user is signed in' do
          sign_in(user1)
          get edit_post_path(post1)
          expect(response).to have_http_status(:ok)
        end
        it 'should not show post when user is not signed in' do
          sign_out(user1)
          get edit_post_path(post1)
          expect(response).to redirect_to new_user_session_path
        end
      end
  describe 'GET #index' do
    it 'should displays published posts when user signed in' do
        sign_in(user1)
        get posts_path
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('index')
    end

    it 'post page redirect to sign in with no user' do
      sign_out(user1)
      get posts_path
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'create#post ' do
    it 'creates posts only when role is user' do
        sign_in(user1)
        user1.user!
        params = { post: { title: 'hello', body: '!111', status: 'publish', user_id: user1.id } }
        post posts_path(params)
        expect(flash[:notice]).to eq('Post is susscessfuly  created')
    end

    it 'should not creates posts when title is blank' do
      sign_in(user1)
      user1.user!
      params = { post: { title: '', body: '!111', status: 'publish', user_id: user1.id } }
      post posts_path(params)
      expect(flash[:notice]).to eq("Title can't be blank")
    end

    it 'should not creates posts when body is blank' do
      sign_in(user1)
      user1.user!
      params = { post: { title: 'hello', body: '', status: 'publish', user_id: user1.id } }
      post posts_path(params)
      expect(flash[:notice]).to eq("Body can't be blank")
    end
    it 'should not creates posts when user not signed in' do
      sign_out(user1)
      params = { post: { title: 'hello', body: '!111', status: 'publish', user_id: user1.id } }
      post posts_path(params)
      expect(response).to redirect_to new_user_session_path
  end

  it 'should not creates posts when role is moderator' do
    sign_in(user3)
    params = { post: { title: 'hello', body: '!111', status: 'publish', user_id: user1.id } }
    post posts_path(params)
    expect(flash[:alert]).to eq('not allowed to create? this Post')

end
  end

  describe 'destroy#post ' do
    it 'deletes posts only when user is post user' do
        sign_in(user1)
        delete post_path(post1)
        expect(response).to redirect_to posts_path
    end

    context "This is checking the destroy fail case" do
      let(:post3) {build_stubbed(:post)}
      before(:each) do
      allow(controller).to receive(:find).and_return(post3)
      allow(controller).to receive(:destroy).and_return(false)
      end
      it 'should not deletes post if it doesnt exist' do
        sign_in(user1)
        user1.moderator!
        puts post3.id
        delete post_path(post3)
        expect(flash[:alert]).to eq("This post does not exists")
      end
    end
    it 'should not deletes posts when user is not post user' do
      sign_in(user2)
      delete post_path(post1.id)
      expect(response).to redirect_to(root_path)
    end
    it 'deletes posts when user role is moderator' do
      sign_in(user3)
      user3.moderator!
      delete post_path(post1.id)
      expect(response).to redirect_to(posts_path)
    end
  end

  describe 'update#post ' do
    it 'should updates posts when role is user' do
        sign_in(user1)
        params = { post: { title: 'hello', body: '!111' }, user_id: user1.id, id: post1.id }
        patch post_path(params)
        expect(response).to redirect_to post_path(post1.id)
    end

    it 'should updates posts when role is moderator' do
      sign_in(user1)
      user1.moderator!
      params = { post: { title: 'hello', body: '!111' }, user_id: user1.id, id: post1.id }
      patch post_path(params)
      expect(response).to redirect_to post_path(post1.id)
  end
    it ' should not updates posts when invalid params' do
      sign_in(user1)
      params = { post: { title: 'hello', body: '' }, user_id: user1.id, id: post1.id }
      patch post_path(params)
      expect(flash[:notice]).to eq("Body can't be blank")
    end
    it 'should not updates posts when user is not post user' do
      sign_in(user2)
      patch post_path(post1.id)
      expect(response).to redirect_to(root_path)
    end

    it 'updates posts when user role is moderator' do
      sign_in(user3)
      user3.moderator!
      delete post_path(post1.id)
      expect(response).to redirect_to(posts_path)
    end
  end
end
