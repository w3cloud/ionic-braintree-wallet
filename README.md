# ionic-braintree-wallet

Ionic Capacitor Plugin to show native mobile wallet dialogs like ApplePay, Google pay, then get the nonce using the Braintree native api.

## Building

 * Clone this project into your local folder.
 * From command prompt go to the project folder.
 * Build the project: npm run build


### Install

Go to your project that uses this package.

```bash
npm install ionic-braintree-wallet
npx cap sync
```

## API

<docgen-index>

* [`canMakePayments(...)`](#canmakepayments)
* [`mobilePay(...)`](#mobilepay)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### canMakePayments(...)

```typescript
canMakePayments(options: { btAuthorization: string; }) => Promise<{ result: boolean; }>
```

| Param         | Type                                      |
| ------------- | ----------------------------------------- |
| **`options`** | <code>{ btAuthorization: string; }</code> |

**Returns:** <code>Promise&lt;{ result: boolean; }&gt;</code>

--------------------


### mobilePay(...)

```typescript
mobilePay(options: MobilePayOptions) => Promise<MobilePayResult>
```

| Param         | Type                                                          |
| ------------- | ------------------------------------------------------------- |
| **`options`** | <code><a href="#mobilepayoptions">MobilePayOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#mobilepayresult">MobilePayResult</a>&gt;</code>

--------------------


### Interfaces


#### MobilePayResult

| Prop                   | Type                |
| ---------------------- | ------------------- |
| **`nonce`**            | <code>string</code> |
| **`contactFirstName`** | <code>string</code> |
| **`contactLastName`**  | <code>string</code> |
| **`contactPhone`**     | <code>string</code> |
| **`contactEmail`**     | <code>string</code> |


#### MobilePayOptions

| Prop                      | Type                              |
| ------------------------- | --------------------------------- |
| **`btAuthorization`**     | <code>string</code>               |
| **`merchantId`**          | <code>string</code>               |
| **`paymentSummaryItems`** | <code>PaymentSummaryItem[]</code> |


#### PaymentSummaryItem

| Prop         | Type                |
| ------------ | ------------------- |
| **`label`**  | <code>string</code> |
| **`amount`** | <code>number</code> |

</docgen-api>
