const stripe = require('stripe')('sk_test_51PYmRQRwh5s3IKABJCLgdNca2Cd4PG4c8XEcg9OL1uomWNqUNyILj54BI6lSzNgQ8YmDHJPLThG2MJq5ZxLZJG6w00d3ZNZp3x');
// This example sets up an endpoint using the Express framework.
// Watch this video to get started: https://youtu.be/rPR2aJ6XnAc.

 async function paiement (req, res){
  // Use an existing Customer ID if this is a returning customer.
  const customer = await stripe.customers.create();
  const ephemeralKey = await stripe.ephemeralKeys.create(
    {customer: customer.id},
    {apiVersion: '2024-06-20'}
  );
  const paymentIntent = await stripe.paymentIntents.create({
    amount: 1099,
    currency: 'eur',
    customer: customer.id,
    // In the latest version of the API, specifying the `automatic_payment_methods` parameter
    // is optional because Stripe enables its functionality by default.
    automatic_payment_methods: {
      enabled: true,
    },
  });

  res.json({
    paymentIntent: paymentIntent.client_secret,
    ephemeralKey: ephemeralKey.secret,
    customer: customer.id,
    publishableKey: 'pk_test_51PYmRQRwh5s3IKABsBlX0zddZRZlrCAIvyUYZHU8Ur8GsZkmnJOG1y4y2m8oIUtZ2drTS8gy8z3TQTPc4jjo8waC00naOsWbzc'
  });
}


module.exports={paiement}
