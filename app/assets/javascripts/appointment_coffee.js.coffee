# This code should only run after the page’s DOM has loaded and so it’s all wrapped in the jQuery function. The first thing it does is set up Stripe by specifying the publishable key. The key’s value is read from the meta tag we added in the application’s layout file. We fetch it by looking for a meta tag with a name attribute that has a value of stripe and reading that tag’s content attribute. The rest of the logic is handled through a subscription object. This object has a function called setupForm that will do all of the work.

jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  subscription.setupForm()

# Next we create the subscription object and give it a setupForm function. In this function we get the subscription form by its id and add a callback that fires when the form’s submit event fires. When the form is submitted we disable the submit button to stop it from being accidentally submitted again by setting the button’s disabled attribute to true. Then we call a processCard function and return false so that the form isn’t submitted.
subscription =
  setupForm: ->
    $('#btn-purchase-appt').submit ->
      $('input[type=submit]').attr('disabled', true)
      subscription.processCard()
# The processCard function creates an object representing the credit card’s values in the format that Stripe expects and reads the appropriate values for each field from the form’s fields using val(). The next line is the important one. We call Stripe.createToken with two arguments. The first is the card object that we’ve just created (we can also pass in an optional amount here). The second is a function that will handle the response from Stripe, which happens asynchronously. We’ll pass in subscription.handleStripeResponse here.
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, subscription.handleStripeResponse)

# The handleStripeResponse function takes two arguments: a status and a response. If the status has a value of 200 then the transaction succeeded and we’ll have a response token stored in response.id. For now we’ll just alert the response value so that we can see what it is. If the status isn’t 200 then an error has occurred so we’ll alert the error message.
  handleStripeResponse: (status, response) ->
    if status == 200
      alert(response.id)
    else
         alert(response.error.message)