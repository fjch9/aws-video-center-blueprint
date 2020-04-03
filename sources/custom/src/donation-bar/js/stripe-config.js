
// inits stripe
(() => {
    initStripe = (key, selectedValue, clientSecret, currency) => {
        const stripe = Stripe(key);
        const stripeElements = stripe.elements();

        configureStripe(stripe, stripeElements, selectedValue, clientSecret, currency);
    }
})();

