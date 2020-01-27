# StripeSample_ASP.NET
A sample of Stripe payments implementation in ASP.NET Web Forms

For this sample, you can download and copy. 
To make your life easier, make sure you do the following changes:
1. Change the stripe keys in web config file
2. Create a database in Microsoft SQL Management studio, and create the tables highlighted below.
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




SQL SAMPLES:
CREATE TABLE [dbo].[Customers] (
    [CustomerId]       NVARCHAR (50) NULL,
    [StripeCustomerId] NVARCHAR (50) NULL,
    [AccountInfoEmail] NVARCHAR (50) NULL
);

CREATE TABLE [dbo].[Subscriptions] (
    [SubscriptionId]     VARCHAR (50) NOT NULL,
    [BillingCycleAnchor] VARCHAR (50) NULL,
    [BillingThreshold]   VARCHAR (50) NULL,
    [CollectionMethod]   VARCHAR (50) NULL,
    [CreateDate]         VARCHAR (50) NULL,
    [StartDate]          VARCHAR (50) NULL,
    [EndDate]            VARCHAR (50) NULL,
    [CurrentPeriodStart] VARCHAR (50) NULL,
    [CurrentPeriodEnd]   VARCHAR (50) NULL,
    [Customer]           VARCHAR (50) NULL,
    [CustomerId]         VARCHAR (50) NULL,
    [Schedule]           VARCHAR (50) NULL,
    [ScheduleId]         VARCHAR (50) NULL,
    [Status]             VARCHAR (50) NULL,
    [PlanId]             VARCHAR (50) NULL,
    [PlanName]           VARCHAR (50) NULL,
    [PlanInterval]       VARCHAR (50) NULL,
    [PlanScheme]         VARCHAR (50) NULL,
    [PlanAmount]         VARCHAR (50) NULL,
    [PlanCurrency]       VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([SubscriptionId] ASC)
);

