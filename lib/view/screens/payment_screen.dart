import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:http/http.dart' as http;
import 'package:text_to_image/constants/constants.dart';
import 'package:text_to_image/services/data_services.dart';
import 'package:text_to_image/utils/app_language.dart';
import 'package:text_to_image/utils/global_functions.dart';
import '../../controller/admin_base_controller.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var paymentIntent = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<AdminBaseController>(
              builder:(ctr)=>Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.stars,color: Colors.black,size: 35),
                  SizedBox(width: 15),
                  Text(
                    AppLanguage.STARS + " (${AdminBaseController.userData.value.stars??""})",
                    style: TextStyle(
                        fontFamily: AppFonts.INTER_REGULAR,
                        fontSize: 20),
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
            Text(
              'Pay 1 USD and achieve 20 stars',
              style: TextStyle(
                  fontFamily: AppFonts.INTER_REGULAR,
                  fontSize: 20),
            ),
            SizedBox(height: 15,),
            MaterialButton(
              padding: EdgeInsets.all(10),
              color: AppColors.pinkDark,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              onPressed: () async{
                showLoadingProgress(context);
                await makePayment();
              },
              child: Text('Purchase Stars',style: TextStyle(fontSize: 24,color: Colors.white),),
            ),
          ],
        ),
      )
    );
  }

  Future makePayment() async{
    try{
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent('1','USD');

      //STEP 2: Initialize payment sheet
      await Stripe.instance
      .initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent!['client_secret'],
        style: ThemeMode.light,
        merchantDisplayName: 'Shafiq'
       )
      ).then((value) {});
      Navigator.pop(context);
      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    }catch(e){
      throw Exception(e.toString());
    }

  }

  createPaymentIntent(String amount,String currency) async{
     try {
       //Request body
       Map<String, dynamic> body = {
              'amount' : calculateAmount(amount),
              'currency': currency
       };

       //Make post request to stripe
       var response = await http.post(
         Uri.parse('https://api.stripe.com/v1/payment_intents'),
         headers: {
           'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
           'Content-Type': 'application/x-www-form-urlencoded'
         },
         body: body,
       );
       return jsonDecode(response.body);
     } catch (e) {
       print(e);
     }
  }

  displayPaymentSheet() async{
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async{
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100.0,
                  ),
                  SizedBox(height: 10.0),
                  Text("Payment Successful!"),
                ],
              ),
            ));
        await incrementStars();
        //make payment intent null after a successful payment
        paymentIntent = null;
      }).onError((error, stackTrace) => throw Exception(error));

    }on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    }  catch (e) {
      print(e);
    }
  }

  String calculateAmount(String amount) {
    return ((int.tryParse(amount)?? 0 ) * 100).toString() ;
  }

}