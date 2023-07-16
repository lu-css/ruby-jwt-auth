# frozen_string_literal: true

require './app/models/product_model'
require './app/repositories/product_repository'
require './app/adapters/validation/product/index'

module Product
  class Update
    def initialize(product_id:, params:, product_model: ProductModel, product_repository: ProductRepository)
      @product_id = product_id
      @params = params
      @product_model = product_model
      @product_repository = product_repository
    end

    def call
      # TODO: Add changeset
      err_msg = ProductValidation::Create.new(params: @params).call
      return err_msg unless err_msg.empty?

      product = Product::Select.new.by_id(@product_id)
      product.update(@params)

      # new_stock = @product.stock_quantity - @quantity
      # @product_repository.update(@product.id, { stock_quantity: new_stock })

      product
    end
  end
end
