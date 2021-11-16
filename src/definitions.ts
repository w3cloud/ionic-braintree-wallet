
export interface PaymentSummaryItem{
  label: string;
  amount: number;
}
export interface MobilePayOptions{
  btAuthorization: string;
  merchantId: string; //Google MerchantID. Only needed for GPay
  paymentSummaryItems: PaymentSummaryItem[];
}

export interface MobilePayResult{
  nonce: string;
  contactFirstName: string;
  contactLastName: string;
  contactPhone: string;
  contactEmail: string;
}

export interface IonicBraintreeWalletPlugin {
  canMakePayments(options: { btAuthorization: string }): Promise<{ result: boolean }>;
  mobilePay(options: MobilePayOptions): Promise<MobilePayResult>;

}
