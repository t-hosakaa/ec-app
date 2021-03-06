class GoodsController < ApplicationController

  before_action :nologin_user, only: [:new, :create]

  def index
    @goods = Good.all
  end

  def new
    @good = Good.new
  end

  def create
    @good = Good.new(good_params)
    if @good.save
      redirect_to root_path
      flash[:notice] = "商品を登録しました"
    else
      flash[:alert] = "商品登録に失敗しました"
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

  def search
    @goods = Good.search(params[:keyword])
    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def good_params
    params.require(:good).permit(:name, :image, :price, :count, :description)
  end

end
