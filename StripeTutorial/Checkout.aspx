<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="StripeTutorial.Checkout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Checkout Subscription Sample</title>
    <script src="https://js.stripe.com/v3/"></script>
    <link rel="stylesheet" href="~/Content/CardElementTest.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body>
    <form id="PaymentForm1" runat="server">
        <div class="form-row">
            <!-- Use the CSS tab above to style your Element's container. -->
            <div id="card-element" class="MyCardElement">
                <!-- Elements will create input elements here -->
            </div>

            <!-- We'll put the error messages in this element -->
            <div id="card-errors" role="alert"></div>

            <button id="submit">Pay</button>
        </div>

    </form>
</body>
<script>
    // Set your publishable key: remember to change this to your live publishable key in production
    // See your keys here: https://dashboard.stripe.com/account/apikeys

    
    <%--PART 1: SETUP OF STRIPE--%>

    <%--PART 1.A: CREATE THE BUTTON AND STRIPE CARD ELEMENT--%>
    //create a stripe client
    var stripe = Stripe('pk_test_siyu4a0sTyfKDtAdSDSUxgye00zIsedkmE');


    // Create an instance of Elements.
    var elements = stripe.elements();

    // Custom styling can be passed to options when creating an Element.
    // (Note that this demo uses a wider set of styles than the guide below.)
    var style = {
        base: {
        color: '#32325d',
        fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
        fontSmoothing: 'antialiased',
        fontSize: '16px',
        '::placeholder': {
            color: '#aab7c4'
        }
        },
        invalid: {
        color: '#fa755a',
        iconColor: '#fa755a'
        }
    };

    // Create an instance of the card Element.
    var card = elements.create('card', {style: style});

    // Add an instance of the card Element into the `card-element` <div>.
    card.mount('#card-element');

    // Handle real-time validation errors from the card Element.
    card.addEventListener('change', function(event) {
        var displayError = document.getElementById('card-errors');
        if (event.error) {
            displayError.textContent = event.error.message;
        } else {
            displayError.textContent = '';

            // Initiate payment 
            CreatePaymentMethodAndCustomer(stripe, card);
        }
    });



    <%--MAIN FUNCTION--%>
    //Custom function. This handles both create payment, and create customer. These functions are designed by Stripe.
    var createPaymentMethodAndCustomer = function(stripe, card) {
        var cardholderEmail = document.querySelector('#email').value;
        stripe.createPaymentMethod('card', card, {
            billing_details: {
            email: cardholderEmail
            }
        })
        .then(function (result) {
            createCustomer(result.paymentMethod.id, cardholderEmail);
        });
    };



    <%--PART 2: CREATE A PAYMENT FUNCTION--%>
    stripe.createPaymentMethod('card', cardElement, {
      billing_details: {
        email: 'jenny.rosen@example.com',
      },
    }).then(function(result) {
        // Handle result.error or result.paymentMethod
        if (result.error) {
            // Inform the user if there was an error.
            var errorElement = document.getElementById('card-errors');
            errorElement.textContent = result.error.message;
        } else {
            //createCustomer(result.paymentMethod.id, cardholderEmail);

        }
    });
    

    <%--PART 3: CREATE CUSTOMER FUNCTION: SEND DATA TO BACKEND + CREATE A CUSTOMER --%>
    // this backend function is used by CREATE PAYMENT method, which is mentioned above.
    //"Fetch" will gather the client side data and send to backend C# function "create customer"
    fetch('/create-customer', {
        method: 'post',
        headers: {
        'Content-Type': 'application/json'
        },
        body: JSON.stringify({
        email: 'jenny.rosen@example.com',
        payment_method: 'pm_1FU2bgBF6ERF9jhEQvwnA7sX'
        })
    }).then(response => {
        return response.json();
    })
    .then(customer => {
        // The customer has been created
    });
   



    <%--PART 4: CREATE A CUSTOMER PAYMENT FUNCTION--%>

    


    <%--PART 5: CREATE A SUBSCRIPTION (WITH CUSTOMER ID)--%>


    

    <%--PART 6: ENSURE SUBSCRIPTION CAN REMAIN ACTIVE OR IS DECLINED--%>

    
</script>
</html>
