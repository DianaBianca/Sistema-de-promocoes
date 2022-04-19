# frozen_string_literal: true

class CouponsController < ApplicationController
  before_action :find_coupon

  def inactivate
    @coupon.inactive!
    change_coupon_status
  end

  def activate
    @coupon.active!
    change_coupon_status
  end

  private

  def find_coupon
    @coupon = Coupon.find(params[:id])
  end

  def change_coupon_status
    flash[:notice] = t('.success')
    redirect_to @coupon.promotion
  end
end
