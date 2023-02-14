# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  let!(:color_1) { create(:color) }
  let!(:color_2) { create(:color) }

  let!(:size_1) { create(:size) }
  let!(:size_2) { create(:size) }

  let!(:category)     { create(:category) }
  let!(:sub_category) { create(:sub_category, category: category) }
  let!(:product)      { create(:product, sub_category: sub_category) }

  let(:valid_product)   { build(:product) }
  let(:invalid_product) { build(:product, :without_name) }

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_category_sub_category_products_path(category, sub_category)

      expect(response).to be_successful
      expect(response).to render_template('index')
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      let(:product_params) {
        valid_product.attributes.to_h.merge(
          color_ids: [color_1.id, color_2.id],
          size_ids:  [size_1.id, size_2.id]
        )
      }

      it 'creates a new Product' do
        expect {
          post api_v1_category_sub_category_products_path(
            category, sub_category
          ), params: { product: product_params }
        }.to change(Product,       :count).by(1)
         .and change(ProductColor, :count).by(2)
         .and change(ProductSize,  :count).by(2)
        expect(response).to render_template('show')

        parsed_response = JSON.parse(response.body)
        expect(parsed_response.keys).to include('id')
        expect(parsed_response['colors'].count).to eq(2)
        expect(parsed_response['sizes'].count).to  eq(2)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new Product' do
        expect {
          post api_v1_category_sub_category_products_path(category, sub_category),
               params: { product: invalid_product.attributes.to_h }
        }.to change(Product, :count).by(0)
        expect(JSON.parse(response.body).keys).to include('errors')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid attributes' do
      let(:new_attributes) { { name: 'updated name' } }

      it 'updates the product attributes' do
        patch api_v1_category_sub_category_product_path(category, sub_category, product),
              params: { product: new_attributes }

        product.reload
        expect(response).to render_template('show')
        expect(JSON.parse(response.body)['name']).to eq('updated name')
      end
    end

    context 'with invalid attributes' do
      let(:new_attributes) { { name: '' } }

      it 'does not updates the product attributes' do
        patch api_v1_category_sub_category_product_path(category, sub_category, product),
              params: { product: new_attributes }

        product.reload
        expect(product.name).to_not eq('')
        expect(JSON.parse(response.body).keys).to include('errors')
      end
    end

    context 'add or remove colors' do
      let(:color_3) { create(:color) }

      it 'updates the color references' do
        patch api_v1_category_sub_category_product_path(category, sub_category, product),
              params: { product: { color_ids: [color_1.id, color_3.id] } }

        product.reload
        expect(response).to render_template('show')
        expect(product.colors.ids).to     include(color_1.id)
        expect(product.colors.ids).to_not include(color_2.id)
        expect(product.colors.ids).to     include(color_3.id)
      end
    end

    context 'add or remove sizes' do
      let(:size_3) { create(:size) }

      it 'updates the size references' do
        patch api_v1_category_sub_category_product_path(category, sub_category, product),
              params: { product: { size_ids: [size_1.id, size_3.id] } }

        product.reload
        expect(response).to render_template('show')
        expect(product.sizes.ids).to     include(size_1.id)
        expect(product.sizes.ids).to_not include(size_2.id)
        expect(product.sizes.ids).to     include(size_3.id)
      end
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_v1_category_sub_category_product_path(category, sub_category, product)

      expect(response).to be_successful
      expect(response).to render_template('show')
    end
  end

  describe 'DELETE /destroy' do
    context 'with no dependent colors and sizes' do
      it 'destroys the product' do
        expect {
          delete api_v1_category_sub_category_product_path(category, sub_category, product)
        }.to change(Product, :count).by(-1)
      end
    end

    context 'with dependent colors and sizes' do
      it 'destroys the product and references to colors and sizes' do
        product.colors << color_1
        product.sizes  << size_1

        expect {
          delete api_v1_category_sub_category_product_path(category, sub_category, product)
        }.to change(Product,       :count).by(-1)
         .and change(ProductColor, :count).by(-1)
         .and change(ProductSize,  :count).by(-1)
      end
    end
  end
end
