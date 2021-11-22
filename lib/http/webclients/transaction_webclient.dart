import 'dart:convert';

import 'package:flutter_web_api/models/transaction.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
    List<Transaction> transactions = _toTransactions(response);
    return transactions;
    //debugPrint('decoded json $decodedJson');
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client
        .post(
          Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'password': '1000',
          },
          body: transactionJson,
        )
        .timeout(const Duration(seconds: 5));

    return _toTransaction(response);
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transactions = [];
    for (Map<String, dynamic> transactionJson in decodedJson) {
      transactions.add(Transaction.fromJson(transactionJson));
    }
    return transactions;
  }

  Transaction _toTransaction(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return Transaction.fromJson(json);
  }
}
