require 'rails_helper'

RSpec.describe TargetsController do
  describe 'POST create' do
    let(:params) { { target: attributes_for(:target) } }

    before(:each) do
      post :create, params: params, as: :json
    end

    it 'creates a target' do
      expect do
        post :create, params: params, as: :json
      end.to change(Target, :count).by(1)
    end

    it 'returns success' do
      expect(response).to be_successful
    end

    it 'returns the target as json' do
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
        expect(response).to have_http_status(422)
      end

      it 'returns the errors as json' do
        errors_json = JSON.parse(response.body)
        expect(errors_json['errors']['title']).to be_present
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
        expect(response).to have_http_status(422)
      end

      it 'returns the errors as json' do
        errors_json = JSON.parse(response.body)
        expect(errors_json['errors']['latitude'].length).to be_present
        expect(errors_json['errors']['longitude'].length).to be_present
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

  describe 'GET topic_icon' do
    it 'returns correct icon for Sports' do
      get :topic_icon, params: { topic: I18n.t(:topics_sports) }, as: :json
      icon_json = JSON.parse(response.body)
      expect(icon_json['icon']).to eq('sports-icon.png')
    end

    it 'returns correct icon for Movies' do
      get :topic_icon, params: { topic: I18n.t(:topics_movies) }, as: :json
      icon_json = JSON.parse(response.body)
      expect(icon_json['icon']).to eq('movies-icon.png')
    end
  end
end
