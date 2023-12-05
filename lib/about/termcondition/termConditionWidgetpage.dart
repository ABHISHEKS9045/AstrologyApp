
import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';

Widget appAimWidget(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Terms and Conditions',
          style: TextStyle(
              color: colorblack,
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),
        ),
        sizedboxheight(5.0),
        Text(
          "Welcome to our Application, an e-commerce aggregator of astrologers providing consulting services. These terms and conditions (the “Agreement”) govern your access and use of our website and services. Please read this Agreement carefully before using our website. By using our website, you agree to be bound by this Agreement. If you do not agree to this Agreement, you may not use our website."+
          "\n\n1. GENERAL TERMS"+
          "\n\n1.1. User Content. Our website may allow you to post content, including without limitation, text, images, videos, and other materials (collectively, “User Content”). You represent and warrant that you have all necessary rights to post such User Content and that such User Content will not infringe any third party’s intellectual property rights, or violate any applicable law or regulation."+
          "\n\n1.2. Prohibited Activities. You may not use our website for any illegal or unauthorized purpose, or engage in any activity that violates this Agreement, including without limitation, posting or transmitting any User Content that:"+
          "\n\n(a) is defamatory, obscene, pornographic, or otherwise objectionable;"+
          "\n\n(b) infringes any intellectual property rights or other proprietary rights of any third party;"+
          "\n\n(c) constitutes spam, pyramid schemes, or similar forms of solicitation;"+
          "\n\n(d) contains any viruses, Trojan horses, worms, time bombs, or other harmful programs or components;"+
          "\n\n(e) impersonates any person or entity, including without limitation, our employees or representatives; or"+
          "\n\n(f) interferes with the proper functioning of our website."+
          "\n\n1.3. Modification of Agreement. We reserve the right to modify this Agreement at any time in our sole discretion. If we modify this Agreement, we will post the modified Agreement on our website. Your continued use of our website following such modification constitutes your acceptance of the modified Agreement."+
          "\n\n2. PRIVACY POLICY"+
          "\n\nOur Privacy Policy governs the collection, use, and disclosure of personal information that we may obtain from you. Please review our Privacy Policy carefully before using our website."+
          "\n\n3. DISCLAIMER OF WARRANTIES"+
          "\n\nOUR WEBSITE AND SERVICES ARE PROVIDED “AS IS” AND WITHOUT WARRANTY OF ANY KIND. WE EXPRESSLY DISCLAIM ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION, WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT OF INTELLECTUAL PROPERTY RIGHTS. WE DO NOT WARRANT THAT OUR WEBSITE WILL MEET YOUR REQUIREMENTS, WILL BE ERROR-FREE, UNINTERRUPTED, OR SECURE."+
          "\n\n4. LIMITATION OF LIABILITY"+
          "\n\nIN NO EVENT SHALL WE BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE DAMAGES, INCLUDING WITHOUT LIMITATION, LOST PROFITS, LOST REVENUES, LOST BUSINESS OPPORTUNITIES, OR ANY OTHER LOSS OR DAMAGE OF ANY KIND ARISING OUT OF OR IN CONNECTION WITH THIS AGREEMENT, REGARDLESS OF THE FORM OF ACTION, WHETHER IN CONTRACT, TORT, STRICT LIABILITY, OR OTHERWISE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGES."+
          "\n\n5. INTELLECTUAL PROPERTY RIGHTS"+
          "\n\nAll intellectual property rights, including without limitation, patents, trademarks, trade secrets, copyrights, and other proprietary rights, in and to our website and services, are owned by us or our licensors. You may not use any of our intellectual property rights without our prior written consent."+
          "\n\n6. INDEMNIFICATION"+
          "\n\nYou agree to indemnify, defend, and hold harmless us, our affiliates, and our respective officers, directors, employees, and agents from and against any and all claims, liabilities, damages, losses, costs, expenses, fees of any kind, including without limitation, attorneys’ fees and costs, arising from or in connection with your User Content, your use of our website, or your violation of this Agreement or any applicable law or regulation."+
          "\n\n7. TERMINATION"+
          "\n\nWe reserve the right to terminate this Agreement and your access to our website at any time and for any reason without notice or liability. Upon termination, you must immediately cease all use of our website."+
          "\n\n8. GOVERNING LAW"+
          "\n\nThis Agreement shall be governed by and construed in accordance with the laws of the jurisdiction where our company is located without giving effect to any principles of conflicts of law."+
          "\n\n9. DISPUTE RESOLUTION"+
          "\n\nAny dispute arising out of or in connection with this Agreement shall be resolved by binding arbitration in accordance with the rules of the jurisdiction where our company is located. The arbitration shall be conducted in the English language and the award of the arbitrator shall be final and binding."+
          "\n\n10. ENTIRE AGREEMENT"+
          "\n\nThis Agreement constitutes the entire agreement between you and us regarding the use of our website and services, and supersedes all prior or contemporaneous communications and proposals, whether oral or written, between you and us."+
          "\n\n11. ASSIGNMENT"+
          "\n\nWe may assign this Agreement, in whole or in part, at any time with or without notice to you. You may not assign this Agreement or transfer any rights to use our website or services."+
          "\n\n12. SEVERABILITY"+
          "\n\nIf any provision of this Agreement is held to be invalid or unenforceable, such provision shall be struck and the remaining provisions shall be enforced."+
          "\n\n13. WAIVER"+
          "\n\nOur failure to enforce any right or provision of this Agreement will not be deemed a waiver of such right or provision."+
          "\n\n14. CONTACT US"+
          "\n\nIf you have any questions about this Agreement or our website, please contact us at \"talent@connectaastro.com\"."+
          "\n\nThank you for using our Application!",
          style: TextStyle(
              color: colorblack,
              fontSize: 16,
              fontWeight: FontWeight.w300
          ),
        ),
      ],
    ),
  );
}