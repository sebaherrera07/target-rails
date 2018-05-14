require 'rails_helper'

RSpec.describe TargetsController do
  describe 'POST create' do
    let(:params) { { target: attributes_for(:target) } }

    it 'creates a target' do
      expect do
        post :create, params: params, as: :json
      end.to change(Target, :count).by(1)
    end

    it 'returns success' do
      post :create, params: params, as: :json
      expect(response).to be_successful
    end

    it 'returns the target as json' do
      post :create, params: params, as: :json
      target_json = JSON.parse(response.body)
      expect(target_json['target']['title']).to eq(params[:target][:title])
      expect(target_json['target']['size']).to eq(params[:target][:size])
      expect(target_json['target']['topic']).to eq(params[:target][:topic])
      expect(target_json['target']['latitude']).to eq(params[:target][:latitude])
      expect(target_json['target']['longitude']).to eq(params[:target][:longitude])
    end

    context 'when input form incomplete' do
      let(:params) { { target: attributes_for(:target, title: nil) } }

      it 'does not create a target' do
        expect do
          post :create, params: params, as: :json
        end.not_to change(Target, :count)
      end

      it 'returns http error code' do
        post :create, params: params, as: :json
        expect(response).to have_http_status(422)
      end

      it 'returns the errors as json' do
        post :create, params: params, as: :json
        errors_json = JSON.parse(response.body)
        expect(errors_json['errors']['title'].length).to be(1)
      end
    end

    context 'when no map marker' do
      let(:params) { { target: attributes_for(:target, latitude: nil, longitude: nil) } }

      it 'does not create a target' do
        expect do
          post :create, params: params, as: :json
        end.not_to change(Target, :count)
      end

      it 'returns http error code' do
        post :create, params: params, as: :json
        expect(response).to have_http_status(422)
      end

      it 'returns the errors as json' do
        post :create, params: params, as: :json
        errors_json = JSON.parse(response.body)
        expect(errors_json['errors']['latitude'].length).to be(1)
        expect(errors_json['errors']['longitude'].length).to be(1)
      end
    end
  end

  describe 'GET index' do
    it 'assigns @targets' do
      targets = Target.all
      get :index
      expect(assigns(:targets)).to eq(targets)
    end
  end
end
