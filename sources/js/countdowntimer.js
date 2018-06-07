var CountDownTimer = (function () {
  function Counter(config) {
    var config = Object.assign(DEFAULT_CONFIG(), config || {});
    this.config = config;
    this.interval = null;
    this.remaining = this.config.startTime - parseInt(Date.now() / 1000, 10);
    if (config.element == null) {
      config.element = document.createElement('div');
      document.body.appendChild(config.element);
    }
    if (this.remaining <= 0) {
      return complete.call(this);
    }
    this.moment = config.approximation ? moment(this.config.startTime * 1000) : null;
    this.start();
  }

  Counter.prototype.start = function () {
    var me = this;
    var config = this.config;
    var element = this.config.element;
    var update = function () {
      if (0 === (me.remaining)) {
        complete.call(me);
      } else {
        element.innerHTML = config.approximation && (me.remaining - config.approximationEnd) > 0
          ? me.moment.fromNow().replace(/^in /, '')
          : getRemaining(me.remaining);
      }
      --me.remaining;
    };
    update(); //initial value
    clearInterval(this.interval);
    this.interval = setInterval(update, 1000);
  }

  function complete() {
    clearInterval(this.interval);
    this.config.element.innerHTML = '';
    this.config.complete();
    try {
      this.config.element.parentNode.removeChild(element);
    } catch (e) { }
  }

  function getRemaining(secs) {
    var divisorForMinutes = secs % (60 * 60);
    var hours = Math.floor(secs / (60 * 60)) + '';
    var minutes = Math.floor(divisorForMinutes / 60) + '';
    var seconds = Math.ceil(divisorForMinutes % 60) + '';
    hours = hours ? (hours.length < 2) ? ('0' + hours) : hours : '';
    minutes = minutes ? (minutes.length < 2) ? ('0' + minutes) : minutes : '';
    seconds = seconds ? (seconds.length < 2) ? ('0' + seconds) : seconds : '';
    return (hours + ':' + minutes + ':' + seconds);
  }

  function finished(ms) {
    return (Date.now() >= ms);
  }

  var DEFAULT_CONFIG = function () {
    return {
      element: null,
      approximation: false,
      approximationEnd: 0,
      startTime: parseInt(Date.now() / 1000, 10) + 10,
      complete: function () {}
    };
  }

  return Counter;

})();