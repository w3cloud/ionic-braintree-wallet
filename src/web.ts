import { WebPlugin } from '@capacitor/core';

import { IonicBraintreeWalletPlugin, MobilePayOptions, MobilePayResult } from './definitions';

export class IonicBraintreeWalletWeb
  extends WebPlugin
  implements IonicBraintreeWalletPlugin {
  async mobilePay(options: MobilePayOptions): Promise<MobilePayResult> {
    console.log('ECHO', options);
    let result: MobilePayResult={
      nonce:'Not Implemented', 
      contactFirstName: 'NA',
      contactLastName: 'NA',
      contactPhone: 'NA',
      contactEmail: 'NA'
    }
    return result;
  }
  async canMakePayments(options: { btAuthorization: string }): Promise<{ result: boolean }> {
    console.log('ECHO', options);
    return { result: false };
  }
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
