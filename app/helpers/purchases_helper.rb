

module PurchasesHelper

  def show_purchase_cost(user, purchase, purchasable) 
    
    if (purchasable.class == Package) || ( (user.qol_referral == false) && (purchasable.status != "Unused Package Session") )
        render "purchases/purchases_modal/purchase_cost", user: user, purchase: purchase, purchasable: purchasable
    end 
  end

  def show_purchase_coupon_response(purchase, purchasable)
    
    if purchase.invoice_cost != purchase.invoice_price 
      render "purchases/purchases_modal/coupon_applied", purchase: purchase, purchasable: purchasable
    else
      render "purchases/purchases_modal/coupon_not_applied", purchase: purchase, purchasable: purchasable
    end
  end

  def show_payment_option(user, purchase, purchasable, f)
    
    if purchasable.class == Appointment && purchasable.status == "Paid"
      render "purchases/purchases_modal/already_paid"

    elsif purchasable.class == Appointment && purchasable.status == "Unused Package Session"
      render "purchases/purchases_modal/pay_with_package", purchasable: purchasable, f: f

    elsif user.qol_referral == false

      render "purchases/purchases_modal/credit_card_form", user: user, purchase: purchase, purchasable: purchasable, f: f

    else
      render "purchases/purchases_modal/default_stripe_token", f: f
    end 
  end
end
