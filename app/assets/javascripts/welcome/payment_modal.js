
Kindrdfood = Kindrdfood || {};

Kindrdfood.welcome = Kindrdfood.welcome || {};

Kindrdfood.welcome.paymentModal = Kindrdfood.welcome.paymentModal || {}

Kindrdfood.welcome.paymentModal.redeemCoupon = {

		erb: function(regularPrice, invoicePrice, coupon_description, flashMessage){
			if (regularPrice) { 
				var regularPriceElement = $("del.regular-price");

				if ( regularPriceElement.length >= 1){

					$(regularPriceElement).replaceWith("<del class='regular-price'>" + regularPrice + "</del>");

				} else {
					$("span.invoice-price").before("<del class='regular-price'>" + regularPrice + "</del>");
				}
				$("span.invoice-price").text("  " + invoicePrice);
				$("#coupon-button").addClass("hidden");
				$("#coupon-field").addClass("hidden");
				$("#remove-coupon-button").removeClass("hidden");
				$("#coupon-description").text(coupon_description);
				
			}


			Kindrdfood.welcome.paymentModal.redeemCoupon.showMessage(flashMessage);
			

		},
		showMessage: function(message){
			$(".discount-response").html(message); 
		}
}

Kindrdfood.welcome.paymentModal.removeCoupon = {

		erb: function(invoicePrice, flashMessage){

			$("del.regular-price").remove();
			$("span.invoice-price").replaceWith("<span class='invoice-price'>  " + invoicePrice + "</span>");

			$("#remove-coupon-button").addClass("hidden");
			$("#coupon-button").removeClass("hidden");
			$("#coupon-field").removeClass("hidden");
			$("#coupon-description").text("");
			$(".discount-response").html(flashMessage);

		}
}

