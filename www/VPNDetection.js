var exec = require('cordova/exec');

exports.detectVPN = function (success, error,iosVPNInterfaces) {
    exec(success, error, 'VPNDetectionPlugin', 'detectVPN', [iosVPNInterfaces]);
};
