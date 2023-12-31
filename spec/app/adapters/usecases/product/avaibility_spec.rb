# frozen_string_literal: true

require './spec/spec_helper'

require './app/adapters/usecases/product/index'
require './app/models/product_model'
require './app/repositories/product_repository'

RSpec.describe Product do
  let(:valid_product_infos) do
    {
      name: 'Cafeteria',
      description: 'Faz cafe e muito mais coisas',
      category: 'eletronic',
      price: 122.5,
      stock_quantity: 5
    }
  end

  let(:new_infos) do
    {
      name: 'A feira do ovo',
      description: 'Faz cafe e muito mais coisas',
      category: 'eletronic',
      price: 122.5,
      stock_quantity: 5
    }
  end

  context 'With disable product' do
    it 'Disable a product' do
      product = Product::Create.new(params: valid_product_infos).call

      expect(product.avaible).to eq(true)

      Product::Avaibility.new(product_id: product.id).disable

      expect(product.class).to be(ProductRepository)

      new_product = Product::Select.new.with_adm.by_id(product.id)
      expect(new_product.avaible).to eq(false)
    end

    it 'Active a product' do
      p = Product::Create.new(params: valid_product_infos).call
      Product::Avaibility.new(product_id: p.id).disable
      product = Product::Select.new.with_adm.by_id(p.id)

      expect(product.avaible).to eq(false)

      Product::Avaibility.new(product_id: product.id).active

      product = Product::Select.new.with_adm.by_id(p.id)

      expect(product.class).to be(ProductRepository)

      new_product = Product::Select.new.with_adm.by_id(product.id)
      expect(new_product.avaible).to eq(true)
    end
  end
end
