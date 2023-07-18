Stripe.api_key = if Rails.env.production?
    ENV['STRIPE_SECRET_KEY'] # Use environment variable for production
  else
    Rails.application.credentials.dig(:stripe, :secret) # Use Rails credentials for other environments
  end
  