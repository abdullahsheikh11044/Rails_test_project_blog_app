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
