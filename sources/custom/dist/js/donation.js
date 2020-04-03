/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./src/donation-bar/js/init-donation.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./src/donation-bar/css/donation-bar.scss":
/*!************************************************!*\
  !*** ./src/donation-bar/css/donation-bar.scss ***!
  \************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("// removed by extract-text-webpack-plugin\n\n//# sourceURL=webpack:///./src/donation-bar/css/donation-bar.scss?");

/***/ }),

/***/ "./src/donation-bar/js/donation-bar.js":
/*!*********************************************!*\
  !*** ./src/donation-bar/js/donation-bar.js ***!
  \*********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("// enables the donation bar, gets the paymentintent\nconfigureDonationBar = function configureDonationBar(amountButtons, currency, currencySymbol, publicKey) {\n  var selectedValue = parseInt(amountButtons[1]);\n  var customEnabled = false; // sets class to custom input based on selected amount\n\n  var checkCustomInputClass = function checkCustomInputClass(id) {\n    if (customEnabled) {\n      var customInput = document.querySelector(\"#custom-amount-input\");\n\n      if (id === 'donate-custom') {\n        customInput.classList.add('active');\n        customInput.focus();\n      } else {\n        customInput.classList.remove('active');\n      }\n    }\n  }; // dynamically add amount buttons\n\n\n  var setDonationButtons = function setDonationButtons() {\n    var optionsContainer = document.querySelector('#options-container');\n    var buttons = amountButtons.map(function (amount, index) {\n      if (amount === 'custom') {\n        customEnabled = true;\n        return \"<input type=\\\"radio\\\" class=\\\"donation__radio-input\\\" name=\\\"donate\\\" id=\\\"donate-custom\\\" value=\\\"0\\\">\\n            <label class=\\\"donation__label custom\\\" for=\\\"donate-custom\\\"\\n                title=\\\"Donate any amount\\\">\\n                \".concat(currencySymbol, \"<input type=\\\"number\\\" class=\\\"custom-amount\\\" name=\\\"custom-amount-input\\\" id=\\\"custom-amount-input\\\"\\n                    placeholder=\\\"1000?\\\" min=\\\"1\\\" />\\n            </label>\");\n      }\n\n      return \"<input type=\\\"radio\\\" class=\\\"donation__radio-input\\\" name=\\\"donate\\\" id=\\\"donate-\".concat(amount, \"\\\" value=\\\"\").concat(amount, \"\\\" \").concat(index === 0 ? 'checked' : '', \">\\n        <label class=\\\"donation__label\\\" for=\\\"donate-\").concat(amount, \"\\\" >\").concat(currencySymbol).concat(amount, \"</label>\");\n    });\n    optionsContainer.innerHTML = buttons.join(\" \");\n\n    if (customEnabled) {\n      setCustomInput();\n    }\n  };\n\n  var setEventsListeners = function setEventsListeners() {\n    amountButtons.forEach(function (amount) {\n      var input = document.getElementById('donate-' + amount);\n      input.addEventListener('click', checkCustomInputClass('donate-' + amount));\n    });\n  }; //style selected custom option \n\n\n  var setCustomInput = function setCustomInput() {\n    var customInput = document.querySelector(\"#custom-amount-input\");\n    customInput.addEventListener('click', function () {\n      // customInput.classList.toggle('active')\n      if (!document.getElementById('donate-custom').checked) document.getElementById('donate-custom').click();\n    });\n    var submit = document.querySelector(\"#submit-btn\");\n    submit.addEventListener('click', function (event) {\n      // set the value of the custom input to the selected option\n      document.getElementById('donate-custom').value = document.querySelector(\"#custom-amount-input\").value; //get selected option value\n\n      var radios = document.getElementsByName('donate');\n      var value = 0;\n      radios.forEach(function (radio) {\n        if (radio.checked) value = radio.value;\n      }); // validates value to display modal\n\n      if (value > 0) {\n        selectedValue = value; // dollar\n\n        setPaymentIntent();\n      } else {\n        alert('Please enter or select a valid amount');\n      }\n    });\n  };\n\n  var setPaymentIntent = function setPaymentIntent() {\n    toggleSpinner();\n    var http = new XMLHttpRequest();\n    var amount = selectedValue * 100; // stripe require cents\n\n    var url = \"/api/1/payment.json?amount=\".concat(amount, \"&currency=\").concat(currency);\n    var clientSecret = \"\";\n    http.open('GET', url);\n    http.send();\n\n    http.onerror = function (error) {\n      toggleSpinner();\n      alert('Failed to contact server, if the error persists contact support.');\n    };\n\n    http.onload = function (_ref) {\n      var target = _ref.target;\n      toggleSpinner();\n\n      if (target.status === 200) {\n        clientSecret = target.response;\n        initStripe(publicKey, selectedValue, clientSecret);\n        toggleModal(selectedValue, currencySymbol);\n      } else {\n        alert('Server error, please try again. If the error persists contact support.');\n      }\n    };\n  };\n\n  setDonationButtons(); // setCustomInput();\n\n  setEventsListeners();\n};\n\n//# sourceURL=webpack:///./src/donation-bar/js/donation-bar.js?");

/***/ }),

