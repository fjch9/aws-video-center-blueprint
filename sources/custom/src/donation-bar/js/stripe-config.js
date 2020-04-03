
// inits stripe
(() => {
    initStripe = (key, selectedValue, clientSecret) => {
        const stripe = Stripe(key);
        const stripeElements = stripe.elements();

        configureStripe(stripe, stripeElements, selectedValue, clientSecret);
    }
})();

