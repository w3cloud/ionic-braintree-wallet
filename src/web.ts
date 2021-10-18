import { WebPlugin } from '@capacitor/core';

import type { IonicBraintreeWalletPlugin } from './definitions';

export class IonicBraintreeWalletWeb
  extends WebPlugin
  implements IonicBraintreeWalletPlugin {
  async mobileWalletSupported(): Promise<boolean> {
    return true;
    
  }
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
