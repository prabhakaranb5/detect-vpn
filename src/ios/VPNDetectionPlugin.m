/********* VPNDetectionPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface VPNDetectionPlugin : CDVPlugin {
  // Member variables go here.
}

- (void)detectVPN:(CDVInvokedUrlCommand*)command;
@end

@implementation VPNDetectionPlugin

- (void)detectVPN:(CDVInvokedUrlCommand*)command
{
    
    NSString * jsonVPNs = [command argumentAtIndex:0];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:[self checkForVPNConnectivity:jsonVPNs]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (BOOL)checkForVPNConnectivity:(NSString*) jsonVPNs
{
    if (jsonVPNs == nil || [jsonVPNs isEqualToString:@""]) {
        jsonVPNs = @"[\"tap\",\"tun\",\"ppp\",\"ipsec\",\"utun\"]";
    }
    
    jsonVPNs = [jsonVPNs stringByReplacingOccurrencesOfString:@"[" withString:@""];
    jsonVPNs = [jsonVPNs stringByReplacingOccurrencesOfString:@"]" withString:@""];
    jsonVPNs = [jsonVPNs stringByReplacingOccurrencesOfString:@"\"" withString:@""];

    NSArray * vpns = [jsonVPNs componentsSeparatedByString:@","];
    
    NSDictionary *dict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
    NSDictionary *keys = dict[@"__SCOPED__"];
    //NSArray *vpns = @[@"tap",@"tun",@"ppp",@"ipsec",@"utun"];
    
    for (NSString* key in keys.allKeys){
      for(NSString* vpn in vpns){
        if([key containsString:vpn]){
          return true;
        }
      }
    }
    return false;
}

@end
