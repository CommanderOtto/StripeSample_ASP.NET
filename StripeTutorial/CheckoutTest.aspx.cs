using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Stripe;

namespace StripeTutorial
{
    public partial class CheckoutTest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StripeConfiguration.ApiKey = ConfigurationManager.AppSettings["STRIPE_SECRET_KEY"];
            //stripe publishable key is a global environment variable from web config           
        }
        
        
        //GetPublicKey backend function, which simply provides the public key, which is saved from AppSettings in webconfig file.
        [WebMethod]
        public static string GetPublicKey()
        {
            string publicKey = ConfigurationManager.AppSettings["STRIPE_PUBLISHABLE_KEY"];

            return publicKey;
        }

        [WebMethod]
        public static string CreatePaymentIntent()
        {
            try
            {
                //create a payment intent
                var service = new PaymentIntentService();
                var options = new PaymentIntentCreateOptions
                {
                    Amount = 1400,
                    Currency = "USD",
                    PaymentMethodTypes = new List<string> { "card" },
                };

                var intent = service.Create(options);

                string clientSecret = intent.ClientSecret;

                return clientSecret;
            }
            catch (Exception ex)
            {

                throw ex; // throw error message back to the client side and maybe do something with it
            }            
        }

        //CreateCustomer method, which will use the customer details to create a customer object, save in database, and return the data to Stripe for a subscription.
        [WebMethod]
        public static Subscription CreateCustomer(string email, string payment_method)
        {
            // creating a customer with Stripe API information (https://stripe.com/docs/api/customers/create)
            // below options are sample data
            var options = new CustomerCreateOptions
            {
                Email = email,
                PaymentMethod = payment_method,
                InvoiceSettings = new CustomerInvoiceSettingsOptions
                {
                    DefaultPaymentMethod = payment_method,
                },
            };

            //create the customer with above options
            var service = new CustomerService();

            Customer customer;
            try
            {
               customer = service.Create(options);
            }
            catch (Exception ex)
            {

                throw ex;
            }

            // At this point, you may associate the ID of the Customer object with your
            // own internal representation of a customer, if you have one.
            string sample_internal_customerid = "1";
            string StripeCustomerId = customer.Id;
            string AccountInfoEmail = customer.Email;

            //connect to the database
            string cs = WebConfigurationManager.ConnectionStrings["StripeDatabaseConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            //insert in db
            string sql = "INSERT INTO [CUSTOMERS](CustomerId, StripeCustomerId, AccountInfoEmail) VALUES('" + sample_internal_customerid + "', '" + StripeCustomerId + "', '" + AccountInfoEmail + "');";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.ExecuteNonQuery();
            con.Close();

            // find all plans (temporary)
            var planListOptions = new PlanListOptions { Limit = 3 };
            var planListService = new PlanService();
            var allPlans = planListService.List(planListOptions);
            string planId = allPlans.Select(x => x.Id).First(); // for now just retrieving the first plan available. A dropdown will allow selecting the plan

            // get plan by plan id
            var planService = new PlanService();
            var plan = planService.Get(planId);

            // Subscribe the user to the subscription created
            var items = new List<SubscriptionItemOption> {
                new SubscriptionItemOption {
                Plan = plan.Id
                }
            };

            var subscriptionOptions = new SubscriptionCreateOptions
            {
                Customer = customer.Id,
                Items = items
            };

            var subscriptionService = new SubscriptionService();
            Subscription subscription = subscriptionService.Create(subscriptionOptions);

            // return subscription object as JSON back to web method
            // return JsonConvert.SerializeObject(subscription);
            return subscription;
        }



        [WebMethod]
        public static string ConfirmSubscription(string subscriptionId)
        {
            try
            {
                //retrieve subscription with the id
                var service = new SubscriptionService();
                Subscription subscription = service.Get(subscriptionId);

                //get the data for dbsave
                //each variable will do this comparison ----> ?? "" < -----
                //that comparison means "If null, place empty string)
                String SubscriptionId = subscription.Id;
                String BillingCycleAnchor = subscription.BillingCycleAnchor?.ToString() ?? "";
                String BillingThreshold = subscription.BillingThresholds?.ToString() ?? "";
                String CollectionMethod = subscription.CollectionMethod ?? "";
                String CreateDate = subscription.Created?.ToString() ?? "";
                String StartDate = subscription.StartDate?.ToString() ?? "";
                String EndDate = subscription.EndedAt?.ToString() ?? "";
                String CurrentPeriodStart = subscription.CurrentPeriodStart?.ToString() ?? "";
                String CurrentPeriodEnd = subscription.CurrentPeriodEnd?.ToString() ?? "";
                String Customer = subscription.Customer?.ToString() ?? "";
                String CustomerId = subscription.CustomerId?.ToString() ?? "";
                String ScheduleId = subscription.ScheduleId?.ToString() ?? "";
                String Schedule = subscription.Schedule?.ToString() ?? "";
                String Status = subscription.Status ?? "";
                String PlanId = subscription.Plan.Id ?? "";
                String PlanName = subscription.Plan.Nickname ?? "";
                String PlanInterval = subscription.Plan.Interval ?? "";
                String PlanBillingScheme = subscription.Plan.BillingScheme ?? "";
                String PlanAmount = subscription.Plan.Amount?.ToString() ?? "";
                String PlanCurrency = subscription.Plan.Currency ?? "";

                //connect to the database & save subscription
                string cs = WebConfigurationManager.ConnectionStrings["StripeDatabaseConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(cs);

                //insert in db
                string sql = "INSERT INTO [SUBSCRIPTIONS](SubscriptionId, BillingCycleAnchor, BillingThreshold, CollectionMethod, CreateDate, StartDate, CurrentPeriodStart, CurrentPeriodEnd, Customer, CustomerId, ScheduleId, Schedule, Status, PlanId, PlanName, PlanInterval, PlanScheme, PlanAmount, PlanCurrency) " +
                "VALUES('" + SubscriptionId + "', '" + BillingCycleAnchor + "', '" + BillingThreshold + "', '" + CollectionMethod + "', '" + CreateDate + "', '" + StartDate + "', '" + CurrentPeriodStart + "', '" + CurrentPeriodEnd + "', '" + Customer + "', '" + CustomerId + "', '" + ScheduleId + "', '" + Schedule + "', '" + Status + "', '" + PlanId + "', '" + PlanName + "', '" + PlanInterval + "', '" + PlanBillingScheme + "', '" + PlanAmount + "', '" + PlanCurrency + "');";
                con.Open();
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.ExecuteNonQuery();
                con.Close();

                // return subscription object as JSON back to web method
                return JsonConvert.SerializeObject(subscription);
            }
            catch (Exception ex)
            {

                throw;
            }            
        }
    }
}