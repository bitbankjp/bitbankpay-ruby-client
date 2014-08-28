require 'uri'
require 'net/https'
require 'json'
require 'base64'

class BitcheckPay
  API_URI = 'https://settlement.bitcheck.jp/api/v1/'

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

end
