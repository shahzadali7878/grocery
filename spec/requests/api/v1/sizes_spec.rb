# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Sizes', type: :request do
  let!(:size) { create(:size) }

  let(:valid_size)   { build(:size) }
  let(:invalid_size) { build(:size, :without_name) }

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_sizes_path

      expect(response).to be_successful
      expect(response).to render_template('index')
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      it 'creates a new Size' do
        expect {
          post api_v1_sizes_path, params: { size: valid_size.attributes.to_h }
        }.to change(Size, :count).by(1)
        expect(response).to render_template('show')
        expect(JSON.parse(response.body).keys).to include('id')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new Size' do
        expect {
          post api_v1_sizes_path, params: { size: invalid_size.attributes.to_h }
        }.to change(Size, :count).by(0)
        expect(JSON.parse(response.body).keys).to include('errors')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid attributes' do
      let(:new_attributes) { { name: 'updated name' } }

      it 'updates the size attributes' do
        patch api_v1_size_path(size), params: { size: new_attributes }

        size.reload
        expect(size.name).to eq('updated name')
        expect(response).to render_template('show')
        expect(JSON.parse(response.body)['name']).to eq('updated name')
      end
    end

    context 'with invalid attributes' do
      let(:new_attributes) { { name: '' } }

      it 'does not updates the size attributes' do
        patch api_v1_size_path(size), params: { size: new_attributes }

        size.reload
        expect(size.name).to_not eq('')
        expect(JSON.parse(response.body).keys).to include('errors')
      end
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_v1_size_path(size)

      expect(response).to be_successful
      expect(response).to render_template('show')
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the size' do
      expect {
        delete api_v1_size_path(size)
      }.to change(Size, :count).by(-1)
    end
  end
end
