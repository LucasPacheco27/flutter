import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screen15_pro-version.dart';

class Payment extends StatefulWidget {
  @override
  State<Payment> createState() => _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState extends State<Payment> {
  int selectedCard = 0;
  bool sameAddress = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _CustomBottomNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,

        toolbarHeight: 35, // Gizle, çünkü üstte özel bir alan var
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom indicator bar
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProVPage()),
                      );
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Checkout',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StepCircle(
                    icon: Icons.shopping_bag,
                    label: "Your bag",
                    isActive: true,
                  ),
                  _LineDivider(),
                  _StepCircle(
                    icon: Icons.local_shipping,
                    label: "Shipping",
                    isActive: true,
                  ),
                  _LineDivider(),
                  _StepCircle(
                    icon: Icons.payment,
                    label: "Payment",
                    isActive: true,
                  ),
                  _LineDivider(),
                  _StepCircle(
                    icon: Icons.receipt,
                    label: "Review",
                    isActive: false,
                  ),
                ],
              ),
              SizedBox(height: 24),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF5A9EFE)),
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFF8FAFF),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose a payment method',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                        children: [
                          TextSpan(
                            text:
                                'You won’t be charged until you review the order on the ',
                          ),
                          TextSpan(
                            text: 'next page',
                            style: TextStyle(
                              color: Color(0xFF5A9EFE),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22),
              // Credit Card Section
              Text(
                "Credit Card",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              _creditCardList(),
              SizedBox(height: 14),
              GestureDetector(
                onTap: () {
                  // Add new card
                },
                child: Row(
                  children: [
                    Icon(Icons.add, size: 20, color: Color(0xFF5A9EFE)),
                    SizedBox(width: 6),
                    Text(
                      "Add new card",
                      style: TextStyle(
                        color: Color(0xFF5A9EFE),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: sameAddress,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onChanged: (val) => setState(() => sameAddress = val!),
                  ),
                  Expanded(
                    child: Text(
                      "My billing address is the same as my shipping address",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 14),
                  child: Row(
                    children: [
                      Icon(Icons.radio_button_unchecked, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        "Apple Pay",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE8EAFF),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: Color(0xFF4A60D2),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _creditCardList() {
    return Column(
      children: [
        _CreditCardTile(
          selected: selectedCard == 0,
          brandLogo: Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/0/04/Mastercard-logo.png",
            width: 36,
            height: 24,
          ),
          cardType: "Mastercard",
          cardNumber: "xxxx xxxx xxxx 1234",
          onTap: () => setState(() => selectedCard = 0),
        ),
        SizedBox(height: 8),
        _CreditCardTile(
          selected: selectedCard == 1,
          brandLogo: Image.network(
            "https://imgs.search.brave.com/07Oa3VE3KgXoeFE6FWHgJjt3MKgpPcdGMfd0Q2lbwOM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMudmVjdGVlenku/Y29tL3N5c3RlbS9y/ZXNvdXJjZXMvdGh1/bWJuYWlscy8wMjAv/OTc1LzU3MC9zbWFs/bC92aXNhLWxvZ28t/dmlzYS1pY29uLXRy/YW5zcGFyZW50LWZy/ZWUtcG5nLnBuZw",
            width: 36,
            height: 24,
          ),
          cardType: "Visa",
          cardNumber: "xxxx xxxx xxxx 9876",
          onTap: () => setState(() => selectedCard = 1),
        ),
      ],
    );
  }
}

class _CreditCardTile extends StatelessWidget {
  final bool selected;
  final Widget brandLogo;
  final String cardType;
  final String cardNumber;
  final VoidCallback onTap;

  const _CreditCardTile({
    required this.selected,
    required this.brandLogo,
    required this.cardType,
    required this.cardNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? Color(0xFFE8EAFF) : Colors.white,
          border: Border.all(
            color: selected ? Color(0xFF4A60D2) : Colors.grey.shade300,
            width: selected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected ? Color(0xFF4A60D2) : Colors.grey,
            ),
            SizedBox(width: 10),
            brandLogo,
            SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardType,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                Text(
                  cardNumber,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
              ],
            ),
            Spacer(),
            if (selected) Icon(Icons.check_circle, color: Color(0xFF4A60D2)),
          ],
        ),
      ),
    );
  }
}

class _StepCircle extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  const _StepCircle({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: isActive ? Color(0xFF4A60D2) : Colors.grey.shade300,
          child: Icon(icon, size: 18, color: Colors.white),
        ),
        SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Color(0xFF4A60D2) : Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _LineDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 2,
      color: Colors.grey.shade300,
      margin: EdgeInsets.symmetric(horizontal: 2),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavBarIcon(icon: Icons.stacked_line_chart, label: "Stock"),
          _NavBarIcon(icon: Icons.currency_bitcoin, label: "Crypto"),
          _NavBarIcon(icon: Icons.home, label: "Home", isActive: true),
          _NavBarIcon(icon: Icons.store_mall_directory, label: "Market"),
          _NavBarIcon(icon: Icons.person, label: "Profile"),
        ],
      ),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  const _NavBarIcon({
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 26,
          color: isActive ? Color(0xFF4A60D2) : Colors.black54,
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isActive ? Color(0xFF4A60D2) : Colors.black54,
          ),
        ),
      ],
    );
  }
}
