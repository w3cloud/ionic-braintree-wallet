# ionic-braintree-wallet

Ionic Capacitor Plugin to show native mobile wallet dialogs like ApplePay, Google pay, then get the nonce using the Braintree native api.

## Install

```bash
npm install ionic-braintree-wallet
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`canMakePayments(...)`](#canmakepayments)
* [`mobilePay(...)`](#mobilepay)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => any
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>any</code>

--------------------


### canMakePayments(...)

```typescript
canMakePayments(options: { value: string; }) => any
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

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

| Prop                  | Type                |
| --------------------- | ------------------- |
| **`btAuthorization`** | <code>string</code> |


#### MobilePayResult

| Prop         | Type                |
| ------------ | ------------------- |
| **`errMsg`** | <code>string</code> |
| **`nonce`**  | <code>string</code> |

</docgen-api>
