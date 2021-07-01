
import 'package:flutter/material.dart';
import 'constants.dart';
import 'coin_data.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({@required this.coin,
    @required this.currency, @required this.price
  });

  final String currency;
  final String coin;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(9,9,9,0),
      child: Card(
        color: Color(0xFF707070),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 15, 10),
              child: Image(image: AssetImage('images/$coin.jpg'),
              width: 32.0),
            ),
            Text(cryptoNames[coin], textAlign: TextAlign.center, style: TextStyle(
              fontSize: 18.0
            ),),
            Expanded(

              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  '1 $coin = $price $currency',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}