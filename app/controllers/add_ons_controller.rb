class AddOnsController < ApplicationController
  def index
    @add_ons = BraintreeRails::AddOn.all
  end

  def show
    @add_on = BraintreeRails::AddOn.find(params[:id])
  end
end
