class WebhooksController < ApplicationController
   # skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
  
   def create
      payload = request.body.read
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      event = nil
  
      begin
        event = Stripe::Webhook.construct_event(
          payload, sig_header, ENV['STRIPE_WEBHOOK_KEY'] # Use environment variable for production
        )
      rescue JSON::ParserError => e
        status 400
        return
      rescue Stripe::SignatureVerificationError => e
        # Invalid signature
        puts "Signature error"
        p e
        return
      end
  
      # Handle the event
      case event.type
      when 'checkout.session.completed'
        session = event.data.object
        session_with_expand = Stripe::Checkout::Session.retrieve({ id: session.id, expand: ["line_items"]})
        session_with_expand.line_items.data.each do |line_item|
       
         
        # a adapter pour comptabiliser la subscription : 
        # soit vers campaign, soit vers subscription avec un find_by sur autre chose
        # passer status a true plutot que incrementation
        
          product = Subscription.find_by(stripe_product_id: line_item.price.product)
          puts "____________ subscription for webhook: #{product}"
          product.update(status: true)
        
        end
      end
  
      render json: { message: 'success' }
    end
  end