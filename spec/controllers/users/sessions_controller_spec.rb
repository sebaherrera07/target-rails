require 'rails_helper'

RSpec.describe Users::SessionsController do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  let(:email) { Faker::Internet.unique.email }
  let(:password) { 'password' }
  let!(:user) do
    FactoryBot.create(:user, email: email, password: password, password_confirmation: password)
  end
  let(:params) { { user: { email: email, password: password } } }

  describe 'POST sign_in' do
    it 'has a current_user' do
      post :create, params: params
      expect(subject.current_user.email).to eq(email)
    end

    context 'when invalid user' do
      let(:params) { { user: attributes_for(:user) } }

      it 'does not have a current_user' do
        post :create, params: params
        expect(subject.current_user).to eq(nil)
      end

      it 'displays error message' do
        post :create, params: params
        expect(flash['alert']).to eq(
          I18n.t(:not_found_in_database, scope: %i[devise failure], authentication_keys: 'Email')
        )
      end
    end
  end

  describe 'DELETE sign_out' do
    it 'does not have a current_user' do
      post :create, params: params
      delete :destroy
      expect(subject.current_user).to eq(nil)
    end
  end
end
