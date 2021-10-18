import { registerPlugin } from '@capacitor/core';

import type { IonicBraintreeWalletPlugin } from './definitions';

const IonicBraintreeWallet = registerPlugin<IonicBraintreeWalletPlugin>(
  'IonicBraintreeWallet',
  {
    web: () => import('./web').then(m => new m.IonicBraintreeWalletWeb()),
  },
);

export * from './definitions';
export { IonicBraintreeWallet };
