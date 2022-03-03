require 'rails_helper'

RSpec.describe 'Markets routes', type: :request do
  describe 'GET /api/v1/markets INDEX' do
    context 'When doesnt exist data' do
      it 'Return empty array' do
        get '/api/v1/markets'

        expect(response).to have_http_status(200)
        expect(json_body[:results].length).to eq(0)
      end
    end

    context 'When exists data' do
      before(:each) do
        @markets = []
        5.times do
          @markets << FactoryBot.create(:markets)
        end
      end
      context 'When do a request without a search' do
        it 'Return all data' do
          get '/api/v1/markets'

          expect(response).to have_http_status(200)
          expect(json_body[:results].length).to eq(5)
          expect_json_keys('results.*', %i[id name phone address])
        end
      end

      context 'When search for a name' do
        it 'Return all data containing that name' do
          get '/api/v1/markets', params: { name: @markets.first.name }

          expect(response).to have_http_status(200)
          expect(json_body[:results].length).to eq(1)
          expect_json_keys('results.*', %i[id name phone address])
        end
      end
    end
  end

  describe 'GET /api/v1/markets/:id SHOW' do
    context 'When data doesnt exist' do
      it 'Return 404 - not found' do
        get '/api/v1/markets/0'

        expect(response).to have_http_status(404)
      end
    end

    context 'When data exists' do
      it 'Return data information' do
        market_product = FactoryBot.create(:markets_products)
        get "/api/v1/markets/#{market_product.market.id}"

        expect(response).to have_http_status(200)
        expect_json_keys(%i[id name phone address])
        expect_json_keys('products.*', %i[id name category barcode price])
      end
    end
  end

  describe 'POST /api/v1/markets CREATE' do
    context 'When exists invalid data' do
      it 'Return 422 error' do
        market_product = FactoryBot.create(:markets_products)
        market = FactoryBot.attributes_for(:markets, markets_products_attributes: [
                                             product_id: market_product.product.id, price: 20.0
                                           ], name: '')
        expect do
          post '/api/v1/markets', params: market
        end.to_not change { MarketsManagementApi::Models::Market.count }
        expect(response).to have_http_status(422)
      end
    end

    context 'When data are valid' do
      it 'Save and return data' do
        market_product = FactoryBot.create(:markets_products)
        market = FactoryBot.attributes_for(:markets, markets_products_attributes: [
                                             product_id: market_product.product.id, price: 20.0
                                           ])
        post '/api/v1/markets', params: market
        expect(response).to have_http_status(201)
        expect_json(name: market[:name], phone: market[:phone].to_s, address: market[:address],
                    products: [id: market_product.product.id, name: market_product.product.name,
                               category: market_product.product.category, barcode: market_product.product.barcode.to_s,
                               price: market[:markets_products_attributes].first[:price].to_s])
      end
    end
  end

  describe 'PUT /api/v1/markets/:id UPDATE' do
    context 'When data doesnt exist' do
      it 'Return 404 - not found' do
        put '/api/v1/markets/0', params: { name: 'cia' }
        expect(response).to have_http_status(404)
      end
    end

    context 'When data exists' do
      context 'When params are valid' do
        it 'Save and return data' do
          market = FactoryBot.create(:markets)
          put "/api/v1/markets/#{market.id}", params: { name: 'new name' }
          expect(response).to have_http_status(200)
          expect(json_body[:name]).to eq('new name')
        end
      end

      context 'When param is invalid' do
        it 'Return 422 error' do
          market = FactoryBot.create(:markets)
          put "/api/v1/markets/#{market.id}", params: { name: '' }
          expect(response).to have_http_status(422)
        end
      end
    end
  end

  describe 'DELETE /api/v1/markets/:id DESTROY' do
    context 'When data exists' do
      it 'Return 200 and exclude data' do
        market = FactoryBot.create(:markets)
        expect do
          delete "/api/v1/markets/#{market.id}"
        end.to change { MarketsManagementApi::Models::Market.count }.by(-1)
        expect(response).to have_http_status(200)
      end
    end

    context 'When data doesnt exist' do
      it 'Return 404 - not found' do
        delete '/api/v1/markets/0'
        expect(response).to have_http_status(404)
      end
    end
  end
end
