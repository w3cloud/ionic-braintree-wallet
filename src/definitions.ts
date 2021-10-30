
export interface MobilePayOptions{
  btAuthorization: string;
}
export interface MobilePayResult{
  errMsg?: string;
  nonce?: string;
}

export interface IonicBraintreeWalletPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  canMakePayments(options: { value: string }): Promise<{ result: boolean }>;
  mobilePay(options: MobilePayOptions): Promise<MobilePayResult>;

}
