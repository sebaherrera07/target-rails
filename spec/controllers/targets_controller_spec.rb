require 'rails_helper'

RSpec.describe TargetsController do
  describe 'POST create' do
    let(:params) { { target: attributes_for(:target) } }

    it 'renders index' do
      post :create, params: params
      expect(response).to render_template('index')
    end

    it 'creates a target' do
      expect do
        post :create, params: params
      end.to change(Target, :count).by(1)
    end

    it 'shows success flash' do
      post :create, params: params
      expect(flash[:success]).to match(I18n.t(:alert_success_target_created))
    end

    context 'when input form incomplete' do
      let(:params) { { target: attributes_for(:target, title: nil) } }

      it 'does not create a target' do
        expect do
          post :create, params: params
        end.not_to change(Target, :count)
      end

      it 'shows error flash' do
        post :create, params: params
        expect(flash[:error]).to match(I18n.t(:alert_error_target_data_incomplete))
      end
    end

    context 'when no map marker' do
      let(:params) { { target: attributes_for(:target, latitude: nil, longitude: nil) } }

      it 'does not create a target' do
        expect do
          post :create, params: params
        end.not_to change(Target, :count)
      end

      it 'shows error flash' do
        post :create, params: params
        expect(flash[:error]).to match(I18n.t(:alert_error_target_not_set))
      end
    end
  end
end
