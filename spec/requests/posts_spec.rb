# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:ali) { FactoryBot.create(:user) }
  let(:ali_post) { FactoryBot.create(:post, user_id: ali.id) }

  describe '#new ' do
    context 'when user is signed in' do
      before do
        sign_in(user)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }

        it 'render created post' do
          get new_post_path
          expect(response).to have_http_status(:ok)
          expect(response).to render_template('new')
        end
      end

      describe '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'render created post' do
          get new_post_path
          expect(response).to have_http_status(:found)
          expect(flash[:alert]).to eq('not allowed to new? this Post')
        end
      end

      describe '.admin' do
        let(:user) { create(:user, :admin) }

        it 'render created post' do
          get new_post_path
          expect(response).to have_http_status(:found)
          expect(flash[:alert]).to eq('not allowed to new? this Post')
        end
      end
    end

    context 'when user is signed out' do
      before do
        sign_out(user)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }

        it 'render created post' do
          get new_post_path
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      describe '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'render created post' do
          get new_post_path
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      describe '.admin' do
        let(:user) { create(:user, :admin) }

        it 'render created post' do
          get new_post_path
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end
    end
  end

  describe '#show' do
    context 'when user is signed in' do
      before do
        sign_in(user)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }

        it 'render show post' do
          get post_path(ali_post)
          expect(response).to have_http_status(:ok)
        end
      end

      describe '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'render show post' do
          get post_path(ali_post)
          expect(response).to have_http_status(:ok)
        end
      end

      describe '.admin' do
        let(:user) { create(:user, :admin) }

        it 'render show post' do
          get post_path(ali_post)
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context 'when user is signed out' do
      before do
        sign_out(user)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }

        it 'render show post' do
          get post_path(ali_post)
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      describe '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'render show post' do
          get post_path(ali_post)
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      describe '.admin' do
        let(:user) { create(:user, :admin) }

        it 'render show post' do
          get post_path(ali_post)
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end
    end
  end

  describe '#edit' do
    context 'when user is signed in' do
      before do
        sign_in(user)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }
        let(:post) { create(:post, user_id: user.id) }

        it 'edit his post' do
          get edit_post_path(post)
          expect(response).to have_http_status(:ok)
        end

        it 'does not edit others post' do
          get edit_post_path(ali_post)
          expect(response).to have_http_status(:found)
        end
      end

      describe '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'edits post' do
          get edit_post_path(ali_post)
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context 'when user is signed out' do
      before do
        sign_out(user)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }

        it 'does not edit' do
          get edit_post_path(ali_post)
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      describe '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'does not edit' do
          get edit_post_path(ali_post)
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      describe '.admin' do
        let(:user) { create(:user, :admin) }

        it 'does not edit' do
          get edit_post_path(ali_post)
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end
    end
  end

  describe '#index' do
    context 'when signed in' do
      before do
        sign_in(user)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }

        it 'displays published posts' do
          get posts_path
          expect(response).to have_http_status(:ok)
          expect(response).to render_template('index')
        end

        it 'displays unpublished posts' do
          get users_path
          expect(response).to have_http_status(:ok)
          expect(response).to render_template('index')
        end
      end

      describe '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'displays published posts' do
          get posts_path
          expect(response).to have_http_status(:ok)
          expect(response).to render_template('index')
        end

        it 'displays unpublished posts' do
          get users_path
          expect(response).to have_http_status(:ok)
          expect(response).to render_template('index')
        end
      end
    end

    context 'when signed out' do
      before do
        sign_out(user)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }

        it 'redirects to sign in page' do
          get posts_path
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      describe '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'redirects to sign in page' do
          get posts_path
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end
    end
  end

  describe '#create ' do
    let(:payload) do
      {
        post: {
          title: Faker::Lorem.word,
          body: Faker::Lorem.word,
          user_id: ali.id
        }
      }
    end

    context 'when signed in' do
      before do
        sign_in(user)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }

        it 'creates posts ' do
          post posts_path(payload)
          expect(flash[:notice]).to eq('Post is successfully  created')
        end

        it 'does not creates posts when title is blank' do
          payload[:post][:title] = nil
          post posts_path(payload)
          expect(flash[:notice]).to eq("Title can't be blank")
        end

        it 'does not creates posts when body is blank' do
          payload[:post][:body] = nil
          post posts_path(payload)
          expect(flash[:notice]).to eq("Body can't be blank")
        end
      end

      describe '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'does not create post ' do
          post posts_path(payload)
          expect(flash[:alert]).to eq('not allowed to create? this Post')
        end
      end

      describe '.admin' do
        let(:user) { create(:user, :admin) }

        it 'does not create post ' do
          post posts_path(payload)
          expect(flash[:alert]).to eq('not allowed to create? this Post')
        end
      end
    end

    context 'when signed out' do
      before do
        sign_out(user)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }

        it 'does not create post' do
          post posts_path(payload)
          expect(response).to redirect_to new_user_session_path
        end
      end

      describe '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'does not create post' do
          post posts_path(payload)
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end

  describe '#destroy ' do
    context 'When signed in' do
      before do
        sign_in(user)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }
        let(:post) { create(:post, user_id: user.id) }

        it 'delete post if he is creator of post' do
          delete post_path(post)
          expect(flash[:notice]).to eq('Post is successfully  deleted')
          expect(response).to redirect_to posts_path
        end

        it 'does not delete post if he is not creator of post' do
          delete post_path(ali_post)
          expect(flash[:alert]).to eq('not allowed to destroy? this Post')
        end

        it 'does not delete post if post not found' do
          delete post_path(0)
          expect(flash[:alert]).to eq('This post does not exists')
        end
      end

      describe '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'delete post if he is creator of post' do
          delete post_path(ali_post)
          expect(flash[:notice]).to eq('Post is successfully  deleted')
          expect(response).to redirect_to posts_path
        end
      end
    end

    context 'Checking destroy failure case' do
      let(:post3) { build_stubbed(:post) }

      before do
        sign_in(user)
        allow(controller).to receive(:find).and_return(post3)
        allow(controller).to receive(:destroy).and_return(false)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }
        let(:user1) { create(:user, :user) }
        let(:post) { create(:post, :publish, user_id: user1.id) }

        it 'does not delete post if it dont exist' do
          delete post_path(post3)
          expect(flash[:alert]).to eq('This post does not exists')
        end

        it 'does not delete post when user is creator of post and post is unpublished' do
          delete post_path(post.id)
          expect(response).to redirect_to(root_path)
          expect(flash[:alert]).to eq('not allowed to destroy? this Post')
        end
      end
    end

    context 'when signed out' do
      before do
        sign_out(user)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }
        let(:post) { create(:post, user_id: user.id) }

        it 'does not delete post ' do
          delete post_path(post.id)
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      describe '.moderator' do
        let(:user) { create(:user, :moderator) }
        let(:post) { create(:post, :publish, user_id: user.id) }

        it 'deletes post when post is published' do
          delete post_path(post.id)
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end

  describe '#update' do
    let(:payload) do
      {
        post: {
          title: Faker::Lorem.word,
          body: Faker::Lorem.word,
          user_id: user.id,
          post_id: post.id
        }
      }
    end

    context 'when signed in' do
      before do
        sign_in(user)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }
        let(:post) { create(:post, user_id: user.id) }
        let(:user1) { create(:user, :user) }

        it 'updates post' do
          get post_path(post.id)
          patch post_path(payload)
          expect(response).to redirect_to post_path(post.id)
          expect(flash[:notice]).to eq('Post is successfully  updated')
        end

        it ' should not update post when body is null' do
          payload[:post][:body] = nil
          get post_path(post.id)
          patch post_path(payload)
          expect(flash[:notice]).to eq("Body can't be blank")
        end
      end

      describe '.moderator' do
        let(:user) { create(:user, :moderator) }
        let(:post) { create(:post, :unpublish, user_id: user.id) }
        let(:post1) { create(:post, :publish, user_id: user.id) }

        it 'updates post when post is unpublished' do
          get post_path(post.id)
          patch post_path(payload)
          expect(response).to redirect_to post_path(post.id)
          expect(flash[:notice]).to eq('Post is successfully  updated')
        end

        it 'updates post when post is published' do
          get post_path(post1.id)
          patch post_path(payload)
          expect(response).to redirect_to post_path(post1.id)
          expect(flash[:notice]).to eq('Post is successfully  updated')
        end
      end
    end

    context 'when signed in' do
      before do
        sign_out(user)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }
        let(:post) { create(:post, user_id: user.id) }

        it 'does not update post ' do
          get post_path(post.id)
          patch post_path(payload)
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end
    end
  end
end
