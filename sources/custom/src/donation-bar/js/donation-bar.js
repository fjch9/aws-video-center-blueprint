// enables the donation bar, gets the paymentintent
(configureDonationBar = (amountButtons, currency, currencySymbol, publicKey) => {
    var selectedValue = parseInt(amountButtons[1]);
    var customEnabled = false;
    // sets class to custom input based on selected amount
    var checkCustomInputClass = (id) => {
        if (customEnabled) {
            const customInput = document.querySelector("#custom-amount-input");
            if (id === 'donate-custom') {
                customInput.classList.add('active');
                customInput.focus();
            } else {
                customInput.classList.remove('active');
            }
        }
    }
    // dynamically add amount buttons
    var setDonationButtons = () => {
        const optionsContainer = document.querySelector('#options-container');
        const buttons = amountButtons.map((amount, index) => {
            if (amount === 'custom') {
                customEnabled = true;
                return `<input type="radio" class="donation__radio-input" name="donate" id="donate-custom" value="0">
            <label class="donation__label custom" for="donate-custom"
                title="Donate any amount">
                ${currencySymbol}<input type="number" class="custom-amount" name="custom-amount-input" id="custom-amount-input"
                    placeholder="1000?" min="1" />
            </label>`
            }
            return `<input type="radio" class="donation__radio-input" name="donate" id="donate-${amount}" value="${amount}" ${index === 0 ? 'checked' : ''}>
        <label class="donation__label" for="donate-${amount}" >${currencySymbol}${amount}</label>`
        });
        optionsContainer.innerHTML = buttons.join(" ");
        if (customEnabled) {
            setCustomInput();
        }
    }
    var setEventsListeners = () => {
        amountButtons.forEach(amount => {
            const input = document.getElementById('donate-' + amount);
            input.addEventListener('click', checkCustomInputClass('donate-' + amount));
        });
        const submit = document.querySelector("#submit-btn");
        submit.addEventListener('click', event => {
            // set the value of the custom input to the selected option
            if (customEnabled)
                document.getElementById('donate-custom').value = document.querySelector("#custom-amount-input").value;
            //get selected option value
            var radios = document.getElementsByName('donate');
            var value = 0;
            radios.forEach(radio => {
                if (radio.checked)
                    value = radio.value;
            });
            // validates value to display modal
            if (value > 0) {
                selectedValue = value; // dollar
                setPaymentIntent();
            } else {
                alert('Please enter or select a valid amount');
            }
        });
    }
    //style selected custom option 
    var setCustomInput = () => {
        const customInput = document.querySelector("#custom-amount-input");
        customInput.addEventListener('click', () => {
            // customInput.classList.toggle('active')
            if (!document.getElementById('donate-custom').checked)
                document.getElementById('donate-custom').click();
        });
    }
    var setPaymentIntent = () => {
        toggleSpinner();
        const http = new XMLHttpRequest();
        const amount = selectedValue * 100; // stripe require cents
        const url = `/api/1/payment.json?amount=${amount}&currency=${currency}`;
        var clientSecret = "";
        http.open('GET', url);
        http.send();
        http.onerror = (error) => {
            toggleSpinner();
            alert('Failed to contact server, if the error persists contact support.');
        }
        http.onload = ({ target }) => {
            toggleSpinner();
            if (target.status === 200) {
                clientSecret = JSON.parse(target.response).key;
                initStripe(publicKey, selectedValue, clientSecret);
                toggleModal(selectedValue, currencySymbol);
            } else {
                alert('Server error, please try again. If the error persists contact support.');
            }
        }
    }
    setDonationButtons();
    setEventsListeners();
});