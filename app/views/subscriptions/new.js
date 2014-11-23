$("body").append("<%= j render(:partial => 'subscription_modal') %>");
$('#subscriptionModal').modal();
payment.setupForm();