# crypto_price_list

2025 Flutter Advanced class (Medium practical project)

<b>Api docs</b>

1. listing api
https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&price_change_percentage=1h,24h,7d&per_page=10&page=1&order=volume_desc

2. detail api
https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&community_data=false&developer_data=false&sparkline=false

coin base web socket (optional)
wscat -c wss://ws-feed.exchange.coinbase.com

{"type": "subscribe", "product_ids": ["BTC-USD"], "channels": ["ticker"]}

3. chart
https://www.tradingview.com/widgetembed/?symbol=COINBASE:BTCUSD&interval=60&hidesidetoolbar=1&saveimage=1&toolbarbg=F1F3F6

4.websocket
wscat -c wss://stream.binance.com:9443/ws/btcusdt@ticker

5. newsapi.org
