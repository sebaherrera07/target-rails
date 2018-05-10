require 'rails_helper'

RSpec.describe TargetsController do
  describe 'POST create' do
    let(:title) { 'Test TargetsController RSpec' }
    let(:topic) { 'Food' }
    let(:size) { 250 }
    let(:latitude) { -35.9067557 }
    let(:longitude) { -57.2006151 }

    let(:params) do
      {
        target: {
          title: title,
          topic: topic,
          size: size,
          latitude: latitude,
          longitude: longitude
        }
      }
    end

    it 'renders index' do
      post :create, params: params
      expect(response).to render_template('index')
    end

    it 'creates a target' do
      expect do
        post :create, params: params
      end.to change(Target, :count).by(1)
    end

    it 'shows a success flash' do
      post :create, params: params
      expect(flash[:success]).to match(I18n.t(:alert_success_target_created))
    end

    context 'when input form incomplete' do
      let(:title) {}
      let(:topic) { 'Food' }
      let(:size) { 250 }
      let(:latitude) { -35.9067557 }
      let(:longitude) { -57.2006151 }

      let(:params) do
        {
          target: {
            title: title,
            topic: topic,
            size: size,
            latitude: latitude,
            longitude: longitude
          }
        }
      end

      it 'does not create a target' do
        expect do
          post :create, params: params
        end.not_to change(Target, :count)
      end

      it 'shows a error flash' do
        post :create, params: params
        expect(flash[:error]).to match(I18n.t(:alert_error_target_data_incomplete))
      end
    end
  end

  context 'when no map marker' do
    let(:title) { 'Test TargetsController RSpec' }
    let(:topic) { 'Food' }
    let(:size) { 250 }
    let(:latitude) {}
    let(:longitude) {}

    let(:params) do
      {
        target: {
          title: title,
          topic: topic,
          size: size,
          latitude: latitude,
          longitude: longitude
        }
      }
    end

    it 'does not create a target' do
      expect do
        post :create, params: params
      end.not_to change(Target, :count)
    end

    it 'shows a error flash' do
      post :create, params: params
      expect(flash[:error]).to match(I18n.t(:alert_error_target_not_set))
    end
  end
end
