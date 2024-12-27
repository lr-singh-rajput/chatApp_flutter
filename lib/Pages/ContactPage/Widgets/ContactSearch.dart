import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactSearch extends StatelessWidget {
  const ContactSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Expanded(
                child: TextField(
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) => {
                    print(value)
                  },
                  decoration: InputDecoration(
                      hintText: "Search contacts",
                      prefixIcon: Icon(Icons.search)
                  ),
                )
            ),
          ],
        )
    );
  }
}
