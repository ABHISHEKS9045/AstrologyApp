import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';

Widget policyWidget(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Privacy Policy',
          style: TextStyle(color: colorblack, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        sizedboxheight(5.0),
        Text(
          "This Privacy Policy governs the manner in which we collect, use, disclose, and protect information collected from users (referred to as \"you\" or \"user\") of our website and mobile application (collectively, the \"Platform\"). By using our Platform, you agree to the collection and use of your information in accordance with this Privacy Policy." +
              "\n\n1. Information We Collect" +
              "\n\n1.1 Personal Information: We may collect personal information from you, including but not limited to your name, email address, contact number, location, and payment information when you register an account or make a purchase on our Platform." +
              "\n\n1.2 Non-Personal Information: We also collect non-personal information, such as device information, operating system, browser type, and IP address, through the use of cookies and similar technologies. This information is used to enhance the user experience and improve our services." +
              "\n\n2. Use of Information" +
              "\n\n2.1 Provide Services: We use the information collected to provide astrology consultation services, process payments, communicate with you about your account and services, and customize your experience on the Platform." +
              "\n\n2.2 Improve and Develop: We may use the information to analyze user behavior, troubleshoot technical issues, conduct research, and improve the functionality and quality of our Platform and services." +
              "\n\n2.3 Marketing and Communication: With your consent, we may use your email address or contact number to send promotional materials, newsletters, and other communications about our services, special offers, and updates. You have the option to unsubscribe from these communications at any time." +
              "\n\n3. Information Sharing" +
              "\n\n3.1 Service Providers: We may engage third-party service providers to assist in the operation of our Platform, perform services on our behalf, or help us analyze how the Platform is used. These service providers have access to your personal information only to perform their tasks and are obligated to maintain its confidentiality." +
              "\n\n3.2 Legal Compliance: We may disclose your information if required by law, governmental request, or as necessary to protect our rights, safety, or property, and the rights, safety, or property of others." +
              "\n\n4. Data Security" +
              "\n\nWe implement reasonable security measures to protect your personal information from unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security." +
              "\n\n5. Children's Privacy" +
              "\n\nOur Platform is not intended for use by individuals under the age of 18. We do not knowingly collect personal information from children. If we become aware that we have collected personal information from a child without parental consent, we will take steps to delete such information from our servers." +
              "\n\n6. Third-Party Links" +
              "\n\nOur Platform may contain links to third-party websites or services that are not owned or controlled by us. We are not responsible for the privacy practices or content of these third-party websites or services. We encourage you to review the privacy policies of those third parties before providing any personal information." +
              "\n\n7. Changes to this Privacy Policy" +
              "\n\nWe reserve the right to update or modify this Privacy Policy at any time. Any changes will be effective immediately upon posting the revised Privacy Policy on our Platform. Your continued use of the Platform after the posting of any modifications constitutes your acceptance of the revised Privacy Policy." +
              "\n\nBy using our Platform, you acknowledge that you have read and understood this Privacy Policy and agree to the collection, use, and disclosure of your information as described herein.",
          style: TextStyle(color: colorblack, fontSize: 16, fontWeight: FontWeight.w300),
        ),
      ],
    ),
  );
}
