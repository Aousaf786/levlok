import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';



List<TextSpan> clickableText({required String text, }) {
  List<TextSpan> textSpan = [];

  final urlRegExp = RegExp(r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

  getLink(String linkString) {
    textSpan.add(
      TextSpan(
        text: linkString,
        style: TextStyle(color: Colors.blue),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            print("=====linkString :${linkString[0]+linkString[1]+linkString[2]}===");

            if("${linkString[0]+linkString[1]+linkString[2]}"== "www"){

              print("======ifffff======");
              // await launch("https://$linkString");


            }else{

              print("======elsssssee======");
              // await launch(linkString);


            }
            //if (await canLaunch(url))
            //   await launch("https://$linkString");
            //else
            // can't launch url, there is some error
            //throw "Could not launch $url";
          },
      ),
    );
    return linkString;
  }

  getNormalText(String normalText) {
    textSpan.add(
      TextSpan(
        text: normalText,
        style: const TextStyle(color: Colors.black),
      ),
    );
    return normalText;
  }

  text.splitMapJoin(
    urlRegExp,
    onMatch: (m) => getLink("${m.group(0)}"),
    onNonMatch: (n) => getNormalText("${n.substring(0)}"),
  );

  return textSpan;}

  class TextClickable extends StatelessWidget {

  final String text;
  final TextStyle textStyle;
    const TextClickable({Key? key, required this.text, required this.textStyle}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return  SelectableText.rich(
        TextSpan(
            children: clickableText(text: text ),
          style: textStyle
        ),
      );
    }
  }
