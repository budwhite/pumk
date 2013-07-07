class ChargesController < ApplicationController
  def new

  end

  def create
    amount = params[:amount]

    charge = Stripe::Charge.create(
      card: params[:stripeToken],
      amount: amount,
      currency: 'usd'
    )

    redirect_to edit_user_registration_path, notice: 'Payment received! Thank you!'
    
  rescue Stripe::CardError, Stripe::StripeError, Stripe::InvalidRequestError => e
    flash[:error] = e.message
    redirect_to edit_user_registration_path

  end
end
