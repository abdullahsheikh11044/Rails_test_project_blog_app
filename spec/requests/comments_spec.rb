# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  describe '#create ' do
    let(:ali) { FactoryBot.create(:user) }
    let(:ali_post) { FactoryBot.create(:post, user_id: ali.id) }
    let(:comment) { FactoryBot.create(:comment, id: ali_post.id, user_id: ali.id) }

    let(:payload) do
      {
        comment: {
          comment: Faker::Lorem.word,
          user_id: ali.id
        },
        post_id: ali_post.id
      }
    end

    context 'when user is signed in' do
      before do
        sign_in(user)
      end

      describe '.user' do
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

      describe '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'render created comment' do
          post post_comments_path(payload)
          expect(response).to redirect_to post_path(ali_post.id)
        end
      end

      describe '.admin' do
        let(:user) { create(:user, :admin) }

        it 'render created comment' do
          post post_comments_path(payload)
          expect(response).to redirect_to post_path(ali_post.id)
        end
      end
    end

    context 'when user is signed out' do
      before do
        sign_out(user)
      end

      describe '.user' do
        let(:user) { create(:user, :user) }

        it 'render created comment' do
          post post_comments_path(payload)
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      describe '.moderator' do
        let(:user) { create(:user, :moderator) }

        it 'render created comment' do
          post post_comments_path(payload)
          expect(response).to redirect_to new_user_session_path
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end
      end

      describe '.admin' do
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
