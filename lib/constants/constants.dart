import 'package:flutter/material.dart';

enum TextFieldType {
  amount,
  userName,

  userNameLogin,
  nairaAmount,
  email,
  emailAddress,
  password,
  name,
  bvn,
  accountNumber,
  phone,
  accountNo,
  others,
  setPassword,
  pin,
  nin,
  expiry,
  cvv,
  refferal,
}

const borderRadius = 24.0;
const dialogBorderRadius = 10.0;
const generalHorizontalPadding = 22.0;
const accountNumberLength = 10;
const bvnLength = 11;
const customFieldPadding = 25.0;
const inputFieldHeight = 56.0;
const ySpaceMin = 5.0;
const ySpaceMid = 10.0;
const ySpace1 = 20.0;
const ySpace2 = 25.0;
const ySpace3 = 32.0;
const topSpace = 35.0;
const svgImageWidth = 10.0;
const textFieldIconPadding = 12.0;
const bottomSheetHeight = 388.0;
const bottomSheetBorderRadius = 20.0;
const pinCodeFieldLength = 4;
const transactionPinLength = 4;
const resetPasswordCodeLength = 6;
const mTokenLength = 6;
const phoneNumberFieldLength = 11;
const loaderWidth = 30.0;
const sessionTimeoutInMinutes = 5;
const codeResendTimeforPasswordReset = 60;
const voucherExpirationTimes = 30000;
const carouselViewPortFraction = 0.9;
const kDefaultPageSize = 100;

// const contentFrameMargin = 37.0;
// const errorFrameWidth = 387.0;
// const errorFrameHeight = 108.0;
// const errorFrameIconSize = 200.0;
// const socialIconSize = 33.0;
// const socialMarginRight = 27.0;

const defaultPagePadding = EdgeInsets.only(
    left: generalHorizontalPadding,
    top: topSpace,
    right: generalHorizontalPadding);

const String terms_and_conditions =
    'This INDEMNITY is given by ABC Conglomerate, a company incorporated under the Laws of the Federal Republic of Nigeria with its registered office at XYZ Location (hereinafter called the “Company”/ “we” which expression shall wherever the context so admits include its successors-in-title and assigns).';
const String line_2 =
    "TO THE ALTERNATIVE BANK a company incorporated under the Laws of the Federal Republic of Nigeria with its registered office at 239 Ikorodu Road, Ilupeju, Lagos (hereinafter called the “Bank”). WHEREAS: ";
const String line_3 =
    "1. The Bank has established Altpro, the Bank’s online digital platform that allows corporate customers operate their account subject to prescribed single and daily transaction limits put in place to mitigate the attendant risks thereon. ";
const String line_3a =
    "2. We however desire to increase the single and daily transaction limits on all our account(s) linked to our profile on Altpro (the “Platform”) for all transactions, to the sum of N20,000,000.00 (Twenty Million Naira only) for single transactions, and up to the sum of N25,000,000.00 (Twenty Five Million Naira only) for daily transactions without any recourse to the Bank. ";
const String line_3b =
    "3. The single and daily transaction limits on all our account(s) linked to our profile on the Platform should be increased accordingly. (“Request”) We are fully aware of the potential risks and vulnerabilities posed by increasing our single and daily transaction limits on the Platform and hereby agrees to execute this Indemnity in favour of the Bank and assume all such risks, liabilities and obligations that may arise from the Bank honouring our Request. ";
const String line_3c =
    "NOW THEREFORE, WE HEREBY INDEMNIFY THE BANK AS FOLLOWS:";
