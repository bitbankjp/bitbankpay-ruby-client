bitbankpay-ruby-client
=======================

Examples
--------

### createInvoice

```ruby
require './lib/bitbankpay.rb'

client = BitbankPay.new 'API Key'
json = client.createInvoice amount,'currency','item_name', {:order_id => 'order_id', :user_mail => 'mail'}
```

### acceptJpyYen

```ruby
client.acceptJpyYen json["id"]
```
### acceptBitcoin

```ruby
client.acceptBitcoin json["id"]
```
