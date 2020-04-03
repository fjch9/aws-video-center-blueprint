/* 
 *  Copyright (c) 2020 Rivet Logic Corporation. All Rights Reserved.
 */

@Grapes(
    @Grab(group='com.stripe', module='stripe-java', version='18.12.0')
)
import org.craftercms.engine.exception.HttpStatusCodeException
import com.stripe.Stripe
import com.stripe.exception.StripeException
import com.stripe.model.PaymentIntent
import com.stripe.param.PaymentIntentCreateParams

if(!params.amount) {
	throw new HttpStatusCodeException(400, "Missing amount parameter")
} 
if(!params.currency) {
	throw new HttpStatusCodeException(400, "Missing currency parameter")
} 

def secretKey = siteConfig.getString('stripe.secretKey')
Stripe.apiKey = secretKey

PaymentIntentCreateParams params =
  PaymentIntentCreateParams.builder()
    .setCurrency(params.currency)
    .setAmount(Long.valueOf(params.amount))
    .putMetadata("integration_check", "accept_a_payment")
    .build()

PaymentIntent intent = PaymentIntent.create(params)

def clientSecret = intent.clientSecret
return [
	key: clientSecret
]