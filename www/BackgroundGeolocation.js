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

  getLogEntries: function (limit, success, failure) {
    exec(success || emptyFnc,
      failure || emptyFnc,
      'BackgroundGeolocation',
      'getLogEntries', [limit]);
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
