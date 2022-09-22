# frozen_string_literal: true
#admin cases
require 'rails_helper'

RSpec.describe 'Posts', type: :request do
    let(:ali) { FactoryBot.create(:user) }
    let(:ahmad) { FactoryBot.create(:user) }
    let(:moderator) { FactoryBot.create(:user,role: 2) }
    let(:admin) { FactoryBot.create(:user,role: 1) }
    let!(:ali_post) { FactoryBot.create(:post,user_id: ali.id) }
    let!(:publish_post) { FactoryBot.create(:post,user_id: ali.id, status: 1) }
    
      describe 'GET #new' do
        
        it 'should create post when user is signed in and role is user' do
          sign_in(ali)
          get new_post_path
          expect(response).to have_http_status(:ok)
          expect(response).to render_template('new')
        end

        it 'should not create post when user is signed in and role is moderator' do
          sign_in(moderator)
          get new_post_path
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to eq('not allowed to new? this Post')
        end

        it 'should not create post when user is signed in and role is admin' do
          sign_in(admin)
          get new_post_path
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to eq('not allowed to new? this Post')
        end

        it 'should not create post when user is not signed in' do
          sign_out(ali)
          get new_post_path
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      describe 'GET #show' do
        it 'should show post when user is signed in and role is user' do
          sign_in(ali)
          get post_path(ali_post)
          expect(response).to have_http_status(:ok)
        end

        it 'should show post when user is signed in and role is moderator' do
          sign_in(moderator)
          get post_path(ali_post)
          expect(response).to have_http_status(:ok)
        end

        it 'should not show post when user is not signed in' do
          sign_out(ali)
          get post_path(ali_post)
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end

        it 'should not show post when role is admin' do
          sign_in(admin)
          get post_path(ali_post)
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to eq('not allowed to show? this Post')
        end

      end

      describe 'GET #edit' do
        it 'should edit post when user is signed in and role is user' do
          sign_in(ali)
          get edit_post_path(ali_post)
          expect(response).to have_http_status(:ok)
        end

        it 'should not edit post when user is not creator of post' do
          sign_in(ahmad)
          get edit_post_path(ali_post)
          expect(response).to redirect_to root_path
        end

        it 'should edit post when role is moderator' do
          sign_in(moderator)
          get edit_post_path(ali_post)
          expect(response).to have_http_status(:ok)
        end
        it 'should not edit post when user is not signed in' do
          sign_out(ali)
          get edit_post_path(ali_post)
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

  describe 'GET #index' do
    it 'should displays published posts when user signed in' do 
        sign_in(ali)
        get posts_path
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('index')
    end

    it 'should displays unpublished posts when user signed in' do 
      sign_in(ali)
      get users_path
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('index')
  end

    it 'should redirect to sign in when user logged out' do
      sign_out(ali)
      get posts_path
      expect(response).to redirect_to new_user_session_path
      expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
    end
  end

  describe 'create#post ' do

    context "when signed in" do
    before do
      sign_in(moderator)
      sign_in(admin)
    end
    it 'creates posts only when role is user' do
      sign_in(ali)
      params = { post: { title: 'hello', body: '1111', user_id: ali.id } }
      post posts_path(params)
      expect(flash[:notice]).to eq('Post is susscessfuly  created')
    end

      it 'should not creates posts when title is blank' do
        sign_in(ali)
        params = { post: { title: '', body: '!111', user_id: ali.id } }
        post posts_path(params)
        expect(flash[:notice]).to eq("Title can't be blank")
      end

      it 'should not create post when role is moderator' do
        params = { post: { title: 'hello', body: '!111', user_id: moderator.id } }
        post posts_path(params)
        expect(flash[:alert]).to eq('not allowed to create? this Post')
      end

      it 'should not create post when role is admin' do
        params = { post: { title: 'hello', body: '!111', user_id: admin.id } }
        post posts_path(params)
        expect(flash[:alert]).to eq('not allowed to create? this Post')
      end
    end
    
  it 'should not create post when user not signed in' do
    sign_out(ali)
    params = { post: { title: 'hello', body: '!111', user_id: ali.id } }
    post posts_path(params)
    expect(response).to redirect_to new_user_session_path
  end

  end

  describe 'destroy#post ' do
    it 'delete post only when user is post user' do
        sign_in(ali)
        delete post_path(ali_post)
        expect(flash[:notice]).to eq('Post is susscessfuly  deleted')
        expect(response).to redirect_to posts_path
    end

    context "Checking destroy failure case" do
      let(:post3) {build_stubbed(:post)}
      before(:each) do
      allow(Post).to receive(:find).and_return(post3)
      allow(Post).to receive(:destroy).and_return(false)
      end
      it 'should not delete post if it dont exist' do
        sign_in(moderator)
        delete post_path(post3)
        expect(flash[:alert]).to eq("This post does not exists")
      end
    end
    it 'should not delete post when user is creator of post and post is unpublished' do
      sign_in(ahmad)
      delete post_path(ali_post.id)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('not allowed to destroy? this Post')
    end

    it 'should not delete post when user is creator of post and post is published' do
      sign_in(ahmad)
      delete post_path(publish_post.id)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('not allowed to destroy? this Post')
    end
    it 'should delete post when user role is moderator and post is unpublished' do
      sign_in(moderator)
      delete post_path(ali_post.id)
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to eq('Post is susscessfuly  deleted')
    end

    it 'should delete post when user role is moderator and post is published' do
      sign_in(moderator)
      delete post_path(publish_post.id)
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to eq('Post is susscessfuly  deleted')
    end
  end

  describe 'update#post ' do
    it 'should update post when role is user and is creator of post' do
        sign_in(ali)
        params = { post: { title: 'hello', body: '!111' }, user_id: ali.id, id: ali_post.id }
        patch post_path(params)
        expect(response).to redirect_to post_path(ali_post.id)
        expect(flash[:notice]).to eq("Post is susscessfuly  updated")
    end

    it 'should update post when role is moderator and post is unpublished' do
      sign_in(moderator)
      params = { post: { title: 'hello', body: '!111' }, user_id: moderator.id, id: ali_post.id }
      patch post_path(params)
      expect(response).to redirect_to post_path(ali_post.id)
      expect(flash[:notice]).to eq("Post is susscessfuly  updated")
    end

    it 'should update post when role is moderator and post is published' do
      sign_in(moderator)
      params = { post: { title: 'hello', body: '!111' }, user_id: moderator.id, id: publish_post.id }
      patch post_path(params)
      expect(response).to redirect_to post_path(publish_post.id)
      expect(flash[:notice]).to eq("Post is susscessfuly  updated")
  end

    it ' should not update post when body is null' do
      sign_in(ali)
      params = { post: { title: 'hello', body: '' }, user_id: ali.id, id: ali_post.id }
      patch post_path(params)
      expect(flash[:notice]).to eq("Body can't be blank")
    end
    it 'should not update post when user is not post user' do
      sign_in(ahmad)
      params = { post: { title: 'hello', body: '' }, user_id: ahmad.id, id: ali_post.id }
      patch post_path(params)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('not allowed to update? this Post')

    end

    it 'should not update post when role is user and is not signed in' do
      sign_out(ali)
      params = { post: { title: 'hello', body: '!111' }, user_id: ali.id, id: ali_post.id }
      patch post_path(params)
      expect(response).to redirect_to new_user_session_path
      expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
  end

  end
end
