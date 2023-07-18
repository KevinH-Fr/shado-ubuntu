class CheckoutController < ApplicationController

def create
  product = Campaign.find(params[:id])
  
  if params[:payment_mode] == 'subscription'
    session = Stripe::Checkout::Session.create({
      mode: 'subscription',
      payment_method_types: ['card'],
      line_items: [
        {
          price: product.stripe_price_id,
          quantity: 1,
        }
      ],
      success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_url,
    })
  else
    session = Stripe::Checkout::Session.create({
      mode: 'payment',
      payment_method_types: ['card'],
      line_items: [
        {
          price: product.stripe_price_id,
          quantity: 1,
        }
      ],
      success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_url,
    })
  end

  redirect_to session.url, allow_other_host: true, status: 303
end
  

  def success
    @session_with_expand = Stripe::Checkout::Session
      .retrieve({ id: params[:session_id], expand: ["line_items"] }) 

    @session_with_expand.line_items.data.each do |line_item|
      @product_id = Campaign.find_by(stripe_product_id: line_item.price.product)
    end

  end

  def cancel
  end

end
