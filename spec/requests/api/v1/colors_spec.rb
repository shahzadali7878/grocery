# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Colors', type: :request do
  let!(:color) { create(:color) }

  let(:valid_color)   { build(:color) }
  let(:invalid_color) { build(:color, :without_name) }

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_colors_path

      expect(response).to be_successful
      expect(response).to render_template('index')
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      it 'creates a new Color' do
        expect {
          post api_v1_colors_path, params: { color: valid_color.attributes.to_h }
        }.to change(Color, :count).by(1)
        expect(response).to render_template('show')
        expect(JSON.parse(response.body).keys).to include('id')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new Color' do
        expect {
          post api_v1_colors_path, params: { color: invalid_color.attributes.to_h }
        }.to change(Color, :count).by(0)
        expect(JSON.parse(response.body).keys).to include('errors')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid attributes' do
      let(:new_attributes) { { name: 'updated name' } }

      it 'updates the color attributes' do
        patch api_v1_color_path(color), params: { color: new_attributes }

        color.reload
        expect(color.name).to eq('updated name')
        expect(response).to render_template('show')
        expect(JSON.parse(response.body)['name']).to eq('updated name')
      end
    end

    context 'with invalid attributes' do
      let(:new_attributes) { { name: '' } }

      it 'does not updates the color attributes' do
        patch api_v1_color_path(color), params: { color: new_attributes }

        color.reload
        expect(color.name).to_not eq('')
        expect(JSON.parse(response.body).keys).to include('errors')
      end
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_v1_color_path(color)

      expect(response).to be_successful
      expect(response).to render_template('show')
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the color' do
      expect {
        delete api_v1_color_path(color)
      }.to change(Color, :count).by(-1)
    end
  end
end
