/*
 According to apache license

 This is fork of christocracy cordova-plugin-background-geolocation plugin
 https://github.com/christocracy/cordova-plugin-background-geolocation

 Differences to original version:

 1. new method isLocationEnabled
 */

var exec = require('cordova/exec');
var channel = require('cordova/channel');
var radio = require('./radio');

var emptyFnc = function () { };

var eventHandler = function (event) {
  radio(event.name).broadcast(event.payload);
};

var errorHandler = function (error) {
  radio('error').broadcast(error);
};

var BackgroundGeolocation = {
  events: [
    'location',
    'stationary',
    'activity',
    'start',
    'stop',
    'error',
    'authorization',
    'foreground',
    'background'
  ],

  DISTANCE_FILTER_PROVIDER: 0,
  ACTIVITY_PROVIDER: 1,
  RAW_PROVIDER: 2,

  BACKGROUND_MODE: 0,
  FOREGROUND_MODE: 1,

  NOT_AUTHORIZED: 0,
  AUTHORIZED: 1,
  AUTHORIZED_FOREGROUND: 2,

  HIGH_ACCURACY: 0,
  MEDIUM_ACCURACY: 100,
  LOW_ACCURACY: 1000,
  PASSIVE_ACCURACY: 10000,

  LOG_ERROR: 'ERROR',
  LOG_WARN: 'WARN',
  LOG_INFO: 'INFO',
  LOG_DEBUG: 'DEBUG',
  LOG_TRACE: 'TRACE',

  configure: function (config, success, failure) {
    exec(success || emptyFnc,
      failure || emptyFnc,
      'BackgroundGeolocation',
      'configure',
      [config]
    );
  },

  start: function () {
    exec(null, null, 'BackgroundGeolocation', 'start');
  },

  stop: function (success, failure) {
    exec(null, null, 'BackgroundGeolocation', 'stop');
  },

  switchMode: function (mode, success, failure) {
    exec(success || emptyFnc,
      failure || emptyFnc,
      'BackgroundGeolocation',
      'switchMode', [mode]);
  },

  getConfig: function (success, failure) {
    if (typeof (success) !== 'function') {
      throw 'BackgroundGeolocation#getConfig requires a success callback';
    }
    exec(success,
      failure || emptyFnc,
      'BackgroundGeolocation',
      'getConfig', []);
  },

  /**
   * Returns current stationaryLocation if available.  null if not
   */
  getStationaryLocation: function (success, failure) {
    if (typeof (success) !== 'function') {
      throw 'BackgroundGeolocation#getStationaryLocation requires a success callback';
    }
    exec(success,
      failure || emptyFnc,
      'BackgroundGeolocation',
      'getStationaryLocation', []);
  },

  isLocationEnabled: function (success, failure) {
    if (typeof (success) !== 'function') {
      throw 'BackgroundGeolocation#isLocationEnabled requires a success callback';
    }
    exec(success,
      failure || emptyFnc,
      'BackgroundGeolocation',
      'isLocationEnabled', []);
  },

  showAppSettings: function () {
    exec(emptyFnc,
      emptyFnc,
      'BackgroundGeolocation',
      'showAppSettings', []);
  },

  showLocationSettings: function () {
    exec(emptyFnc,
      emptyFnc,
      'BackgroundGeolocation',
      'showLocationSettings', []);
  },

  getLocations: function (success, failure) {
    if (typeof (success) !== 'function') {
      throw 'BackgroundGeolocation#getLocations requires a success callback';
    }
    exec(success,
      failure || emptyFnc,
      'BackgroundGeolocation',
      'getLocations', []);
  },

  getValidLocations: function (success, failure) {
    if (typeof (success) !== 'function') {
      throw 'BackgroundGeolocation#getValidLocations requires a success callback';
    }
    exec(success,
      failure || emptyFnc,
      'BackgroundGeolocation',
      'getValidLocations', []);
  },

  deleteLocation: function (locationId, success, failure) {
    exec(success || emptyFnc,
      failure || emptyFnc,
      'BackgroundGeolocation',
      'deleteLocation', [locationId]);
  },

  deleteAllLocations: function (success, failure) {
    console.log('[Warning]: deleteAllLocations is deprecated and will be removed in future versions.')
    exec(success || emptyFnc,
      failure || emptyFnc,
      'BackgroundGeolocation',
      'deleteAllLocations', []);
  },

  getLogEntries: function(limit /*, offset = 0, minLevel = "DEBUG", success = emptyFnc, failure = emptyFnc */) {
    var acnt = arguments.length;
    var offset, minLevel, success, error;

    if (acnt > 1 && typeof arguments[1] == 'function') {
      // backward compatibility
      console.log('[WARN]: Calling deprecated variant of getLogEntries method.');
      offset = 0;
      minLevel = BackgroundGeolocation.LOG_DEBUG;
      success = arguments[1] || emptyFnc;
      failure = arguments[2] || emptyFnc;
    } else {
      offset = acnt > 1 && arguments[1] !== undefined ? arguments[1] : 0;
      minLevel = acnt > 2 && arguments[2] !== undefined ? arguments[2] : BackgroundGeolocation.LOG_DEBUG;
      success = acnt > 3 && arguments[3] !== undefined ? arguments[3] : emptyFnc;
      failure = acnt > 4 && arguments[4] !== undefined ? arguments[4] : emptyFnc;
    }

    exec(success,
      failure,
      'BackgroundGeolocation',
      'getLogEntries', [limit, offset, minLevel]);
  },

  checkStatus: function (success, failure) {
    exec(success || emptyFnc,
      failure || emptyFnc,
      'BackgroundGeolocation',
      'checkStatus')
  },

  startTask: function (success, failure) {
    exec(success || emptyFnc,
      failure || emptyFnc,
      'BackgroundGeolocation',
      'startTask');
  },

  endTask: function (taskKey, success, failure) {
    exec(success || emptyFnc,
      failure || emptyFnc,
      'BackgroundGeolocation',
      'endTask', [taskKey]);
  },

  headlessTask: function (func, success, failure) {
    exec(success || emptyFnc,
      failure || emptyFnc,
      'BackgroundGeolocation',
      'registerHeadlessTask', [func.toString()]);
  },

  forceSync: function (success, failure) {
    exec(success || emptyFnc,
      failure || emptyFnc,
      'BackgroundGeolocation',
      'forceSync', []);
  },

  on: function (event, callbackFn) {
    if (typeof callbackFn !== 'function') {
      throw 'BackgroundGeolocation: callback function must be provided';
    }
    if (this.events.indexOf(event) < 0) {
      throw 'BackgroundGeolocation: Unknown event "' + event + '"';
    }
    radio(event).subscribe(callbackFn);
    return {
      remove: function () {
        radio(event).unsubscribe(callbackFn);
      }
    };
  },

  removeAllListeners: function (event) {
    if (this.events.indexOf(event) < 0) {
      console.log('[WARN] RNBackgroundGeolocation: removeAllListeners for unknown event "' + event + '"');
      return false;
    }

    var topic = radio(event);
    var callbacks = [].concat.apply([], topic.channels[event]); // flatten array
    return topic.unsubscribe.apply(topic, callbacks);
  }
};

channel.deviceready.subscribe(function () {
  // register app global listeners
  exec(eventHandler,
    errorHandler,
    'BackgroundGeolocation',
    'addEventListener'
  );
});


module.exports = BackgroundGeolocation;
