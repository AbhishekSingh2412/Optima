import 'package:flutter/material.dart';
import 'package:optima/screens/auth_screen.dart';
import 'package:optima/screens/item_request_screen.dart';
import 'package:provider/provider.dart';
import 'package:optima/screens/analytics_screen.dart';

import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context);
    return Drawer(
      child: 
      Column(
        children: <Widget>[
        UserAccountsDrawerHeader(
        accountName: Text('Hello there!', style: TextStyle(fontSize: 30),) ,
         //accountEmail: Text(""),
        currentAccountPicture: CircleAvatar(
          backgroundColor:Theme.of(context).primaryColor,
          child: Image.asset('assets/images/optima_logo.png')
        ),
      ),
      ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Shop'),
          onTap: () {
            Navigator.of(context).pushNamed('/');
          }),
      if(!authData.seller)
      ListTile(
          leading: Icon(Icons.payment),
          title: Text('Orders'),
          onTap: () {
            Navigator.of(context).pushNamed(OrdersScreen.routeName);
          }
          ),
          if(!authData.seller)
      ListTile(
          leading: Icon(Icons.note_add),
          title: Text('Request Item'),
          onTap: () {
            Navigator.of(context).pushNamed(ItemRequestScreen.routeName);
          }
          ),
          if(authData.seller)
      ListTile(
          leading: Icon(Icons.edit),
          title: Text('Manage Products'),
          onTap: () {
            Navigator.of(context).pushNamed(UserProductsScreen.routeName);
          }),
          if(authData.seller)
        ListTile(
            leading: Icon(Icons.scatter_plot),
            title: Text('View Analytics'),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new LoadFirebaseStorageImage()));
            }),
      ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () {
            Navigator.of(context).pushNamed(AuthScreen.routeName);
            Provider.of<Auth>(context,listen: false).logout();
          }),
    ]
    )
    );
  }
}
