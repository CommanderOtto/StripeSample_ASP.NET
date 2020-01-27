<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckoutTest.aspx.cs" Inherits="StripeTutorial.CheckoutTest" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Stripe Payment Page Recipe</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="A demo of Stripe Billing" />
    <script src="https://js.stripe.com/v3/"></script>
    <link rel="stylesheet" href="~/Content/normalize.css" />
    <link rel="stylesheet" href="~/Content/global.css" />
    <script src="script.js" defer></script>
</head>
<body>   
    <div class="sr-root">
        <div class="sr-main">
            <header class="sr-header">
                <div class="sr-header__logo"></div>
            </header>
            <div class="sr-payment-summary payment-view">
                <h1 class="order-amount">$14.00</h1>
                <h4>Subscribe to the 3 photo plan</h4>
            </div>
            <form id="form1" runat="server">
                <div class="sr-payment-form payment-view">
                    <div class="sr-form-row">
                        <label for="card-element">Payment details</label>
                        <div class="sr-combo-inputs">
                            <div class="sr-combo-inputs-row">
                                <input type="text" id="email" placeholder="Email" autocomplete="cardholder" class="sr-input"/>
                            </div>
                            <div class="sr-combo-inputs-row">
                                <div class="sr-input sr-card-element" id="card-element"></div>
                            </div>
                        </div>
                        <div class="sr-field-error" id="card-errors" role="alert"></div>
                    </div>
                    <button id="submit">
                        <div id="spinner" class="hidden"></div>
                        <span id="button-text">Subscribe</span>
                    </button>
                    <div class="sr-legal-text">
                        Your card will be immediately charged
                        <span class="order-total">$14.00</span>.
                    </div>
                </div>
            </form>
            <div class="sr-payment-summary hidden completed-view">
                <h1>Your subscription is <span class="order-status"></span></h1>
                <h4>
                <a>View subscription response:</a>
                </h4>
            </div>
            <div class="sr-section hidden completed-view">
                <div class="sr-callout">
                <pre><code></code></pre>
                </div>
                <button onclick="window.location.href='/'">Restart demo</button>
            </div>
        </div>
        <div class="sr-content">
            <div class="pasha-image-stack">
                <img
                src="https://picsum.photos/280/320?random=1"
                width="140"
                height="160"
                />
                <img
                src="https://picsum.photos/280/320?random=2"
                width="140"
                height="160"
                />
                <img
                src="https://picsum.photos/280/320?random=3"
                width="140"
                height="160"
                />
                <img
                src="https://picsum.photos/280/320?random=4"
                width="140"
                height="160"
                />
            </div>
        </div>
    </div>
</body>

</html>
