import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/models/login_request.dart';
import 'package:getx/services/api_services.dart';
import 'package:getx/views/register_page.dart';
import 'package:getx/views/shopping_page.dart';


class Login extends StatefulWidget {


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey= GlobalKey<FormState>();
 late final LoginRequestModel model;


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

  Widget BuildEmail(){
    return  Column(
      children: [
        TextFormField(

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
              hintText: 'Enter your username',
              hintStyle:
              TextStyle(fontWeight: FontWeight.values[1], color: Colors.grey[500])),
        )
      ],
    );

  }
  Widget BuildPassword(){
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
          obscureText: true,
          style: TextStyle(fontWeight: FontWeight.values[1]),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock_outlined,
                color: Colors.grey[300],
              ),
              hintText: 'Enter your Password',
              hintStyle:
              TextStyle(fontWeight: FontWeight.values[1], color: Colors.grey[500])),
        )
      ],
    );
  }

  Widget ForgotPassword(){
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: InkWell(onTap: (){}, child: Text('Forgot Password?', style: TextStyle(fontWeight: FontWeight.values[1]),)),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 150, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Sign in with your email and password',
                style:
                TextStyle(fontSize: 16, fontWeight: FontWeight.values[1]),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                  key: _formKey,
                  child:
                  Column(children: [
                    BuildEmail(),
                    SizedBox(height: 30.0),
                    BuildPassword(),
                  ],)
              ),
              SizedBox(height: 20.0),
              ForgotPassword(),
              SizedBox(height: 20,),
              Container(
                height: 45,
                width: 370,
                child: FlatButton(
                  onPressed: (){
                    if(validateAndSave()){
                      setState(() {
                        isAPIcallProcess= true;
                      });
                      LoginRequestModel model= LoginRequestModel();
                    }
                    APIService.login(model).then((response) {
                      if(response){
                        Get.to(ShoppingPage());
                      }
                      else{
                        printError(info: 'Invalid credentials');
                      }
                    });

                  }, child: Text('Login', style: TextStyle(color: Colors.white),),
                  color: Colors.blue[500],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)
                  ),

                ),

              ),
              SizedBox(height: 30,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont have an account?', style: TextStyle(fontWeight: FontWeight.values[3]),),
                  SizedBox(width:2,),
                  InkWell(onTap: (){
                    Get.to(RegisterPage());
                  }, child: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.values[3], color: Colors.blue[400]),),)
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}
