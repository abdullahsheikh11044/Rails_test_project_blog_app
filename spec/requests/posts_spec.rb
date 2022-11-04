# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe '#new ' do
    context 'when logged in' do
      before do
        sign_in(user)
      end

      context '.user' do
        let(:user) { create(:user, :user) }

        it 'render new' do
          get new_post_path
          
          expect(response).to have_http_status(:ok)
          expect(response).to render_template('new')
        end
      end

      context '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'render new' do
          get new_post_path
          expect(response).to  have_http_status(302)
          expect(flash[:alert]).to eq('not allowed to new? this Post')
        end
      end

      context '.admin' do
        let(:user) { create(:user, :admin) }

        it 'returns error' do
          get new_post_path
          expect(response).to have_http_status(302)
          expect(flash[:alert]).to eq('not allowed to new? this Post')
        end
      end
    end

    context 'when not logged in' do

      context '.user' do
        let(:user) { create(:user, :user) }

        it 'redirect to login page' do
          get new_post_path

          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      context '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'redirect to login page' do
          get new_post_path
          
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      context '.admin' do
        let(:user) { create(:user, :admin) }

        it 'redirect to login page' do
          get new_post_path

          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end
    end
  end

  describe '#show' do
    context 'when logged in' do
      before do
        sign_in(user)
      end
      let(:user) { create(:user, :user) }
      let(:post) { create(:post, user_id: user.id)}
      context '.user' do
        let(:user) { create(:user, :user) }
        it 'render show post' do
          get post_path(post)

          expect(response).to have_http_status(:ok)
        end
      end

      context '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'render show post' do
          get post_path(post)
          
          expect(response).to have_http_status(:ok)
        end
      end

      context '.admin' do
        let(:user) { create(:user, :admin) }

        it 'render show post' do
          get post_path(post)
          
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context 'when not logged in' do
      let(:user) { create(:user, :user) }
      let(:post) { create(:post, user_id: user.id)}

      context '.user' do
        let(:user) { create(:user, :user) }

        it 'redirect to login page' do
          get post_path(post)
          
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      context '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'redirect to login page' do
          get post_path(post)
          
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      context '.admin' do
        let(:user) { create(:user, :admin) }

        it 'redirect to login page' do
          get post_path(post)
          
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end
    end
  end

  describe '#edit' do
    context 'when logged in' do
      before do
        sign_in(user)
      end
      let(:user1) { create(:user, :user) }
      let(:post1) { create(:post, user_id: user1.id) }
      context '.user' do
        let(:user) { create(:user, :user) }
        let(:post) { create(:post, user_id: user.id) }

        context "when user is owner" do
          it 'render edit post' do
            get edit_post_path(post)
          
            expect(response).to have_http_status(:ok)
          end
        end

        context "when user is not owner" do
          it 'returns error' do
            get edit_post_path(post1)
          
            expect(response).to have_http_status(302)
          end
        end
      end

      context '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'render edit post' do
          get edit_post_path(post1)

          expect(response).to have_http_status(:ok)
        end
      end
    end

    context 'when not logged in' do

      let(:user1) { create(:user, :user) }
      let(:post1) { create(:post, user_id: user1.id) }
      
      context '.user' do
      
        let(:user) { create(:user, :user) }
      
        it 'redirect to login page' do
      
          get edit_post_path(post1)
          
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
          expect(response).to redirect_to new_user_session_path
      
        end
      end

      context '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'redirect to login page' do
          get edit_post_path(post1)
          
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      context '.admin' do
        let(:user) { create(:user, :admin) }

        it 'redirect to login page' do
          get edit_post_path(post1)
          
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end
    end
  end

  describe '#index' do
    context 'when logged in' do
      before do
        sign_in(user)
      end

      context '.user' do
        let(:user) { create(:user, :user) }

        it 'render posts' do
          get posts_path
          
          expect(response).to have_http_status(:ok)
          expect(response).to render_template('index')
        
        end
      end

      context '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'render posts' do
          get posts_path
          
          expect(response).to have_http_status(:ok)
          expect(response).to render_template('index')
        
        end
      end

      # context '.admin' do
      #   it 'returns error ' do
      #     get posts_path

      #     expect(flash[:alert]).to eq('not allowed to index? this Post')
      #   end
      # end
    end

    context 'when not logged in' do

      context '.user' do
        let(:user) { create(:user, :user) }

        it 'redirects to login page' do
          get posts_path
          
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        
        end
      end

      context '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'redirects to login page' do
          get posts_path
          
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        
        end
      end
    end
  end

  describe '#create ' do
    let(:user) { create(:user, :user)}
    let(:payload) do
      {
        post: {
          title: Faker::Lorem.word,
          body: Faker::Lorem.word,
          user_id: user.id
        }
      }
    end

    context 'when logged in' do
      before do
        sign_in(user)
      end

      context '.user' do
        let(:user) { create(:user, :user) }

        context 'when params are present' do
          it 'redirect to created post' do
            post posts_path(payload)
            
            expect(flash[:notice]).to eq('Post is successfully  created')
          end
        end

        context 'when params are missing' do
          context 'when title is missing or nil' do

            it 'returns error' do
              payload[:post][:title] = nil
              post posts_path(payload)
            
              expect(flash[:notice]).to eq("Title can't be blank")
            end
          end
          context 'when body is blank or nil ' do
            it 'returns error' do
              payload[:post][:body] = nil
              post posts_path(payload)
            
              expect(flash[:notice]).to eq("Body can't be blank")
            end
          end
        end
      end

      context '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'returns error' do
          post posts_path(payload)
          
          expect(flash[:alert]).to eq('not allowed to create? this Post')
        end
      end

      context '.admin' do
        let(:user) { create(:user, :admin) }

        it 'returns error' do
          post posts_path(payload)
          expect(flash[:alert]).to eq('not allowed to create? this Post')
        end
      end
    end

    context 'when not logged in' do

      context '.user' do
        let(:user) { create(:user, :user) }

        it 'redirect to login page' do
          post posts_path(payload)
          
          expect(response).to redirect_to new_user_session_path
        end
      end

      context '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'redirect to login page' do
          post posts_path(payload)
          
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end

  describe '#destroy ' do
    context 'when logged in' do
      before do
        sign_in(user)
      end
      let(:user1) { create(:user, :user) }
      let(:post1) { create(:post, user_id: user1.id) }
      context '.user' do
        let(:user) { create(:user, :user) }
        let(:post) { create(:post, user_id: user.id) }
        
        context "is owner of post" do
        
          it 'should delete post' do
            delete post_path(post)
            
            expect(flash[:notice]).to eq('Post is successfully  deleted')
            expect(response).to redirect_to posts_path
          end
        end
        
        context "is not owner of post" do
          
          it 'returns error' do
            delete post_path(post1)
            
            expect(flash[:alert]).to eq('not allowed to destroy? this Post')
          end
        
        end
        
        context "post not found" do
          it 'returns error' do
            delete post_path(0)
            
            expect(flash[:alert]).to eq('This post does not exists')
          end
        end
      end

      context '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'should delete post' do 
          delete post_path(post1)
          
          expect(flash[:notice]).to eq('Post is successfully  deleted')
          expect(response).to redirect_to posts_path
        end
      end
    end

    context 'when not logged in' do

      context '.user' do
        let(:user) { create(:user, :user) }
        let(:post) { create(:post, user_id: user.id) }

        it 'redirect to login page' do
          delete post_path(post.id)
          
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context '.moderator' do
        let(:user) { create(:user, :moderator) }
        let(:post) { create(:post, :publish, user_id: user.id) }

        it 'redirect to login page' do
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

    context 'when logged in' do
      before do
        sign_in(user)
      end

      context '.user' do
        let(:user) { create(:user, :user) }
        let(:post) { create(:post, user_id: user.id) }
        let(:user1) { create(:user, :user) }

        it 'redirect to updated post' do
          get post_path(post.id)
          patch post_path(payload)
          
          expect(response).to redirect_to post_path(post.id)
          expect(flash[:notice]).to eq('Post is successfully  updated')
        end
        context "when body is null" do
          it 'returns error' do
            payload[:post][:body] = nil
            get post_path(post.id)
            patch post_path(payload)
            
            expect(flash[:notice]).to eq("Body can't be blank")
          end
        end
        context "when body is null" do
          it 'returns error' do
            payload[:post][:title] = nil
            get post_path(post.id)
            patch post_path(payload)
            
            expect(flash[:notice]).to eq("Title can't be blank")
          end
        end
      end

      context '.moderator' do
        let(:user) { create(:user, :moderator) }
        let(:post) { create(:post, :unpublish, user_id: user.id) }
        let(:post1) { create(:post, :publish, user_id: user.id) }

        context "when post is unpublished" do

          it 'redirect to updated post' do
            get post_path(post.id)
            patch post_path(payload)
            
            expect(response).to redirect_to post_path(post.id)
            expect(flash[:notice]).to eq('Post is successfully  updated')
          end

        end
        context "when post is published" do

          it 'redirect to updated post' do
            get post_path(post1.id)
            patch post_path(payload)
            
            expect(response).to redirect_to post_path(post1.id)
            expect(flash[:notice]).to eq('Post is successfully  updated')
          end
        end
      end
    end

    context 'when not logged in' do

      context '.user' do
        let(:user) { create(:user, :user) }
        let(:post) { create(:post, user_id: user.id) }

        it 'redirect to login page' do
          get post_path(post.id)
          patch post_path(payload)
          
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end
    end
  end
end