/***/ "./src/donation-bar/js/donation-modal.js":
/*!***********************************************!*\
  !*** ./src/donation-bar/js/donation-modal.js ***!
  \***********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("// displays modal with stripe elements\n(function () {\n  var modal = document.querySelector(\".donation-modal\");\n  var closeButton = document.querySelector(\".close-button\");\n\n  toggleModal = function toggleModal(selectedValue, currencySymbol) {\n    modal.classList.toggle(\"show-modal\");\n    document.querySelector('.submit-donation').innerHTML = \"Donate \".concat(currencySymbol).concat(selectedValue);\n  };\n\n  windowOnClick = function windowOnClick(event) {\n    if (event.target === modal) {\n      toggleModal();\n    }\n  };\n\n  closeButton.addEventListener(\"click\", toggleModal);\n  window.addEventListener(\"click\", windowOnClick);\n})();\n\n//# sourceURL=webpack:///./src/donation-bar/js/donation-modal.js?");

/***/ }),

/***/ "./src/donation-bar/js/init-donation.js":
/*!**********************************************!*\
  !*** ./src/donation-bar/js/init-donation.js ***!
  \**********************************************/
/*! no exports provided */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _donation_modal__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./donation-modal */ \"./src/donation-bar/js/donation-modal.js\");\n/* harmony import */ var _donation_modal__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_donation_modal__WEBPACK_IMPORTED_MODULE_0__);\n/* harmony import */ var _loading_spinner__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./loading-spinner */ \"./src/donation-bar/js/loading-spinner.js\");\n/* harmony import */ var _loading_spinner__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(_loading_spinner__WEBPACK_IMPORTED_MODULE_1__);\n/* harmony import */ var _stripe_config__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./stripe-config */ \"./src/donation-bar/js/stripe-config.js\");\n/* harmony import */ var _stripe_config__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(_stripe_config__WEBPACK_IMPORTED_MODULE_2__);\n/* harmony import */ var _stripe_client__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./stripe-client */ \"./src/donation-bar/js/stripe-client.js\");\n/* harmony import */ var _stripe_client__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(_stripe_client__WEBPACK_IMPORTED_MODULE_3__);\n/* harmony import */ var _donation_bar__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ./donation-bar */ \"./src/donation-bar/js/donation-bar.js\");\n/* harmony import */ var _donation_bar__WEBPACK_IMPORTED_MODULE_4___default = /*#__PURE__*/__webpack_require__.n(_donation_bar__WEBPACK_IMPORTED_MODULE_4__);\n/* harmony import */ var _css_donation_bar_scss__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ../css/donation-bar.scss */ \"./src/donation-bar/css/donation-bar.scss\");\n/* harmony import */ var _css_donation_bar_scss__WEBPACK_IMPORTED_MODULE_5___default = /*#__PURE__*/__webpack_require__.n(_css_donation_bar_scss__WEBPACK_IMPORTED_MODULE_5__);\n\n\n\n\n\n //order of imports is important\n\n//# sourceURL=webpack:///./src/donation-bar/js/init-donation.js?");

