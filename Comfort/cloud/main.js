
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
	response.success("Hello world!");
});

var Stripe = require('stripe');
Stripe.initialize('sk_test_Z7GG1vZZ9B86q5LH0wWc2FGM');


Parse.Cloud.define("charge", function(request, response) {
	

	Stripe.Charges.create({
		amount: request.params.amount, // $1 expressed in cents
		currency: request.params.currency,
		customer: request.params.customer // the token id should be sent from the client
    },{
        success: function(httpResponse) {
            response.success("Thank you for your purchase!");
        },
        error: function(httpResponse) {
            response.error("Uh oh, something went wrong");
        }
    });
});



Parse.Cloud.define("register", function(req,res) {
	
	var stripeToken = req.params.card;
	var objectId = req.params.objectId;

	Stripe.Customers.create({
		card: stripeToken,
		description: objectId
	}, /*function(err, customer) {
		if (err) {
			res.error(err);
		} else {
			res.success(customer.id);
		}*/
		{
        success: function(customer) {
            res.success(customer.id);
        },
        error: function(error) {
            res.error(error);
        }
	});

});