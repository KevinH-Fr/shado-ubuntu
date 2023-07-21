class Campaign < ApplicationRecord
  belongs_to :athlete

  validates :subscription, presence: true

  monetize :subscription, as: :subscription_cent

  has_many :subscriptions
  has_many :fans, through: :subscriptions

  before_save :set_default_title_main_campaign

  before_save :set_default_thank_you_note

  def set_default_title_main_campaign
    self.title = "My main campaign" if title.blank?
  end

  def set_default_thank_you_note
    self.thankyounote = "Thanks a lot for donating!" if thankyounote.blank?
  end


  after_create do
    product = Stripe::Product.create(name: title)
  
    periodicity = self.periodicity 
    puts "___________________ test periodicity : #{periodicity}"

    if periodicity == true 
       one_time_price = Stripe::Price.create({
       product: product,
      recurring: {
        interval: 'month',
      },
      unit_amount: self.subscription, # Set the subscription price amount here
      currency: 'eur',
     })
    else 
      one_time_price = Stripe::Price.create(product: product, unit_amount: self.subscription, currency: 'eur')

    end
  
    update(stripe_product_id: product.id, stripe_price_id: one_time_price.id) #, stripe_subscription_price_id: subscription_price.id)
  end

  after_update do
    product = Stripe::Product.update(stripe_product_id, {name: title})
  end

  after_update  :create_and_assign_new_stripe_price, if: :saved_change_to_subscription?

  def create_and_assign_new_stripe_price 

    periodicity = self.periodicity 
    puts "___________________ test periodicity : #{periodicity}"

    if periodicity == true 
      price = Stripe::Price.create(
        product: self.stripe_product_id, 
        recurring: {
            interval: 'month',
        },
        unit_amount: self.subscription, # Set the subscription price amount here
        currency: 'eur')

    else 
      price = Stripe::Price.create(
        product: self.stripe_product_id, 
        unit_amount: self.subscription, 
        currency: 'eur')
    end 

      update(stripe_price_id: price.id )
  end

end
