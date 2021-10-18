import Foundation
import PassKit

@objc public class IonicBraintreeWallet: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
    @objc public func mobileWalletSupported() -> Bool {
         if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex, PKPaymentNetwork.discover]) {
             return true;
         } else {
             return false;
         }
    }
}
