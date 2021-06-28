import 'package:flutter/material.dart';
import 'package:zksc/screens/request.dart';

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Agreement Form',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 5.0,
        ),
        backgroundColor: Colors.grey[400],
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Stocks Consulting Trading and Recommendation Process:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* SMS/Whatsapp message is sent to clients with recommendation to buy or sell.'),
                SizedBox(
                  height: 10,
                ),
                Text('* Clients send trade details after trading.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* Clients send copy of trading sheet/bills through email/whatsapp snapshot.'),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Transactions recording maintainance:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* Data of trades and shares holdings is maintained by us and provided on query or verification.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* We can assist in making new trading/investment account.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* Clients can keep their account with the brokerage house.'),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Terms and conditions:                           ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* Commission is calculated on all trades (profit/loss on shares traded and held based on market value).'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* Capital Gain Tax is not adjusted in net profit position.'),
                SizedBox(
                  height: 10,
                ),
                Text('* Commission rates on net profit is only 8%.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* 1% of total investment amount will be deposited as advance commission.'),
                SizedBox(
                  height: 10,
                ),
                Text('* Bonus shares are considered as buying on zero rate.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* Commission settled at quarter end i.e 31-March, 30-June, 30-September, 31-December.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* Clients can withdraw any amount but will need to inform first.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "* Clients will not sell any company's shares in loss without consulting. In case he sells will be considered void due to selling without consent. "),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* We deny our clients to sell in loss for fundamental or technical reasons which client has to discuss when required.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* If a member does not sell as per sale call or does not update app in 48 hours, we will mark sale as at average sale rate of members during last 48 hours.'),
                SizedBox(
                  height: 10,
                ),
                Text('* We do not make our clients invest in garbage stocks.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* We make clients invest in growth and fundamentally strong companies only.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* In case of loss in any quarter or net profit goes into loss, we hold and go into next quarter.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* Commission is paid only if due in 10 days i.e. till 10 April, July, October, January.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '* Clients can add investment amounts later on if comfortable.'),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Colors.grey[700],
                        child:
                            Text('Back', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.black,
                        child: Text('Accept',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Request()));
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )));
  }
}
