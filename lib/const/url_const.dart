class UrlConst {
  static const baseUrl = 'https://api.coingecko.com/api/v3/coins/';
  static const newsUrl = 'https://newsapi.org/v2/';
  static const list = "markets";
  static const charUrl =
      'https://www.tradingview.com/widgetembed/?symbol=COINBASE:';
  static const chartQuery =
      '&interval=60&hidesidetoolbar=1&saveimage=1&toolbarbg=F1F3F6';
  static const wssDetailUrl = 'wss://ws-feed.exchange.coinbase.com';
  static String getWssMessage(String symbol) {
    return '{"type": "subscribe", "product_ids": ["$symbol-USD"], "channels": ["ticker"]}';
  }
}
