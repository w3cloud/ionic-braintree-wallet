import { WebPlugin } from '@capacitor/core';

import { IonicBraintreeWalletPlugin, MobilePayOptions, MobilePayResult } from './definitions';

export class IonicBraintreeWalletWeb
  extends WebPlugin
  implements IonicBraintreeWalletPlugin {
  async mobilePay(options: MobilePayOptions): Promise<MobilePayResult> {
    console.log('ECHO', options);
    let result: MobilePayResult={
      errMsg:'Not Implemented'
    }
    return result;
  }
  async canMakePayments(options: { value: string }): Promise<{ result: boolean }> {
    console.log('ECHO', options);
    return { result: false };
  }
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
