import 'package:flutter/material.dart';
import 'package:flutter_web_api/components/centered_message.dart';
import 'package:flutter_web_api/components/progress.dart';
import 'package:flutter_web_api/http/webclients/transaction_webclient.dart';
import 'package:flutter_web_api/models/transaction.dart';

const String _erroDesconhecido = 'Unknown error';

class TransactionsList extends StatelessWidget {
  TransactionsList({Key? key}) : super(key: key);
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    // transactions.add(Transaction(100.0, Contact(0, 'Alex', 1000)));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _webClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transaction> transactions = snapshot.data as List<Transaction>;
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.monetization_on),
                          title: Text(
                            transaction.value.toString(),
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transaction.contact.accountNumber.toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: transactions.length,
                  );
                } else {
                  return const CenteredMessage(
                    'transactions not found',
                    icon: Icons.warning,
                  );
                }
              }
          }
          return const CenteredMessage(
            _erroDesconhecido,
            icon: Icons.announcement,
          );
        },
      ),
    );
  }
}
