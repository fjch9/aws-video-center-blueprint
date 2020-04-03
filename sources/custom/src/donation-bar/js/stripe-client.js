// configure stripe and process payment
(configureStripe = (stripe, stripeElements, selectedValue, clientSecret, currency) => {
  var form = document.querySelector('.card-elements');
  var error = form.querySelector('.error');
  var errorMessage = error.querySelector('.message');


  /**
   * Card Element
   */
  var card = stripeElements.create("card", {
    style: {
      base: {
        color: "#303030",
        iconColor: '#FFB139',
        fontWeight: 500,
        fontFamily: "Inter UI, Open Sans, Segoe UI, sans-serif",
        fontSize: "16px",
        fontSmoothing: "antialiased",

        "::placeholder": {
          color: "#4444"
        }
      },
      invalid: {
        iconColor: 'red',
        color: 'red',
      },
    }
  });

  card.mount("#card-element");

  /**
   * Payment Request Element
   */
  var paymentRequest = stripe.paymentRequest({
    country: "US",
    currency: currency,
    total: {
      amount: selectedValue * 100, // cents required so calculate amount
      label: "Total"
    },
    requestPayerName: true,
    // requestPayerEmail: true
  });

  var paymentRequestElement = stripeElements.create("paymentRequestButton", {
    paymentRequest: paymentRequest,
    style: {
      paymentRequestButton: {
        type: "donate"
      }
    }
  });

  paymentRequest.canMakePayment().then(function (result) {
    if (result) {
      document.querySelector(".card-elements .card-only").style.display = "none";
      document.querySelector(
        ".card-elements .payment-request-available"
      ).style.display =
        "block";
      paymentRequestElement.mount("#card-paymentRequest");
    }
  });

  var registerElements = (elements, cardId) => {
    var formClass = '.' + cardId;
    var formElements = document.querySelector(formClass);

    var form = formElements.querySelector('form');
    var error = form.querySelector('.error');
    var errorMessage = error.querySelector('.message');

    var enableInputs = () => {
      Array.prototype.forEach.call(
        form.querySelectorAll(
          "input[type='text'], input[type='email']"
        ),
        (input) => {
          input.removeAttribute('disabled');
        }
      );
    }

    var disableInputs = () => {
      Array.prototype.forEach.call(
        form.querySelectorAll(
          "input[type='text'], input[type='email']"
        ),
        (input) => {
          input.setAttribute('disabled', 'true');
        }
      );
    }

    var triggerBrowserValidation = () => {
      // The only way to trigger HTML5 form validation UI is to fake a user submit
      // event.
      var submit = document.createElement('input');
      submit.type = 'submit';
      submit.style.display = 'none';
      form.appendChild(submit);
      submit.click();
      submit.remove();
    }


    // Listen for errors from each Element, and show error messages in the UI.
    var savedErrors = {};
    elements.forEach((element, idx) => {
      element.on('change', (event) => {
        if (event.error) {
          error.classList.add('visible');
          savedErrors[idx] = event.error.message;
          errorMessage.innerText = event.error.message;
        } else {
          savedErrors[idx] = null;

          // Loop over the saved errors and find the first one, if any.
          var nextError = Object.keys(savedErrors)
            .sort()
            .reduce((maybeFoundError, key) => {
              return maybeFoundError || savedErrors[key];
            }, null);

          if (nextError) {
            // Now that they've fixed the current error, show another one.
            errorMessage.innerText = nextError;
          } else {
            // The user fixed the last error; no more errors.
            error.classList.remove('visible');
          }
        }
      });
    });

    // Listen on the form's 'submit' handler...
    form.addEventListener('submit', (e) => {
      e.preventDefault();

      // Trigger HTML5 validation UI on the form if any of the inputs fail
      // validation.
      var plainInputsValid = true;
      Array.prototype.forEach.call(form.querySelectorAll('input'), function (
        input
      ) {
        if (input.checkValidity && !input.checkValidity()) {
          plainInputsValid = false;
          return;
        }
      });
      if (!plainInputsValid) {
        triggerBrowserValidation();
        return;
      }

      // Show a loading screen...
      toggleSpinner();

      // Disable all inputs.
      disableInputs();
    });

    let formSubmit = document.getElementById('donation-form');
    formSubmit.addEventListener('submit', (e) => {
      e.preventDefault();
      const billing_details = {
        name: document.getElementById('name').value,
        email: document.getElementById('email').value
      }
      Object.keys(billing_details).forEach(key => (billing_details[key] === undefined || billing_details[key] === "") && delete billing_details[key])
      donate(card, clientSecret, billing_details, enableInputs);
    })
  }

  var donate = (card, clientSecret, billing_details, cb) => {
    try {
      stripe.confirmCardPayment(clientSecret, {
        payment_method: {
          card: card,
          billing_details
        }
      }).then((result) => {
        cb();
        // hide a loading screen...
        toggleSpinner();
        if (result.error) {
          // Show error to your customer (e.g., insufficient funds)
          alert(result.error.message);
        } else {
          // The payment has been processed!
          if (result.paymentIntent.status === 'succeeded') {
            // Show a success message to your customer
            // There's a risk of the customer closing the window before callback
            // execution. Set up a webhook or plugin to listen for the
            // payment_intent.succeeded event that handles any business critical
            // post-payment actions.
            toggleModal();
            alert('Thanks for your donation.');
          }
        }
      });
    } catch (e) {
      alert('Server error, please contact support');
      toggleSpinner();
    };
  }

  // enable stripe elements
  registerElements([card, paymentRequestElement], 'card-elements');

});