const String line_4 =
    "In consideration of the Bank accepting our request for the enhancement of the single and daily transaction limits on all our account(s) linked to our profile on the Platform to N20,000,000.00 (Twenty Million Naira only) and N25,000,000.00 (Twenty Five Million Naira only) respectively, We hereby irrevocably and unconditionally indemnify and keep the Bank fully indemnified against all claims, demands, liabilities, damages, loss, costs, charges, fees, expenses, distress, actions and proceedings which may be brought against the Bank or which the Bank may pay or incur in connection with or arising from any litigation or claim against the Bank in consequence of acceding to our request. We unconditionally agree and undertake, as a continuing obligation, to fully indemnify the Bank, its successors in title and assigns and at all times to keep the Bank fully and completely indemnified on a first written demand, from and against all liabilities, damages, claims, demands, actions and proceedings, losses, costs and expenses including legal fees on a full indemnity basis and all other liabilities of whatsoever nature or description which may be incurred or suffered by the Bank in relation to, or arising out of our use of and access to the Platform and acting in accordance with our Request.";
const String line_5 =
    "We affirm that all approvals, consents, and authorizations necessary for the discharge of our obligations under this Indemnity have been obtained, are valid and in full force and effect.";
const String line_6 =
    "We further affirm that the persons executing this Indemnity on our behalf are as at the date hereof duly appointed, empowered, and authorized to bind us in connection with the subject matter.";
const String line_7 =
    "Where any term or provision of this Indemnity is determined to be illegal, unenforceable, or invalid in whole or in part for any reason, such illegal, unenforceable, or inv id provision or part(s) thereof shall be struck from this Indemnity and such provision shall not affect the legality, enforceability, or validity of the remainder. The liability of the Company shall also not be affected by any claim the Company may have against the Bank or any alleged mistake of any facts on the part of the Bank.";
const String line_8 =
    "Any demand in writing by the Bank to the Company, for the fulfillment of the Company’s obligations herein shall satisfy the need for demand under this Indemnity and shall be deemed to have been sufficiently given if it is sent to the Company by post, email or by leaving same at the Company’s registered address or place of business or last known address.";
const String line_9 =
    "The Company hereby specifically authorizes and empowers the Bank, without notice to the Company, at the Bank’s absolute discretion to combine and or consolidate all or any of the Company’s accounts with the Bank and set off and or transfer any such sum or sums standing to the credit of any one or more of such accounts against and or towards the satisfaction of any of the Company’s liabilities to the Bank or in satisfaction of any liability incurred by the Bank in honouring the Company’s Request.";
const String line_10 =
    "No amendment, modification, or release from any provision(s) of this Indemnity hereof is valid except with the prior written consent of the Bank, neither shall we assign or transfer any of our obligations under this Indemnity whether by operation of the law or otherwise to any third party without the prior written consent of the Bank.";
const String line_11 =
    "This Indemnity shall remain a continuing obligation on the Company so long as any liability shall remain upon the Bank for honouring the Company’s request. Provided always that this indemnity shall not expire, and the Company shall not be released of its obligations herein until the Bank has discharged this indemnity in writing.";
const String line_12 =
    "The Company hereby agrees that no delay or omission or granting of any indulgence on the part of the Bank in exercising any right, power, privilege, or remedy in respect of this indemnity shall be construed as a waiver thereof, nor shall any single or partial exercise of any such right, remedy, power or privilege preclude any further exercise thereof or the exercise of any other right, power privilege or remedy.";
const String line_13 =
    "The rights, powers, privileges, and remedies provided in this indemnity are cumulative and not exclusive of any rights, powers, privileges or remedies provided by law.";
const String line_14 =
    "We agree that the terms of this document have been read and understood by us and the consent, authorizations and undertakings contained herein are given free of any duress or compulsion.";
const String line_15 =
    "This Indemnity is in addition to and is not to prejudice or be prejudiced by any other Indemnity which has been or may now or hereafter be executed by us.";
const String line_16 =
    "This Indemnity shall be governed by and construed in accordance with the laws of the Federal Republic of Nigeria. This Indemnity takes effect from 19th November, 2023 and shall be construed in all respects in accordance with the Laws of the Federal Republic of Nigeria as may be in force from time to time.";
