class DiscountsController < ApplicationController
  def index
    @discounts = BraintreeRails::Discount.all
  end

  def show
    @discount = BraintreeRails::Discount.find(params[:id])
  end
end
