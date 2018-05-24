require 'rails_helper'

RSpec.describe Users::RegistrationsController do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST create' do
    let(:params) { { user: attributes_for(:user) } }

    it 'creates a user' do
      expect do
        post :create, params: params
      end.to change(User, :count).by(1)
    end

    it 'displays success message' do
      post :create, params: params
      expect(flash['notice']).to eq(
        I18n.t(:signed_up_but_unconfirmed, scope: %i[devise registrations])
      )
    end

    context 'when form incomplete' do
      let(:params) { { user: attributes_for(:user, name: nil) } }

      it 'does not create a user' do
        expect do
          post :create, params: params
        end.not_to change(User, :count)
      end
    end

    context 'when password too short' do
      let(:params) do
        { user: attributes_for(:user, password: '12345', password_confirmation: '12345') }
      end

      it 'does not create a user' do
        expect do
          post :create, params: params
        end.not_to change(User, :count)
      end
    end

    context 'when password confirmation not equal' do
      let(:params) do
        { user: attributes_for(:user, password: '123456', password_confirmation: '123457') }
      end

      it 'does not create a user' do
        expect do
          post :create, params: params
        end.not_to change(User, :count)
      end
    end

    context 'when email invalid format' do
      let(:params) { { user: attributes_for(:user, email: 'username.com') } }

      it 'does not create a user' do
        expect do
          post :create, params: params
        end.not_to change(User, :count)
      end
    end
  end
end
