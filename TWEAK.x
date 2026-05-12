#import <UIKit/UIKit.h>

// --- DECLARACIONES PARA EVITAR EL ERROR 2 ---
@interface WAMessage : NSObject
@property (nonatomic, assign) BOOL revoked;
@end

@interface WAChatSessionViewController : UIViewController
- (void)sendReadReceipt;
- (void)sendTypingStatus;
@end

@interface WAStatusMessageManager : NSObject
- (void)sendReadReceiptForMessage:(id)arg1;
@end

@interface WAStaticConstants : NSObject
+ (double)maximumStatusVideoDuration;
@end

// --- INICIO DEL TWEAK ---

%group ParchesVIP
    %hook WAMessage
    - (void)setRevoked:(BOOL)arg1 { %orig(NO); }
    %end

    %hook WAChatSessionViewController
    - (void)sendReadReceipt { /* Bloqueado */ }
    - (void)sendTypingStatus { /* Bloqueado */ }
    %end

    %hook WAStatusMessageManager
    - (void)sendReadReceiptForMessage:(id)arg1 { /* Bloqueado */ }
    %end

    %hook WAStaticConstants
    + (double)maximumStatusVideoDuration { return 9999.0; }
    %end
%end

__attribute__((visibility("default")))
__attribute__((constructor))
static void domidios_init() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        if (!window && @available(iOS 13.0, *)) {
            for (UIWindowScene* scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    window = ((UIWindowScene*)scene).windows.firstObject;
                    break;
                }
            }
        }

        UIViewController *rootVC = window.rootViewController;
        while (rootVC.presentedViewController) rootVC = rootVC.presentedViewController;

        if (rootVC) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"🛡️ iOS DOMIDIOS"
                                        message:@"Introduce tu llave:\nWTDFGTHGUER"
                                        preferredStyle:UIAlertControllerStyleAlert];

            [alert addTextFieldWithConfigurationHandler:^(UITextField *tf) {
                tf.placeholder = @"Key";
                tf.secureTextEntry = YES;
                tf.keyboardAppearance = UIKeyboardAppearanceDark;
            }];

            [alert addAction:[UIAlertAction actionWithTitle:@"VERIFICAR" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSString *key = alert.textFields.firstObject.text;
                
                if ([key isEqualToString:@"WTDFGTHGUER"]) {
                    NSDate *first = [prefs objectForKey:@"fecha_registro_domidios"];
                    if (!first) {
                        first = [NSDate date];
                        [prefs setObject:first forKey:@"fecha_registro_domidios"];
                        [prefs synchronize];
                    }

                    NSTimeInterval elapsed = [[NSDate date] timeIntervalSinceDate:first];
                    if (elapsed > 2592000) {
                        exit(0);
                    } else {
                        %init(ParchesVIP);
                    }
                } else {
                    exit(0);
                }
            }]];
            [rootVC presentViewController:alert animated:YES completion:nil];
        }
    });
}