/***/ }),

/***/ "./src/donation-bar/js/loading-spinner.js":
/*!************************************************!*\
  !*** ./src/donation-bar/js/loading-spinner.js ***!
  \************************************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("(function () {\n  var spinner = document.createElement('div');\n  spinner.className = \"loading-spinner\";\n  spinner.innerHTML = \"<div></div><div></div><div></div><div></div>\";\n  document.body.appendChild(spinner);\n\n  toggleSpinner = function toggleSpinner() {\n    document.querySelector('.loading-spinner').classList.toggle('show-loading');\n  };\n})();\n\n//# sourceURL=webpack:///./src/donation-bar/js/loading-spinner.js?");

/***/ }),

/***/ "./src/donation-bar/js/stripe-client.js":
/*!**********************************************!*\
  !*** ./src/donation-bar/js/stripe-client.js ***!
  \**********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("// configure stripe and process payment\nconfigureStripe = function configureStripe(stripe, stripeElements, selectedValue, clientSecret) {\n  var form = document.querySelector('.card-elements');\n  var error = form.querySelector('.error');\n  var errorMessage = error.querySelector('.message');\n  /**\n   * Card Element\n   */\n\n  var card = stripeElements.create(\"card\", {\n    style: {\n      base: {\n        color: \"#303030\",\n        iconColor: '#FFB139',\n        fontWeight: 500,\n        fontFamily: \"Inter UI, Open Sans, Segoe UI, sans-serif\",\n        fontSize: \"16px\",\n        fontSmoothing: \"antialiased\",\n        \"::placeholder\": {\n          color: \"#4444\"\n        }\n      },\n      invalid: {\n        iconColor: 'red',\n        color: 'red'\n      }\n    }\n  });\n  card.mount(\"#card-element\");\n  /**\n   * Payment Request Element\n   */\n\n  var paymentRequest = stripe.paymentRequest({\n    country: \"US\",\n    currency: \"usd\",\n    total: {\n      amount: selectedValue * 100,\n      // cents required so calculate amount\n      label: \"Total\"\n    },\n    requestPayerName: true // requestPayerEmail: true\n\n  });\n  var paymentRequestElement = stripeElements.create(\"paymentRequestButton\", {\n    paymentRequest: paymentRequest,\n    style: {\n      paymentRequestButton: {\n        type: \"donate\"\n      }\n    }\n  });\n  paymentRequest.canMakePayment().then(function (result) {\n    if (result) {\n      document.querySelector(\".card-elements .card-only\").style.display = \"none\";\n      document.querySelector(\".card-elements .payment-request-available\").style.display = \"block\";\n      paymentRequestElement.mount(\"#card-paymentRequest\");\n    }\n  });\n\n  var registerElements = function registerElements(elements, cardId) {\n    var formClass = '.' + cardId;\n    var formElements = document.querySelector(formClass);\n    var form = formElements.querySelector('form');\n    var error = form.querySelector('.error');\n    var errorMessage = error.querySelector('.message');\n\n    var enableInputs = function enableInputs() {\n      Array.prototype.forEach.call(form.querySelectorAll(\"input[type='text'], input[type='email']\"), function (input) {\n        input.removeAttribute('disabled');\n      });\n    };\n\n    var disableInputs = function disableInputs() {\n      Array.prototype.forEach.call(form.querySelectorAll(\"input[type='text'], input[type='email']\"), function (input) {\n        input.setAttribute('disabled', 'true');\n      });\n    };\n\n    var triggerBrowserValidation = function triggerBrowserValidation() {\n      // The only way to trigger HTML5 form validation UI is to fake a user submit\n      // event.\n      var submit = document.createElement('input');\n      submit.type = 'submit';\n      submit.style.display = 'none';\n      form.appendChild(submit);\n      submit.click();\n      submit.remove();\n    }; // Listen for errors from each Element, and show error messages in the UI.\n\n\n    var savedErrors = {};\n    elements.forEach(function (element, idx) {\n      element.on('change', function (event) {\n        if (event.error) {\n          error.classList.add('visible');\n          savedErrors[idx] = event.error.message;\n          errorMessage.innerText = event.error.message;\n        } else {\n          savedErrors[idx] = null; // Loop over the saved errors and find the first one, if any.\n\n          var nextError = Object.keys(savedErrors).sort().reduce(function (maybeFoundError, key) {\n            return maybeFoundError || savedErrors[key];\n          }, null);\n\n          if (nextError) {\n            // Now that they've fixed the current error, show another one.\n            errorMessage.innerText = nextError;\n          } else {\n            // The user fixed the last error; no more errors.\n            error.classList.remove('visible');\n          }\n        }\n      });\n    }); // Listen on the form's 'submit' handler...\n\n    form.addEventListener('submit', function (e) {\n      e.preventDefault(); // Trigger HTML5 validation UI on the form if any of the inputs fail\n      // validation.\n\n      var plainInputsValid = true;\n      Array.prototype.forEach.call(form.querySelectorAll('input'), function (input) {\n        if (input.checkValidity && !input.checkValidity()) {\n          plainInputsValid = false;\n          return;\n        }\n      });\n\n      if (!plainInputsValid) {\n        triggerBrowserValidation();\n        return;\n      } // Show a loading screen...\n\n\n      toggleSpinner(); // Disable all inputs.\n\n      disableInputs();\n    });\n    var formSubmit = document.getElementById('donation-form');\n    formSubmit.addEventListener('submit', function (e) {\n      e.preventDefault();\n      var billing_details = {\n        name: document.getElementById('name').value,\n        email: document.getElementById('email').value\n      };\n      Object.keys(billing_details).forEach(function (key) {\n        return (billing_details[key] === undefined || billing_details[key] === \"\") && delete billing_details[key];\n      });\n      donate(card, clientSecret, billing_details, enableInputs);\n    });\n  };\n\n  var donate = function donate(card, clientSecret, billing_details, cb) {\n    stripe.confirmCardPayment(clientSecret, {\n      payment_method: {\n        card: card,\n        billing_details: billing_details\n      }\n    }).then(function (result) {\n      cb(); // hide a loading screen...\n\n      toggleSpinner();\n\n      if (result.error) {\n        // Show error to your customer (e.g., insufficient funds)\n        alert(result.error.message);\n      } else {\n        // The payment has been processed!\n        if (result.paymentIntent.status === 'succeeded') {\n          // Show a success message to your customer\n          // There's a risk of the customer closing the window before callback\n          // execution. Set up a webhook or plugin to listen for the\n          // payment_intent.succeeded event that handles any business critical\n          // post-payment actions.\n          toggleModal();\n          alert('Thanks for your donation.');\n        }\n      }\n    });\n  }; // enable stripe elements\n\n\n  registerElements([card, paymentRequestElement], 'card-elements');\n};\n\n//# sourceURL=webpack:///./src/donation-bar/js/stripe-client.js?");

/***/ }),

/***/ "./src/donation-bar/js/stripe-config.js":
/*!**********************************************!*\
  !*** ./src/donation-bar/js/stripe-config.js ***!
  \**********************************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("// inits stripe\n(function () {\n  initStripe = function initStripe(key, selectedValue, clientSecret) {\n    var stripe = Stripe(key);\n    var stripeElements = stripe.elements();\n    configureStripe(stripe, stripeElements, selectedValue, clientSecret);\n  };\n})();\n\n//# sourceURL=webpack:///./src/donation-bar/js/stripe-config.js?");

/***/ })

/******/ });