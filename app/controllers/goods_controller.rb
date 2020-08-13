class GoodsController < ApplicationController
  def index
    @goods = Good.all
  end

  def new
    @good = Good.new
  end

  def create
    good = Good.new(good_params)
    if good.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @good = Good.find(params[:id])
  end

  def purchase
    good = Good.find(params[:id])
    Payjp.api_key = PAYJP_SECRET_KEY
    Payjp::Charge.create(currency: 'jpy', amount: good.price, card: params['payjp-token'])
    redirect_to root_path, notice: "支払いが完了しました"
  end

  private

  def good_params
    params.require(:good).permit(:name, :image, :price, :count, :description)
  end

end
