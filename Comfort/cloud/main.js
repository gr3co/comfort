
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
                                     card: request.params.token // the token id should be sent from the client
                                     },{
                                     success: function(httpResponse) {
                                     response.success("Purchase made!");
                                     },
                                     error: function(httpResponse) {
                                     response.error("Uh oh, something went wrong");
                                     }
                                     });
               });
