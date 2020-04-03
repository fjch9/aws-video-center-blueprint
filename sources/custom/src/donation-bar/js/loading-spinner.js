(() => {
    const spinner = document.createElement('div');
    spinner.className = "loading-spinner";
    spinner.innerHTML = `<div></div><div></div><div></div><div></div>`
    document.body.appendChild(spinner);

    toggleSpinner = () => {
        document.querySelector('.loading-spinner').classList.toggle('show-loading');
      }
})();