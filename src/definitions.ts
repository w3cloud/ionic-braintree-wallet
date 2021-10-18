export interface IonicBraintreeWalletPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
