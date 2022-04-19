# frozen_string_literal: true

class PromotionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_promotion_params, only: %i[edit show update generate_coupons destroy]

  def index; end
  def show; end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to @promotion
    else
      render :new
    end
  end

  def edit; end

  def update
    @promotion.update!(promotion_params)
    redirect_to promotion_path(@promotion.id), notice: 'Edição realizada com sucesso'
  rescue StandardError
    redirect_to edit_promotion_path(@promotion.id), alert: 'Ops, houve algum problema! Verifique os campos'
  end

  def destroy
    @promotion.destroy
    redirect_to promotions_path, notice: 'Promoção excluida com sucesso', status: :see_other
  end

  def generate_coupons
    @promotion.generate_coupons!
    flash[:success] = 'Cupons gerados com sucesso'
    redirect_to @promotion
  end

  def details
    @coupon = Coupon.find_by(code: params[:coupon_code])

    if @coupon.nil?
      redirect_to promotions_path, alert: 'Este cupom não existe'
    else
      @promotion = Promotion.find_by(coupons: @coupon)
      redirect_to promotion_path(@promotion), alert: 'Este cupom pertence a esta promoção'
    end
  end

  private

  def set_promotion_params
    @promotion = Promotion.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to promotions_path
  end

  def promotion_params
    params
      .require(:promotion)
      .permit(:name, :description, :code,
              :discount_rate, :expiration_date, :coupon_quantity,
              product_category_ids: [])
  end
end
