import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './models/stockInfoModel.dart';
import './loader.dart';

class StockInput extends StatefulWidget {
  @override
  _StockInputState createState() => _StockInputState();
}

class _StockInputState extends State<StockInput> {
  final _formKey = GlobalKey<FormState>();
  var stockInfo = StockInfo();
  String _tickerSymbol;
  Map data;
  bool loading = false;
  Loader _loader = Loader();

  Future getStockData() async {
    final String yahooFinanceUrl =
        'https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/get-detail?symbol=$_tickerSymbol';
    // final String alphaVantageUrl =
    //     "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$_tickerSymbol&interval=daily&apikey=C3XV5BAXDU772WS5&time_period=200&series_type=open";
    setState(() {
      loading = true;
    });

    http.Response response = await http.get(
      Uri.encodeFull(yahooFinanceUrl),
      headers: {
        'Accept': 'application/json',
        'x-rapidapi-host': "apidojo-yahoo-finance-v1.p.rapidapi.com",
        'x-rapidapi-key': "61680401b9msh5cdcbb9c3172241p19d5d8jsnd0ccf7301e82"
      },
    );

    data = json.decode(response.body);
    if (data != null) {
      setState(() {
        loading = false;
        stockInfo.companyName = data['price']['longName'];
        stockInfo.currentPrice = data["price"]["regularMarketPrice"]["fmt"];
        stockInfo.marketCap = data["price"]["marketCap"]["fmt"];
        stockInfo.shareOutstanding = data["quoteData"]
            [_tickerSymbol.toUpperCase()]["sharesOutstanding"]["fmt"];
        stockInfo.debt = data["financialData"]["totalDebt"]["fmt"];
        stockInfo.priceToBook =
            data["defaultKeyStatistics"]["priceToBook"]["fmt"];
        stockInfo.priceToSales =
            data["summaryDetail"]["priceToSalesTrailing12Months"]["fmt"];
        stockInfo.profitMargin = data["financialData"]["profitMargins"]["fmt"];
        stockInfo.returnOnEquity =
            data["financialData"]["returnOnEquity"]["fmt"];
        stockInfo.cash = data["financialData"]["totalCash"]["fmt"];
        stockInfo.currentRatio = data["financialData"]["currentRatio"]["fmt"];
        stockInfo.revenueArray = [];
        for (var element in data["earnings"]["financialsChart"]["yearly"]) {
          stockInfo.revenueArray.add(element['revenue']['fmt']);
        }
      });
    }
    print(response.statusCode);
  }

  Widget _presentData(label, data) {
    return ListTile(
      title: Text(label),
      trailing: Text(data),
      onTap: () {
        print('Pressed');
      },
    );
  }

  void _showStatistics() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
              title: Text(_tickerSymbol.toUpperCase() + ' company data')),
          body: ListView(
            children: <Widget>[
              _presentData('Company Name', stockInfo.companyName),
              _presentData('Current Price', stockInfo.currentPrice),
              _presentData('Market Cap', stockInfo.marketCap),
              _presentData('Shares Outstanding', stockInfo.shareOutstanding),
              _presentData('Total Cash', stockInfo.cash),
              _presentData('Total Debt', stockInfo.debt),
              _presentData('Profit Margin', stockInfo.profitMargin),
              _presentData('ROE', stockInfo.returnOnEquity),
              _presentData('Current Ratio', stockInfo.currentRatio),
              _presentData('P/B', stockInfo.priceToBook),
              _presentData('P/S', stockInfo.priceToSales),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Ticker Symbol',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Ticker Symbol';
                }
                return null;
              },
              onSaved: (value) => _tickerSymbol = value,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    getStockData();
                  }
                },
                child: Text('Submit'),
              ),
            ),
            Center(
              child: loading == true ? _loader : Text(''),
            ),
            stockInfo.companyName != null
                ? RaisedButton(
                    child: Text('Show Statistics'),
                    onPressed: () {
                      _showStatistics();
                    },
                  )
                : Text(''),
          ],
        ),
      ),
    ));
  }
}
