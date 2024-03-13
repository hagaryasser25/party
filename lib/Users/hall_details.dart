import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:party/Users/booking.dart';

class HallDetails extends StatefulWidget {
  String name;
  String price;
  String phone;
  String place;
  String description;
  String imageUrl;
  HallDetails({
    required this.name,
    required this.price,
    required this.phone,
    required this.place,
    required this.description,
    required this.imageUrl,
  });

  @override
  State<HallDetails> createState() => _HallDetailsState();
}

class _HallDetailsState extends State<HallDetails> {
  Color BackColor = Color.fromRGBO(21, 203, 149, 1);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              backgroundColor: BackColor,
              title: Center(
                  child: Text(
                'قاعة ${widget.name}',
                style: TextStyle(color: Colors.white),
              )),

            ),
          body: SingleChildScrollView(
            child: Column(children: [
              
              SizedBox(
                height: 30.h,
              ),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 15, bottom: 15),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 15.w),
                            child: Image.network('${widget.imageUrl}'),
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: Column(children: [
                    Text(
                      'اسم القاعة : ${widget.name}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'رقم الهاتف : ${widget.phone}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'المنطقة : ${widget.place}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'السعر : ${widget.price}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(
                        right: 20.w,
                        left: 20.w

                      ),
                      child: Text(
                        'تفاصيل القاعة : ${widget.description}',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                  ]),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  padding: const EdgeInsets.all(0.0),
                  elevation: 5,
                ),
                onPressed: () async {
                  
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return Booking(
                      name: '${widget.name}',
                    );
                  }));
                  
                },
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff1bccba), Color(0xff22e2ab)]),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    constraints: const BoxConstraints(minWidth: 88.0),
                    child: const Text("حجز", textAlign: TextAlign.center),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
