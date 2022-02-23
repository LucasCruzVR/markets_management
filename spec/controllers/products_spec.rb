require 'rails_helper'

RSpec.describe 'Products route', type: :request do
  describe 'GET /api/v1/products INDEX' do
    context 'When there are data' do
      context 'When there are not search' do
        it 'Return all data' do
          5.times do
            FactoryBot.create(:products)
          end
          get '/api/v1/products'

          expect_json_keys('results.*', %i[id name category barcode])
          expect(response).to have_http_status(200)
          expect(json_body[:results].length).to eq(5)
        end
      end

      context 'When there are seach by name' do
        it 'Return data that match with search' do
          5.times do
            FactoryBot.create(:products)
          end
          product = FactoryBot.create(:products)
          get '/api/v1/products', params: { name: product.name }

          expect(response).to have_http_status(200)
          expect(json_body[:results].length).to eq(1)
          expect(json_body[:results].first[:id]).to eq(product.id)
        end
      end
    end

    context 'When there are not data to show' do
      it 'Return Results array empty' do
        get '/api/v1/products'

        expect(response).to have_http_status(200)
        expect(json_body[:results].length).to eq(0)
      end
    end
  end

  describe 'GET /api/v1/products/:id SHOW' do
    context 'When data exists' do
      it 'Return data' do
        product = FactoryBot.create(:products)
        get "/api/v1/products/#{product.id}"

        expect(response).to have_http_status(200)
        expect_json_keys('', %i[id name category barcode])
        expect_json(id: product.id, name: product.name, category: product.category, barcode: product.barcode)
      end
    end

    context 'When data doesnt exists' do
      it 'Return not found - 404' do
        get '/api/v1/products/0'

        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /api/v1/products CREATE' do
    context 'When pass valid data to save' do
      it 'Return data saved' do
        product = FactoryBot.build(:products)
        post '/api/v1/products', params: { name: product.name, category: product.category, barcode: product.barcode }

        expect(response).to have_http_status(201)
        expect_json(name: product.name, category: product.category, barcode: product.barcode)
      end
    end

    context 'When pass invalid data to save' do
      context 'When name already exists' do
        it 'Return 422' do
          product1 = FactoryBot.create(:products)
          product2 = FactoryBot.attributes_for(:products, name: product1.name)

          expect do
            post '/api/v1/products', params: product2
          end.to_not change { MarketsManagementApi::Models::Product.count }

          expect(response).to have_http_status(422)
        end
      end

      context 'When barcode number is invalid' do
        it 'Return 422' do
          product = FactoryBot.attributes_for(:products, barcode: '123')
          expect do
            post '/api/v1/products', params: product
          end.to_not change { MarketsManagementApi::Models::Product.count }

          expect(response).to have_http_status(422)
        end
      end
    end
  end

  describe 'PUT /api/v1/products/:id UPDATE' do
    context 'When data exists' do
      context 'When new data is valid to update old data' do
        it 'Update data and return 200' do
          product = FactoryBot.create(:products)
          put "/api/v1/products/#{product.id}", params: { name: 'New Product Name  ' }

          expect(response).to have_http_status(200)
          expect_json(id: product.id, name: 'New Product Name', category: product.category)
        end
      end

      context 'When new data is invalid' do
        it 'Doesnt update data and return 422' do
          product1 = FactoryBot.create(:products)
          product2 = FactoryBot.create(:products)
          put "/api/v1/products/#{product2.id}", params: { name: product1.name }

          expect(response).to have_http_status(422)
        end
      end
    end

    context 'When data doesnt exists' do
      it 'return 404 - not found' do
        put "/api/v1/products/#{0}", params: { name: 'new product name' }
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /api/v1/products/:id DESTROY' do
    context 'When id exists' do
      it 'Delete data and return status 200' do
        product = FactoryBot.create(:products)
        expect do
          delete "/api/v1/products/#{product.id}"
        end.to change { MarketsManagementApi::Models::Product.count }.by(-1)
      end
    end

    context 'When id doesnt exists' do
      it 'Return 422 error' do
        delete "/api/v1/products/#{0}"

        expect(response).to have_http_status(404)
      end
    end
  end
end
