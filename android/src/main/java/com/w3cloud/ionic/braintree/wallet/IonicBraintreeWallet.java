package com.w3cloud.ionic.braintree.wallet;

import android.util.Log;

public class IonicBraintreeWallet {

    public String echo(String value) {
        Log.i("Echo", value);
        return value;
    }
    public boolean mobileWalletSupported() {
        Log.i("Echo", value);
        return false;
    }

}
