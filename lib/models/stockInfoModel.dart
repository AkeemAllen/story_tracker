class StockInfo {
  String companyName;
  String currentPrice;
  String marketCap;
  List<String> revenueArray;
  String profitMargin;
  String cash;
  String debt;
  String shareOutstanding;
  String returnOnEquity;
  String priceToSales;
  String priceToBook;
  String currentRatio;

  StockInfo({
    this.companyName,
    this.currentPrice,
    this.marketCap,
    this.revenueArray,
    this.profitMargin,
    this.cash,
    this.currentRatio,
    this.debt,
    this.priceToBook,
    this.priceToSales,
    this.returnOnEquity,
    this.shareOutstanding,
  });
}
