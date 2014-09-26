require 'uri'
require 'net/https'
require 'json'
require 'base64'

class BitbankPay
  API_URI = 'https://api.bitbankpay.jp/api/v1/'

  def initialize(api_key)
    @api_key = api_key
    @uri = URI(API_URI)
    @https = Net::HTTP.new @uri.host, @uri.port
    @https.use_ssl = true
    @https.verify_mode = OpenSSL::SSL::VERIFY_PEER
  end

  def createInvoice(price,currency,itemName,params={})

    params['price'] = price
    params['currency'] = currency
    params['item_name'] = itemName

    request = Net::HTTP::Post.new(@uri.path+'invoice', initheader = {'Content-Type' =>'application/json','Authorization' => "Basic " + Base64.strict_encode64(@api_key)})
    request['Content-Type'] = 'application/json'
    request.body = params.to_json
    response = @https.request request
    JSON.parse response.body
  end

  def acceptBitcoin(id)

    uuids = {0 => id}
    params = {'uuid' => uuids}

    request = Net::HTTP::Post.new(@uri.path+'accept_bitcoin', initheader = {'Content-Type' =>'application/json','Authorization' => "Basic " + Base64.strict_encode64(@api_key)})
    request['Content-Type'] = 'application/json'
    request.body = params.to_json
    response = @https.request request
    JSON.parse response.body
  end

  def acceptJpyYen(id)

    uuids = {0 => id}
    params = {'uuid' => uuids}

    request = Net::HTTP::Post.new(@uri.path+'accept_jpyyen', initheader = {'Content-Type' =>'application/json','Authorization' => "Basic " + Base64.strict_encode64(@api_key)})
    request['Content-Type'] = 'application/json'
    request.body = params.to_json
    response = @https.request request
    JSON.parse response.body
  end

end
