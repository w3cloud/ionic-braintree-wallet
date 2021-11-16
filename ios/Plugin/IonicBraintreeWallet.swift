import Foundation
import Capacitor
import PassKit
import Braintree
enum MobilePayError: Error {
    case braintreeAuthFailed
    case paymentRequestError
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
    
    @objc public func mobilePay(_ btAuthorization: String, pkPaymentSummaryItems: [PKPaymentSummaryItem], call: CAPPluginCall)-> String {
        var braintreeClient: BTAPIClient?

        // BTAPIClient can be initialized in a couple different ways, here's one example:
        braintreeClient = BTAPIClient(authorization: btAuthorization)
        
        let applePayClient = BTApplePayClient(apiClient: braintreeClient!)
        
        applePayClient.paymentRequest { (paymentRequest, error) in
            guard paymentRequest != nil else {
                   call.resolve([
                    "errMsg": "PaymentRequest Error" + error!.localizedDescription,                       "nonce": ""
                   ])
                   return
               }
            paymentRequest?.requiredBillingContactFields = [.postalAddress]
            
            paymentRequest?.merchantCapabilities = .capability3DS
            
            paymentRequest?.paymentSummaryItems = pkPaymentSummaryItems
 
            
            
        }

        return "Great"

    }

}
