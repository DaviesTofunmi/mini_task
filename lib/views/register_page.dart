import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/models/login_request.dart';
import 'package:getx/models/register_request.dart';
import 'package:getx/models/register_response.dart';
import 'package:getx/services/api_services.dart';
import 'package:getx/views/login_page.dart';
import 'package:getx/views/shopping_page.dart';


class RegisterPage extends StatefulWidget {

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterRequestModel model;


  final _formKey= GlobalKey<FormState>();

  get password => password;

  get name => name;

  get email => email;
  bool validateAndSave(){

    final form= _formKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }







  set isAPIcallProcess(bool isAPIcallProcess) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Text(
                  'Register Account',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Please fill in correct details',
                style: TextStyle(fontWeight: FontWeight.values[1]),
              ),
              SizedBox(
                height: 10,
              ),

              SizedBox(height: 30,),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    BuildName(),
                    SizedBox(height: 15,),
                    BuildEmail(),
                    SizedBox(height: 15,),
                    BuildPassword(),
                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(vertical: 55.0),
                child: Container(
                  height: 45,
                  width: 370,
                  child: FlatButton(
                    onPressed: (){
                      if(validateAndSave()){
                        setState(() {
                          isAPIcallProcess= false;
                        });
                        RegisterRequestModel model= RegisterRequestModel(name: name, email: email, password: password);
                      }
                      APIService.register(model).then((response) {
                        if(response.user != null){
                          Get.to(Login());
                          printInfo(info: 'Registration Successfull. Please login to the account');
                        }
                        else{
                          printError(info: 'Invalid credentials');
                        }
                      });


                    }, child: Text('Sign up', style: TextStyle(color: Colors.white),),
                    color: Colors.blue[500],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)
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
}
Widget BuildEmail() {
  return Column(
    children: [
      TextFormField(
        onSaved: (value){
         value;
        },
        key: ValueKey('email'),
        validator: (value){
          if (value!.isEmpty || !value.contains('@')){
            return 'Please enter a valid email address.';
          }
          return null;
        },

        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontWeight: FontWeight.values[1]),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Colors.grey[300],
            ),
            hintText: 'Enter your Email',
            hintStyle:
            TextStyle(
                fontWeight: FontWeight.values[1], color: Colors.grey[500])),
      )
    ],
  );
}


Widget BuildName(){
  return Column(
    children: [
      TextFormField(
        validator: (value){
          if (value!.isEmpty || value.length < 7){
            return 'Name must be at least 4 characters long.';
          }
          return null;
        },
        key: ValueKey('name'),
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontWeight: FontWeight.values[1]),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              CupertinoIcons.profile_circled,
              color: Colors.grey[300],
            ),
            hintText: 'Enter your name',
            hintStyle:
            TextStyle(fontWeight: FontWeight.values[1], color: Colors.grey[500])),
      )
    ],
  );
}

Widget BuildPassword() {
  return Column(
    children: [
      TextFormField(
        validator: (value){
          if (value!.isEmpty || value.length < 7){
            return 'Password must be at least 7 characters long.';
          }
          return null;
        },
        key: ValueKey('password'),
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        style: TextStyle(fontWeight: FontWeight.values[1]),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.grey[300],
            ),
            hintText: 'Enter your password',
            hintStyle:
            TextStyle(
                fontWeight: FontWeight.values[1], color: Colors.grey[500])),
      )
    ],
  );
}

