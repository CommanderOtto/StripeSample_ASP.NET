# StripeSample_ASP.NET
A sample of Stripe payments implementation in ASP.NET Web Forms

For this sample, you can download and copy. 
To make your life easier, make sure you do the following changes:
1. Change the stripe keys in web config file
2. Create a database in Microsoft SQL Management studio, and create the tables in this directory (Customers, and Subscriptions)
3. Change the connection string in webconfig, to reflect your database connection.
4. Make sure to read the Stripe documentation:
    Introduction 
    https://stripe.com/docs/billing
    https://stripe.com/docs/billing/subscriptions/set-up-subscription

    Github examples
    https://github.com/stripe-samples/charging-for-multiple-plan-subscriptions
    https://stripe.dev/elements-examples/

    Stripe elements for web
    https://stripe.com/docs/stripe-js

5. Use the following cards for testing: https://stripe.com/docs/testing#cards

4000000000000002	Charge is declined with a card_declined code.
4000000000000341	Attaching this card to a Customer object succeeds, but attempts to charge the customer fail.
4000000000009995	Charge is declined with a card_declined code. The decline_code attribute is insufficient_funds.





