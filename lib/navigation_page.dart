import 'package:flutter/material.dart';
import 'package:business_card/aboutus_page.dart';
import 'package:business_card/contactus_page.dart';
import 'package:business_card/home_page.dart';
import 'package:business_card/payment_details_page.dart';
import 'package:business_card/portfolio_page.dart';
import 'package:business_card/services_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NavigationPageState();
  }
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const AboutUsPage(),
    const ServicePage(),
    PortfolioPage(),
    const PaymentDetailsPage(),
    const ContactUsPage(),
  ];

  bool _isLoading = false;

  void _onItemTapped(int index) {
    setState(() {
      _isLoading = true; // Set loading state when navigation occurs
      _selectedIndex = index;
    });
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false; // Reset loading state after delay
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 900),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: _pages[_selectedIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                label: 'About Us',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.work),
                label: 'Services',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Portfolio',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                label: 'Payment Details',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.contact_page),
                label: 'Contact Us',
                backgroundColor: Colors.black,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
