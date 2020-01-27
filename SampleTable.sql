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
