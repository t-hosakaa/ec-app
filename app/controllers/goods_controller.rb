class GoodsController < ApplicationController
  def index
    @goods = Good.all
  end

  def new
    @good = Good.new
  end

  def create
    good = Good.new(good_params)
    good.save
  end

  private

  def good_params
    params.require(:good).permit(:name, :image, :price, :count, :description)
  end

end
