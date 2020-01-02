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
        stockInfo.currentPrice = data["price"]["regularMarketOpen"]["raw"];
        stockInfo.marketCap = data["price"]["marketCap"]["raw"];
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
                ? _presentData('Company Name', stockInfo.companyName)
                : Text(''),
            stockInfo.currentPrice != null
                ? _presentData(
                    'Current Price', stockInfo.currentPrice.toString())
                : Text(''),
            stockInfo.marketCap != null
                ? _presentData('Company Name', stockInfo.marketCap.toString())
                : Text(''),
          ],
        ),
      ),
    ));
  }
}
