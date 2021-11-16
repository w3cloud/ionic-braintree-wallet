package com.w3cloud.ionic.braintree.wallet;


import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import androidx.activity.result.ActivityResult;
import androidx.annotation.Nullable;

import com.braintreepayments.api.BraintreeClient;
import com.braintreepayments.api.GooglePayClient;
import com.braintreepayments.api.GooglePayRequest;

import com.braintreepayments.api.GooglePayRequestPaymentCallback;
import com.getcapacitor.JSArray;
import com.getcapacitor.JSObject;


import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.ActivityCallback;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.google.android.gms.wallet.TransactionInfo;
import com.google.android.gms.wallet.WalletConstants;

import org.json.JSONObject;

@CapacitorPlugin(name = "IonicBraintreeWallet")
public class IonicBraintreeWalletPlugin extends Plugin {

    private BraintreeClient braintreeClient;
    private GooglePayClient gPayClient;

    @PluginMethod
    public void canMakePayments(PluginCall call) {
        String btAuthorization = call.getString("btAuthorization");
        if (btAuthorization==null){
            call.reject("Option btAuthorization is required");
            return;
        }
        JSObject ret = new JSObject();

        braintreeClient=new BraintreeClient(this.getContext(),btAuthorization);

        gPayClient =new GooglePayClient(braintreeClient);

        gPayClient.isReadyToPay(this.getActivity(), (isReadyToPay, error) -> {
            if (error!=null){
                call.reject("isReadyToPay error: "+error.getMessage());
                return;
            }
            if (isReadyToPay) {
                ret.put("result", true);
            }else{
               ret.put("result", false);
            }
            call.resolve(ret);
            return;
        });

    }

    @PluginMethod
    public void mobilePay(PluginCall call) {
        try{
            String merchantId = call.getString("merchantId");
            if (merchantId==null){
                call.reject("Option merchantId is required for GPay");
                return;
            }
            String btAuthorization = call.getString("btAuthorization");
            if (merchantId==null){
                call.reject("Option btAuthorization is required for GPay");
                return;
            }

            Log.d("mobilePay","Merchant id: "+merchantId);

            JSArray paymentSummaryItems=call.getArray("paymentSummaryItems");

            int l=paymentSummaryItems.length();

            // Last item will the order total
            JSONObject lastItem=paymentSummaryItems.getJSONObject(
                    paymentSummaryItems.length()-1
            );
            double totalPrice=lastItem.getDouble("amount");
            String merchantName=lastItem.getString("label");

            Log.d("mobilePay","totalPrice: "+totalPrice);

            Intent intent=new Intent(getContext(), GooglePayActivity.class);
            intent.putExtra("merchantId", merchantId);
            intent.putExtra("btAuthorization", btAuthorization);
            intent.putExtra("totalPrice", totalPrice);
            intent.putExtra("merchantName", merchantName);



            startActivityForResult(call, intent, "gPayResult");



        }catch(Throwable throwable) {
            call.reject("Mobile Pay Error"+throwable.getMessage());
        }
    }
    @ActivityCallback
    private void gPayResult(PluginCall call, ActivityResult result) {
        if (call == null) {
            return;
        }
        if (result.getResultCode()==Activity.RESULT_OK){
            String nonce=result.getData().getStringExtra("nonce");

            Log.d("mobilePay", "OK; "+nonce);
            JSObject jsObject=new JSObject();
            Bundle bundle = result.getData().getExtras();
            if (bundle != null) {
                for (String key : bundle.keySet()) {
                    String v=bundle.getString(key);
                    if (v!=null){
                        jsObject.put(key, v);
                    }
                }
            }
            jsObject.put("nonce", nonce);
            call.resolve(jsObject);
        }else{
            Log.d("mobilePay", "Not OK");
            String errMsg=result.getData().getStringExtra("errMsg");
            call.reject("gPayActivity error: "+errMsg);
        }
    }

}
