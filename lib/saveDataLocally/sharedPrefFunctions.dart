
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*
import 'package:sebbo/home/searchTab.dart';
import 'package:sebbo/models/teacherData.dart';
import 'package:teamrapport/teacher/moreInfo/more_info_screen.dart';
import 'package:teamrapport/widgets/teacher_cache_card.dart';

import '../checkUser.dart';
*/
class SharedPrefFunction {
  //code to store number locally
  Future<Null> saveNumberPreference(String number) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('myNumber', number);
  }

  //save bool value of isLogin locally
  Future<Null> saveLoginPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('isLogin', 'true');
  }

  //save bool value of isLogin locally for logout
  Future<Null> saveLogoutPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('isLogin', 'false');
  }

  //save search result
  saveSearchResult(List<String> searchData) async{
    int count = 0;
    SharedPreferences pref = await SharedPreferences.getInstance();
    count = pref.getInt('searchCount');
    if(count== null){
      pref.setInt('searchCount', 1);
      pref.setStringList('teacher0', searchData);
      pref.setStringList('checkTeacher', [searchData[6],'0','0','0','0']);
    }
    else{
      List details = pref.get('checkTeacher');
      List<String> x = [];
      details.forEach((element) {
        x.add(element.toString());
      });
      if(!x.contains(searchData[6])) {
        if (count < 5) {
          pref.setInt('searchCount', count + 1);
          pref.setStringList('teacher' + count.toString(), searchData);
          x[count] = searchData[6];
          pref.setStringList('checkTeacher', x);
        }
        else {
          pref.setInt('searchCount', 1);
          pref.setStringList('teacher0', searchData);
          x[0] = searchData[6];
          pref.setStringList('checkTeacher', x);
        }
      }
    }
  }

  //get isLogin value
  Future<String> getLoginPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('isLogin') != null) {
      return pref.getString('isLogin');
    }
    return null;
  }

  //get number
  Future<String> getNumberPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('myNumber') != null) {
      return pref.getString('myNumber');
    }
    return ' ';
  }

  //save user data -> for both teacher as well as student
  Future<Null> saveUserData(String number,List<String> studentData) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList(number, studentData);
    print('saved user data');
  }

  Future<Null> saveTeacherSub(String number,List<String> studentData) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList(number+'sub', studentData);
    print('saved subject data');
  }


  //Work for both teacher and student to get data
  Future<List<String>> getUserData(String number) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> temp =  pref.getStringList(number);
    if ( temp != null) {
      return temp;
    }
    return null;
  }

  Future<List<String>> getTeacherSub(String number) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> temp =  pref.getStringList(number+'sub');
    if ( temp != null) {
      return temp;
    }
    return null;
  }
/*
  getSearchResult(BuildContext context) async{
    List<TeacherCacheCard> res = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    int count = pref.getInt('searchCount');
    final size = MediaQuery.of(context).size;
    if(count==null){
      return [Container(
//                          color: Colors.red,
        height: size.width,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/waiting.png',
              width: size.width / 2,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: size.width * 0.6,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Counting down 3 2 1 ...",
                    style: TextStyle(color: Colors.black54)
                ),
              ),
            )
          ],
        ),
      )];
    }
    else{
      for(int i=0;i<5;i++){
        List teachData = pref.get('teacher'+(i).toString());
        if(teachData==null){
          break;
        }
        else{res.add(TeacherCacheCard(
          firstName: teachData[0],
          lastName: teachData[1],
          popularName: teachData[2],
          profilePic: teachData[3],
          /*

          Here. Take qualification input.
           */
          qualification: teachData[4],
          isVerified: teachData[5]=='true'?true:false,
          onTap: ()async{
            DocumentSnapshot docTeacher = await usersRef.doc(teachData[6]).get();
            LinkedHashMap feedback = docTeacher.get('feedback');
            teacherObj = TeacherData.fromDocument(docTeacher);
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return MoreInfoScreen(teacherOb: teacherObj,feedback: feedback,);
            }));
          },
        ));}
      }
      return res;
    }

  }
*/
  saveFeedbackDetail(List<String> details) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList('details',details);
  }
  getFeedbackDetail() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List temp = pref.getStringList('details');
    if(temp==null){
      return [];
    }
    else{
      return temp;
    }
  }

  deleteSearchResult() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    int count = pref.getInt('searchCount');
    if(count!=null){
      for(int i=0;i<count;i++){
        pref.remove('teacher'+i.toString());
      }
      pref.remove('searchCount');
      return [Container(),];
    }
  }

  deleteCache() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
