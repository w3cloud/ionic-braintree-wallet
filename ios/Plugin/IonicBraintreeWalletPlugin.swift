import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(IonicBraintreeWalletPlugin)
public class IonicBraintreeWalletPlugin: CAPPlugin {
    private let implementation = IonicBraintreeWallet()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }
    @objc func canMakePayments(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "result": implementation.canMakePayments(value)
        ])
    }
    @objc func mobilePay(_ call: CAPPluginCall) {
        let btAuthorization = call.getString("btAuthorization") ?? ""
        do{
            let nonce = try implementation.mobilePay(btAuthorization)
            call.resolve([
                "errMsg": "",
                "nonce": nonce
            ])
            
        }catch MobilePayError.braintreeAuthFailed {
            call.resolve([
                "errMsg": "Braintree Authorization Failed",
                "nonce": ""
            ])
     
        }catch MobilePayError.applePayClientIsNull {
            call.resolve([
                "errMsg": "Apple Pay Client is null",
                "nonce": ""
            ])
     
        }catch {
            call.resolve([
                "errMsg": "MobilePay failed",
                "nonce": ""
            ])
     
        }
  
    }

}
