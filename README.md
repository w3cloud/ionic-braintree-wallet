# ionic-braintree-wallet

Ionic Capacitor Plugin to show native mobile wallet dialogs like ApplePay, Google pay, then get the nonce using the Braintree native api.

## Install

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
canMakePayments(options: { btAuthorization: string; }) => any
```

| Param         | Type                                      |
| ------------- | ----------------------------------------- |
| **`options`** | <code>{ btAuthorization: string; }</code> |

**Returns:** <code>any</code>

--------------------


### mobilePay(...)

```typescript
mobilePay(options: MobilePayOptions) => any
```

| Param         | Type                                                          |
| ------------- | ------------------------------------------------------------- |
| **`options`** | <code><a href="#mobilepayoptions">MobilePayOptions</a></code> |

**Returns:** <code>any</code>

--------------------


### Interfaces


#### MobilePayOptions

| Prop                      | Type                |
| ------------------------- | ------------------- |
| **`btAuthorization`**     | <code>string</code> |
| **`merchantId`**          | <code>string</code> |
| **`paymentSummaryItems`** | <code>{}</code>     |


#### PaymentSummaryItem

| Prop         | Type                |
| ------------ | ------------------- |
| **`label`**  | <code>string</code> |
| **`amount`** | <code>number</code> |


#### MobilePayResult

| Prop                   | Type                |
| ---------------------- | ------------------- |
| **`nonce`**            | <code>string</code> |
| **`contactFirstName`** | <code>string</code> |
| **`contactLastName`**  | <code>string</code> |
| **`contactPhone`**     | <code>string</code> |
| **`contactEmail`**     | <code>string</code> |

</docgen-api>
