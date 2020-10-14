import Raven from 'raven-js';

function init() {
  if (process.env.NODE_ENV === 'production') {
    if (!process.env.USE_SENTRY) {
      console.log('Sentry.init: set env USE_SENTRY to enable Sentry');
      return;
    };
    const opts = {};

    if (typeof __webpack_hash__ !== 'undefined') { // eslint-disable-line camelcase
      opts.release = __webpack_hash__; // eslint-disable-line no-undef, camelcase
    }

    Raven.config(
      'https://50006e5d91894f508dd288bbbf4585a6@sentry.io/185303',
      opts
    ).install();
  }
}

export default { init };
