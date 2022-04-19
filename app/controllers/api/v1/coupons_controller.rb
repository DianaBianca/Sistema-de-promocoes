# frozen_string_literal: true

module Api
  module V1
    class CouponsController < ActionController::API
      before_action :find_coupon

      def show
        render json: { code: @coupon.code, actual_status: @coupon.status, coupon_info: @coupon }, status: :ok
      end

      def burn
        if @coupon.can_be_burned?
          @coupon.burn!
          render json: infos_to_formatter('Cupom queimado com sucesso', @coupon.code, @coupon.status), status: :ok
        else
          render json: infos_to_formatter('Cupom não pode ser queimado', @coupon.code, @coupon.status), status: :ok
        end
      rescue ActionController::ParameterMissing
        render json: '', status: :precondition_failed
      rescue ActiveRecord::RecordInvalid
        render json: '', status: :unprocessable_entity
      end

      def validates
        if @coupon.active?
          render json: infos_to_formatter('Este cupom é válido', @coupon.code, @coupon.status), status: :ok
        else
          render json: infos_to_formatter('Este cupom é inválido', @coupon.code, @coupon.status), status: :not_found
        end
      end

      private

      # verifica se o cupom existe
      def find_coupon
        @coupon = Coupon.find_by!(code: params[:code])
      rescue ActiveRecord::RecordNotFound
        render json: json_formatter(message: 'Este cupom não existe', code: params[:code]), status: :not_found
      end

      # pega as infos que serao que serao mecessarias para a resposta da
      # requisicao da API e manda para o metodo json_formatter
      def infos_to_formatter(message, code, status)
        json_formatter(message: message, code: code, status: status)
      end

      # pega as infos que vem do metodo infos_formatter e monta o corpo da
      # resposta da requisicao para o json renderizar
      def json_formatter(message:, code: nil, status: nil)
        { message: message, coupon: code, actual_status: status }
      end
    end
  end
end
