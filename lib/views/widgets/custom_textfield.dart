import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reaaia/utils/ColorsUtils.dart';
import 'package:reaaia/viewModels/phoneCode_provider.dart';

class CustomTextField extends StatefulWidget {
  String lablel;
  Widget icon;
  Widget sufficIcon;
  Color filledColor;
  bool isMobile;
  bool centerText;
  TextEditingController controller;
  String errorMessage;
  bool hasPassword;
  bool isEmail;
  bool passwordIdentical;
  bool isPhoneCode;
  bool isFinal;
  bool isEditable;
  bool isNotes;
  bool hasBorder;
  Function onFieldSubmitted;
  Function onChanged;
  Function onSaved;

  CustomTextField(
      {this.icon,
      this.lablel,
      this.filledColor,
      this.hasBorder = true,
      this.isEditable = true,
      this.isNotes = false,
      this.centerText = false,
      this.isFinal = false,
      this.isPhoneCode = false,
      this.isMobile = false,
      this.isEmail = false,
      this.passwordIdentical,
      this.hasPassword = false,
      this.controller,
      this.sufficIcon,
      this.errorMessage,
      this.onFieldSubmitted,
      this.onChanged,
      this.onSaved});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = true;

  List<String> codes = ['+20', '+966'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var phoneCodeProvider = Provider.of<PhoneCodeProvider>(context);
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.errorMessage;
        }

        return null;
      },
      controller: widget.controller,
      enabled: widget.isEditable,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      textInputAction: TextInputAction.next,
      obscureText: (widget.hasPassword) ? showPassword : widget.hasPassword,
      maxLines: (widget.isNotes) ? 3 : 1,
      textAlign: (widget.centerText) ? TextAlign.center : TextAlign.left,
      keyboardType: (widget.isEmail)
          ? TextInputType.emailAddress
          : (widget.isMobile)
              ? TextInputType.phone
              : TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
        enabledBorder: (!widget.hasBorder)
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: ColorsUtils.borderColor)),
        disabledBorder: (!widget.hasBorder)
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: ColorsUtils.borderColor)),
        border: (!widget.hasBorder)
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: ColorsUtils.borderColor)),
        focusedBorder: (!widget.hasBorder)
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: ColorsUtils.greenBorder)),
        labelText: widget.lablel,
        labelStyle: TextStyle(color: ColorsUtils.onBoardingTextGrey),
        prefixIcon: widget.icon,
        fillColor: (widget.filledColor == null)
            ? Colors.transparent
            : widget.filledColor,
        filled: true,
        suffixIcon: (widget.hasPassword)
            ? InkWell(
                onTap: () {
                  showPassword = !showPassword;
                  setState(() {});
                },
                child: (!showPassword)
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
              )
            : (!widget.isPhoneCode)
                ? widget.sufficIcon
                : Directionality(
                    textDirection: TextDirection.ltr,
                    child: CountryCodePicker(
                      onChanged: (v) {
                        phoneCodeProvider.setPhoneCode(v.dialCode);
                      },
                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: '+966',
                      favorite: [
                        '+966',
                        'EG',
                      ],
                      // optional. Shows only country name and flag
                      showCountryOnly: false,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: false,
                      // optional. aligns the flag and the Text left

                      showFlagDialog: true,
                    ),
                  ),
      ),
    );
  }
}
