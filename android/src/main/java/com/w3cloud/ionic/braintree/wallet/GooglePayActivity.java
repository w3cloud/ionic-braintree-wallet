package com.w3cloud.ionic.braintree.wallet;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.fragment.app.FragmentActivity;

import com.braintreepayments.api.BraintreeClient;
import com.braintreepayments.api.BraintreeRequestCodes;
import com.braintreepayments.api.GooglePayCardNonce;
import com.braintreepayments.api.GooglePayClient;
import com.braintreepayments.api.GooglePayRequest;
import com.braintreepayments.api.GooglePayRequestPaymentCallback;
import com.getcapacitor.JSObject;
import com.google.android.gms.wallet.PaymentData;
import com.google.android.gms.wallet.TransactionInfo;
import com.google.android.gms.wallet.WalletConstants;

import org.json.JSONObject;

public class GooglePayActivity extends FragmentActivity {
    private BraintreeClient braintreeClient;
    GooglePayClient gPayClient;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.d("mobilePay", "onCreateEnter");
        this.launchGPay();
    }

    @Override
    protected void onStart() {
        super.onStart();
    }

    private void launchGPay(){
        try{

            // Get parameters
            Intent intent=getIntent();
            String merchantId = intent.getStringExtra("merchantId");
            double totalPrice=intent.getDoubleExtra("totalPrice", 0.0);
            String btAuthorization=intent.getStringExtra("btAuthorization");
            String merchantName=intent.getStringExtra("merchantName");
            Log.d("mobilePay", "launchGPay: "+merchantId+ "; "+totalPrice+"; "+btAuthorization);


            GooglePayRequest gPayRequest = new GooglePayRequest();
            gPayRequest.setEmailRequired(true);
            gPayRequest.setPhoneNumberRequired(true);
            gPayRequest.setBillingAddressRequired(true);
            gPayRequest.setGoogleMerchantId(merchantId);
            gPayRequest.setGoogleMerchantName(merchantName);

            gPayRequest.setTransactionInfo(TransactionInfo.newBuilder()
                    .setTotalPrice(Double.toString(totalPrice))
                    .setCurrencyCode("USD")
                    .setTotalPriceStatus(WalletConstants.TOTAL_PRICE_STATUS_FINAL)
                    .build());
            braintreeClient=new BraintreeClient(getApplicationContext(),btAuthorization);
            gPayClient=new GooglePayClient(braintreeClient);

            gPayClient.requestPayment(this, gPayRequest,
                    new GooglePayRequestPaymentCallback(){

                        @Override
                        public void onResult(@Nullable Exception error) {
                            if (error!=null){
                                finishWithError("requestPayment error. "+error.getMessage());
                            }

                        }
                    });
        }catch(Throwable throwable) {
            Log.e("mobilePay","Throwable Caught: "+throwable.getMessage());
            finishWithError("launchGPay Error: "+throwable.getMessage());
        }
    }
    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode != BraintreeRequestCodes.GOOGLE_PAY){
            return;
        }
        try {
            Log.d("mobilePay", "GPayActivityResult returned");
            Log.d("mobilePay", "Request Code: " + requestCode + "; Result Code:" + resultCode);
            switch (resultCode) {
                case RESULT_OK:
                    PaymentData pd = PaymentData.getFromIntent(data);
                    Log.d("mobilePay", "Email:" + pd.toJson());
                    JSONObject jo = new JSObject(pd.toJson());
                    JSONObject billingAddress=
                            jo.getJSONObject("paymentMethodData")
                            .getJSONObject("info")
                            .getJSONObject("billingAddress");

                    String email = jo.getString("email");
                    String phone = billingAddress.getString("phoneNumber");
                    String name = billingAddress.getString("name");
                    String toks[]=name.split(" ");
                    String firstName=toks[0];
                    String lastName;
                    if (toks.length>1){
                        lastName = toks[toks.length-1];
                    } else{
                        lastName = "";
                    }
                    Log.d("mobilePay", "Email ID:" + email);


                    gPayClient.onActivityResult(resultCode, data, (paymentMethodNonce, error) -> {
                        // send paymentMethodNonce.getString() to your server

                        Log.d("mobilePay", "onActivityResult Nonce: " + paymentMethodNonce.getString());


                        Intent intent = getIntent();
                        intent.putExtra("nonce", paymentMethodNonce.getString());
                        intent.putExtra("contactFirstName", firstName);
                        intent.putExtra("contactLastName", lastName);
                        intent.putExtra("contactPhone", phone);
                        intent.putExtra("contactEmail", email);
                        setResult(RESULT_OK, intent);
                        finish();
                    });
                    break;
                case RESULT_CANCELED:
                    finishWithError("User Cancelled.");
                    break;
                default:
                    finishWithError("onActivityResult error: "+data.toString());
                    break;
            }



        }catch(Throwable throwable){
            this.finishWithError("onActivityResult error: "+throwable.getMessage());
        }

    }
    private void finishWithError(String errMsg){
        Log.d("mobilePay", "finishwithError"+errMsg);
        Intent intent = getIntent();
        intent.putExtra("errMsg", errMsg);
        setResult(RESULT_CANCELED, intent);
        finish();
    }
}
