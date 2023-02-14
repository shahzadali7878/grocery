# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Categories', type: :request do
  let!(:category) { create(:category) }

  let(:valid_category)   { build(:category) }
  let(:invalid_category) { build(:category, :without_name) }

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_categories_path

      expect(response).to be_successful
      expect(response).to render_template('index')
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      it 'creates a new Category' do
        expect {
          post api_v1_categories_path, params: { category: valid_category.attributes.to_h }
        }.to change(Category, :count).by(1)
        expect(response).to render_template('show')
        expect(JSON.parse(response.body).keys).to include('id')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new Category' do
        expect {
          post api_v1_categories_path, params: { category: invalid_category.attributes.to_h }
        }.to change(Category, :count).by(0)
        expect(JSON.parse(response.body).keys).to include('errors')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid attributes' do
      let(:new_attributes) { { name: 'updated name' } }

      it 'updates the category attributes' do
        patch api_v1_category_path(category), params: { category: new_attributes }

        category.reload
        expect(response).to render_template('show')
        expect(JSON.parse(response.body)['name']).to eq('updated name')
      end
    end

    context 'with invalid attributes' do
      let(:new_attributes) { { name: '' } }

      it 'does not updates the category attributes' do
        patch api_v1_category_path(category), params: { category: new_attributes }

        category.reload
        expect(category.name).to_not eq('')
        expect(JSON.parse(response.body).keys).to include('errors')
      end
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_v1_category_path(category)

      expect(response).to be_successful
      expect(response).to render_template('show')
    end
  end

  describe 'DELETE /destroy' do
    context 'with no dependent sub_categories' do
      it 'destroys the category' do
        expect {
          delete api_v1_category_path(category)
        }.to change(Category, :count).by(-1)
      end
    end

    context 'with dependent sub_categories' do
      let!(:sub_category) { create(:sub_category, category: category) }

      it 'destroys the category and dependent sub_categories' do
        expect {
          delete api_v1_category_path(category)
        }.to  change(Category,    :count).by(-1)
         .and change(SubCategory, :count).by(-1)
      end
    end
  end
end
