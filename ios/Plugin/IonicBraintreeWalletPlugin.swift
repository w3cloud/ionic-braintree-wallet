import Foundation
import Capacitor
import PassKit
import Braintree

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(IonicBraintreeWalletPlugin)
public class IonicBraintreeWalletPlugin: CAPPlugin, PKPaymentAuthorizationViewControllerDelegate {
    var braintreeClient: BTAPIClient?
    var mobilePayCall: CAPPluginCall?
    var btApplePayClient:BTApplePayClient?
    var vc:PKPaymentAuthorizationViewController?
    public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        print("Did Finish called")
        if !controller.isBeingDismissed {
            controller.dismiss(animated: true, completion: nil)
        }
    }

    public func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
        didAuthorizePayment payment: PKPayment,
        handler completion: @escaping
        (PKPaymentAuthorizationResult) -> Void) {
        print("AuthViewContrl callback called")
        controller.dismiss(animated: true, completion: nil)
        print(payment.billingContact?.name ?? "Not Available")
        self.btApplePayClient?.tokenizeApplePay(payment){ (nonce, error) in
            
            print("AP Nonce: ", nonce?.nonce!, error!)
            if nonce != nil {
                
                self.mobilePayCall?.resolve(
                    [
                        "nonce":nonce?.nonce!,
                        "contactFirstName": (payment.shippingContact?.name?.givenName)!,
                        "contactLastName":
                            (payment.shippingContact?.name?.familyName)!,
                        "contactPhone": payment.shippingContact?.phoneNumber?.stringValue!,
                        "contactEmail": payment.shippingContact?.emailAddress!
                    ])
                
            }else{
                self.mobilePayCall?.reject("Brainree Tokenize payemnt failed", "TokenizePaymentFailed", error)
            }
        }
    }
    
    @objc func canMakePayments(_ call: CAPPluginCall) {
        //let value = call.getString("value") ?? ""
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex, PKPaymentNetwork.discover]) {
            call.resolve([
                "result": true
            ])
        } else {
            call.resolve([
                "result": false
            ])
            
        }
    }
    
    @objc func mobilePay(_ call: CAPPluginCall){
        let btAuthorization = call.getString("btAuthorization")
        if (btAuthorization==nil) {
            call.reject("Option btAuthorization is required")
            return;
         }
        
        print("auth: ", btAuthorization as Any)
        
        self.mobilePayCall = call
        let paymentSummaryItems = call.getArray("paymentSummaryItems")
        var pkPaymentSummaryItems = Array<PKPaymentSummaryItem>()
        
        paymentSummaryItems?.forEach{ (jsValue:JSValue) -> Void in
            let item=jsValue as! Dictionary<String, JSValue>
            let pkPaymentSummaryItem=PKPaymentSummaryItem()
            
            
            pkPaymentSummaryItem.label = item["label"] as! String
            let nsnAmount = item["amount"] as! NSNumber
            pkPaymentSummaryItem.amount=NSDecimalNumber(decimal: nsnAmount.decimalValue)
            
            print(pkPaymentSummaryItem.label, pkPaymentSummaryItem.amount)
            pkPaymentSummaryItems.append(pkPaymentSummaryItem)
        }
        
        
        // BTAPIClient can be initialized in a couple different ways, here's one example:
        
        self.braintreeClient = BTAPIClient(authorization: btAuthorization!)
        
        
        self.btApplePayClient = BTApplePayClient(apiClient: braintreeClient!)
        
        
        self.btApplePayClient?.paymentRequest { [self] (paymentRequest, error) in
            guard paymentRequest != nil else {
                call.reject("AppleClient PaymentRequest Error", "BTApplePayClient", error)
                return
            }
            paymentRequest?.shippingType=PKShippingType.storePickup
            paymentRequest?.requiredShippingContactFields=[PKContactField.name, PKContactField.phoneNumber,PKContactField.emailAddress]
            paymentRequest?.requiredBillingContactFields=[PKContactField.name, PKContactField.phoneNumber,PKContactField.emailAddress]
            
        
            
            paymentRequest?.merchantCapabilities = .capability3DS
            
            paymentRequest?.paymentSummaryItems = pkPaymentSummaryItems
            print("paymentRequest is not null")
            
            self.vc = PKPaymentAuthorizationViewController(
                paymentRequest: paymentRequest!)
            if self.vc==nil{
                call.reject( "PaymentAuthorization is null")
                return
            }else{
                print("Payment Auth View Controller Created")
                self.vc?.delegate=self
                DispatchQueue.main.async { [self] in
                    self.bridge?.viewController?.present(self.vc!, animated: true, completion: nil)
                }
            }
        }
        
    }
}
