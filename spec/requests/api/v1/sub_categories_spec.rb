# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::SubCategories', type: :request do
  let!(:category)     { create(:category) }
  let!(:sub_category) { create(:sub_category, category: category) }

  let(:valid_sub_category)   { build(:sub_category) }
  let(:invalid_sub_category) { build(:sub_category, :without_name) }

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_category_sub_categories_path(category)

      expect(response).to be_successful
      expect(response).to render_template('index')
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      it 'creates a new SubCategory' do
        expect {
          post api_v1_category_sub_categories_path(category),
               params: { sub_category: valid_sub_category.attributes.to_h }
        }.to change(SubCategory, :count).by(1)
        expect(response).to render_template('show')
        expect(JSON.parse(response.body).keys).to include('id')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new SubCategory' do
        expect {
          post api_v1_category_sub_categories_path(category),
               params: { sub_category: invalid_sub_category.attributes.to_h }
        }.to change(SubCategory, :count).by(0)
        expect(JSON.parse(response.body).keys).to include('errors')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid attributes' do
      let(:new_attributes) { { name: 'updated name' } }

      it 'updates the sub_category attributes' do
        patch api_v1_category_sub_category_path(category, sub_category),
              params: { sub_category: new_attributes }

        sub_category.reload
        expect(sub_category.name).to eq('updated name')
        expect(response).to render_template('show')
        expect(JSON.parse(response.body)['name']).to eq('updated name')
      end
    end

    context 'with invalid attributes' do
      let(:new_attributes) { { name: '' } }

      it 'does not updates the sub_category attributes' do
        patch api_v1_category_sub_category_path(category, sub_category),
              params: { sub_category: new_attributes }

        sub_category.reload
        expect(sub_category.name).to_not eq('')
        expect(JSON.parse(response.body).keys).to include('errors')
      end
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_v1_category_sub_category_path(category, sub_category)

      expect(response).to be_successful
      expect(response).to render_template('show')
    end
  end

  describe 'DELETE /destroy' do
    context 'with no products' do
      it 'destroys the sub_category' do
        expect {
          delete api_v1_category_sub_category_path(category, sub_category)
        }.to change(SubCategory, :count).by(-1)
      end
    end

    context 'with products' do
      let!(:product) { create(:product, sub_category: sub_category) }

      it 'destroys the sub_category and dependent products' do
        expect {
          delete api_v1_category_sub_category_path(category, sub_category)
        }.to  change(SubCategory, :count).by(-1)
         .and change(Product,     :count).by(-1)
      end
    end
  end
end
