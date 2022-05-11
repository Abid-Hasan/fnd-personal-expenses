import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  const TransactionList(
    this.userTransactions,
    this.deleteTransaction, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? Column(
            children: [
              Text(
                "No transaction added yet",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: FittedBox(
                          child: Text(
                            '\$ ' +
                                userTransactions[index]
                                    .amount
                                    .toStringAsFixed(2),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      userTransactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(
                        userTransactions[index].date,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteTransaction(userTransactions[index].id);
                      },
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                ),
              );
            },
            itemCount: userTransactions.length,
          );
  }
}
