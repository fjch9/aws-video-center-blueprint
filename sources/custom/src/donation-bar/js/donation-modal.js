// displays modal with stripe elements
(() => {
    var modal = document.querySelector(".donation-modal");
    var closeButton = document.querySelector(".close-button");

    toggleModal = (selectedValue, currencySymbol) => {
        modal.classList.toggle("show-modal");

        document.querySelector('.submit-donation').innerHTML = `Donate ${currencySymbol}${selectedValue}`;
    }

    windowOnClick = (event) => {
        if (event.target === modal) {
            toggleModal();
        }
    }

    closeButton.addEventListener("click", toggleModal);
    window.addEventListener("click", windowOnClick);

})();