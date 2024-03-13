/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:party/Users/booking.dart';

class PerviousWork extends StatefulWidget {
  final String title;

  const PerviousWork(this.title, {Key? key}) : super(key: key);

  @override
  State<PerviousWork> createState() => _PerviousWorkState();
}

class _PerviousWorkState extends State<PerviousWork> {
  Color BackColor = Color.fromRGBO(21, 203, 149, 1);
  final List<Map<String, String>> data1 = [
    {'title': 'حفلة زفاف', 'subtitle': 'فى قاعة الماسة', 'image': 'assets/images/hf1.PNG'},
    {'title': 'حفلة سبوع', 'subtitle': 'فى كافية سيليا', 'image': 'assets/images/hf3.PNG'},
    // Add more items as needed
  ];
  final List<Map<String, String>> data2 = [
    {'title': 'حفلة زفاف', 'subtitle': 'فى قاعة الاشارة', 'image': 'assets/images/hf6.PNG'},
    {'title': 'حفلة خطوبة', 'subtitle': 'فى سفينة اندريا', 'image': 'assets/images/hef2.jpg'},
    // Add more items as needed
  ];
  final List<Map<String, String>> data3 = [
    {'title': 'حفلة زفاف', 'subtitle': 'فى قاعة الاشارة', 'image': 'assets/images/hef2.jpg'},
    {'title': 'حفلة خطوبة', 'subtitle': 'فى سفينة اندريا', 'image': 'assets/images/hf1.PNG'},
    // Add more items as needed
  ];
  @override
  Widget build(BuildContext context) {
    if(widget.title=="حسن محمد"){
      return Directionality(
        textDirection: TextDirection.rtl,
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => Scaffold(
            appBar: AppBar(
                backgroundColor: BackColor,
                title: Center(child: Text('الصفحة الرئيسية'))),

            body: Column(

              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Center(
                    child: Text(
                      'سابقة اعمال منسق الحفلات',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30,top:20 ),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Booking()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BackColor, // Button background color.
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Add some spacing between the icon and text
                          Text(
                            'حجز مع منسق',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Icon(
                            Icons
                                .arrow_back_ios_new_outlined, // Icon to use (you can change it to any other icon)
                            size: 30.0, // Adjust the icon size as needed
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 550.0, // Set a fixed height or adjust as needed
                  child: ListView.builder(

                    itemCount: data1.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){

                        },
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[200],
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                data1[index]['image']!,
                                width: 350.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                data1[index]['title']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                data1[index]['subtitle']!,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }else if(widget.title=="سيد محمد"){
      return Directionality(
        textDirection: TextDirection.rtl,
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => Scaffold(
            appBar: AppBar(
                backgroundColor: BackColor,
                title: Center(child: Text('الصفحة الرئيسية'))),

            body: Column(

              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Center(
                    child: Text(
                      'سابقة اعمال منسق الحفلات',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30,top:20 ),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Booking()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BackColor, // Button background color.
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Add some spacing between the icon and text
                          Text(
                            'حجز مع منسق',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Icon(
                            Icons
                                .arrow_back_ios_new_outlined, // Icon to use (you can change it to any other icon)
                            size: 30.0, // Adjust the icon size as needed
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 550.0, // Set a fixed height or adjust as needed
                  child: ListView.builder(

                    itemCount: data1.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){

                        },
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[200],
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                data2[index]['image']!,
                                width: 350.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                data2[index]['title']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                data2[index]['subtitle']!,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }else{
      return Directionality(
        textDirection: TextDirection.rtl,
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => Scaffold(
            appBar: AppBar(
                backgroundColor: BackColor,
                title: Center(child: Text('الصفحة الرئيسية'))),

            body: Column(

              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Center(
                    child: Text(
                      'سابقة اعمال منسق الحفلات',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30,top:20 ),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Booking()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BackColor, // Button background color.
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Add some spacing between the icon and text
                          Text(
                            'حجز مع منسق',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Icon(
                            Icons
                                .arrow_back_ios_new_outlined, // Icon to use (you can change it to any other icon)
                            size: 30.0, // Adjust the icon size as needed
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 550.0, // Set a fixed height or adjust as needed
                  child: ListView.builder(

                    itemCount: data1.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){

                        },
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[200],
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                data3[index]['image']!,
                                width: 350.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                data3[index]['title']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                data3[index]['subtitle']!,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }


  }
}
*/
