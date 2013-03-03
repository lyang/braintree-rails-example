class PlansController < ApplicationController
  def index
    @plans = BraintreeRails::Plan.all
  end

  def show
    @plan = BraintreeRails::Plan.find(params[:id])
  end
end
