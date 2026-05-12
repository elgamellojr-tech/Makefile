#import <UIKit/UIKit.h>

// --- DECLARACIONES (HEADERS) ---
@interface WAMessage : NSObject
@property (nonatomic, assign) BOOL revoked;
@end

@interface WAChatSessionViewController : UIViewController
- (void)sendReadReceipt;
@end

// --- CÓDIGO ---

%group ParchesVIP
    %hook WAMessage
    - (void)setRevoked:(BOOL)arg1 { %orig(NO); }
    %end

    %hook WAChatSessionViewController
    - (void)sendReadReceipt { /* Bloqueado */ }
    %end
%end

__attribute__((visibility("default")))
__attribute__((constructor))
static void init_domidios() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"🛡️ iOS DOMIDIOS"
                                    message:@"Ingresa la Key:\nWTDFGTHGUER"
                                    preferredStyle:UIAlertControllerStyleAlert];

        [alert addTextFieldWithConfigurationHandler:^(UITextField *tf) {
            tf.placeholder = @"Key";
            tf.secureTextEntry = YES;
        }];

        [alert addAction:[UIAlertAction actionWithTitle:@"ACTIVAR" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSString *key = alert.textFields.firstObject.text;
            if ([key isEqualToString:@"WTDFGTHGUER"]) {
                %init(ParchesVIP);
            } else {
                exit(0);
            }
        }]];

        UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
        while (root.presentedViewController) root = root.presentedViewController;
        [root presentViewController:alert animated:YES completion:nil];
    });
}
