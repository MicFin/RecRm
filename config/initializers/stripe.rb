Stripe.api_key = ENV['STRIPE_API_KEY']
STRIPE_PUBLIC_KEY = ENV['STRIPE_PUBLIC_KEY']

# Rails.configuration.stripe = {
#   :publishable_key => ENV['STRIPE_PUBLIC_KEY'],
#   :secret_key      => ENV['STRIPE_API_KEY']
# }

# Stripe.api_key = Rails.configuration.stripe[:secret_key]