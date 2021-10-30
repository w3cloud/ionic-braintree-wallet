import Foundation
import PassKit
import Braintree
enum MobilePayError: Error {
    case braintreeAuthFailed
    case applePayClientIsNull
}

@objc public class IonicBraintreeWallet: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
         if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex, PKPaymentNetwork.discover]) {
             return "true";
         } else {
             return "false";
         }
    }
    @objc public func canMakePayments(_ value: String) -> String {
        print(value)
         if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex, PKPaymentNetwork.discover]) {
             return "true";
         } else {
             return "false";
         }
    }
    
    @objc public func mobilePay(_ btAuthorization: String)throws-> String {
        var braintreeClient: BTAPIClient?

        // BTAPIClient can be initialized in a couple different ways, here's one example:
        braintreeClient = BTAPIClient(authorization: btAuthorization)
        if braintreeClient == nil{
            throw MobilePayError.braintreeAuthFailed
            
        }
        
        let applePayClient = BTApplePayClient(apiClient: braintreeClient!)
        if (applePayClient == nil){
            throw MobilePayError.applePayClientIsNull
        }
        
        
        
        return "Great"

    }

}
