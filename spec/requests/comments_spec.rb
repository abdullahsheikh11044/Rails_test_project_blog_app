# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  describe '#create ' do
    let(:ali) { create(:user, :user) }
    let(:ali_post) { create(:post, user_id: ali.id) }
    let(:comment) { create(:comment, id: ali_post.id, user_id: ali.id) }

    let(:payload) do
      {
        comment: {
          comment: Faker::Lorem.word,
          user_id: ali.id
        },
        post_id: ali_post.id
      }
    end

    context 'when logged in' do
      before do
        sign_in(user)
      end

      context '.user' do
        let(:user) { create(:user, :user) }

        it 'render created comment' do
          post post_comments_path(payload)
          
          expect(response).to redirect_to post_path(ali_post.id)
        end

        it 'does not create comment when comment is blank' do
          payload[:comment][:comment] = nil

          post post_comments_path(payload), xhr: true
        end
      end

      context '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'render created comment' do
          post post_comments_path(payload)
          
          expect(response).to redirect_to post_path(ali_post.id)
        end
      end

      context '.admin' do
        let(:user) { create(:user, :admin) }

        it 'render created comment' do
          post post_comments_path(payload)
          
          expect(response).to redirect_to post_path(ali_post.id)
        end
      end
    end

    context 'when not logged in' do

      context '.user' do
        let(:user) { create(:user, :user) }

        it 'render created comment' do
          post post_comments_path(payload)
          
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      context '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'render created comment' do
          post post_comments_path(payload)
          
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      context '.admin' do
        let(:user) { create(:user, :admin) }

        it 'render created comment' do
          post post_comments_path(payload)
          
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end
    end
  end
end




















require 'rails_helper'
RSpec.describe 'Users', type: :request do
  describe 'index' do
    let(:user) { create(:user) }

    context 'when not logged in' do
      # context 'Redirect user to sign in path' do
        it 'redirect to login page' do
          sign_out(user)
          get users_path
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(user_session_path)
        end
      # end
    end
    context 'when logged in' do
      before do
        sign_in(user)
      end
      # context 'Check the 2 functions' do
        it 'render new' do
          get users_path
          expect(response).to have_http_status(:ok)
        end
      # end
      
    end
  end
  describe '#follower_index' do
    let(:user) { create(:user) }
    context 'when logged in' do
      before do
        sign_in(user)
      end
      context 'To check if the function is running' do
        it 'Success case' do
          get follower_index_user_path
          expect(response).to have_http_status(:ok)
        end
      end
      context 'when not logged in' do
                  it 'redirect to login page' do
            sign_out(user)
            get follower_index_user_path
            expect(response).to have_http_status(302)
            expect(response).to redirect_to(user_session_path)
          end
        # end
      end
    end
  end
  describe '#following_index  ' do
    let(:user) { create(:user) }
    context 'when logged in' do
      before do
        sign_in(user)
      end
      context 'Check if the function is running' do
        it 'Success case of following_index' do
          get following_index_user_path
          expect(response).to have_http_status(:ok)
        end
      end
      context 'when not logged in' do
        context 'Redirect user to sign in path' do
          it 'redirecting to login page' do
            sign_out(user)
            get following_index_user_path
            expect(response).to have_http_status(302)
            expect(response).to redirect_to(user_session_path)
          end
        end
      end
    end
  end
  describe '#profile  ' do
    let(:user) { create(:user) }
    context 'when logged in proceed further' do
      before do
        sign_in(user)
      end
      context 'Check if the method is running' do
        it 'Success case of Profile' do
          get profile_user_path(user)
          expect(response).to have_http_status(:ok)
        end
      end
      context 'when not logged in' do
        context 'Redirect to sign in path' do
          it 'redirecting to login page' do
            sign_out(user)
            get profile_user_path(user)
            expect(response).to have_http_status(302)
            expect(response).to redirect_to(user_session_path)
          end
        end
      end
    end
  end
  describe '#follow_user' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    context 'when logged in' do
      before do
        sign_in(user)
      end
      context 'user' do
        it 'render new' do
          params = { follower_id: user.id, following_id: user2.id }
          post follow_user_user_path(params)
          expect(response).to have_http_status(302)
        end
      end
    end
  end
end