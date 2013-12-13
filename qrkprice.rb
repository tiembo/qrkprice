require 'json'
require 'curb'

btcusd_url1 = 'https://btc-e.com/api/2/btc_usd/ticker'
btcusd_url2 = 'https://coinbase.com/api/v1/currencies/exchange_rates'
#qrkbtc_url = 'http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=71'
qrkbtc_url = 'https://www.coins-e.com/api/v2/markets/data/'

# fetch BTC/USD data
btc_html = Curl.get(btcusd_url1).body_str
btcusd1 = JSON.parse(btc_html)['ticker']['avg'].to_f
btc_html = Curl.get(btcusd_url2).body_str
btcusd2 = JSON.parse(btc_html)['btc_to_usd'].to_f

#debug
#puts btcusd1
#puts btcusd2

btcusd = (btcusd1 + btcusd2) / 2

# fetch QRK/BTC data
qrk_html = Curl.get(qrkbtc_url).body_str
#qrkbtc = JSON.parse(qrk_html)['return']['markets']['QRK']['lasttradeprice'].to_f
qrkbtc = JSON.parse(qrk_html)['markets']['QRK_BTC']['marketstat']['24h']['avg_rate'].to_f

# print outputs
qrkusd = btcusd * qrkbtc
puts "1 BTC = #{btcusd} USD"
puts "1 QRK = #{qrkbtc} BTC"
puts "1 QRK = #{qrkusd} USD"
