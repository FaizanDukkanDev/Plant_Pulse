import 'package:plantpulse/app_theme.dart';
import 'package:plantpulse/data/farm/repositories/storeData.dart';
import 'package:plantpulse/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:intl/intl.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class FormStorePlanting extends StatefulWidget {
  @override
  _FormStorePlantingState createState() => _FormStorePlantingState();
}

class _FormStorePlantingState extends State<FormStorePlanting> {
  final _formKey = GlobalKey<FormBuilderState>();
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  date() {
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Create Planting Entry'),
        body: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              new Expanded(
                child: ListView(
                  padding: EdgeInsets.all(10.0),
                  children: <Widget>[
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            name: 'plantName',
                            validator: Validators.compose([
                              Validators.required('Required'),
                            ]),
                            decoration: InputDecoration(
                              labelText: "Plant Name",
                              icon: Icon(Icons.local_florist_outlined),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 20.h),
                          FormBuilderTextField(
                            name: 'plantNumber',
                            validator: Validators.compose([
                              Validators.required('Required'),
                              Validators.patternRegExp(
                                  RegExp(r'^[0-9]*$'), 'Please enter a valid number'),
                            ]),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "No. of Plants",
                              icon: Icon(Icons.format_list_numbered),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          FormBuilderDateTimePicker(
                            name: 'plantDate',
                            format: DateFormat('dd-MM-yyyy'),
                            currentDate: DateTime.now(),
                            inputType: InputType.date,
                            initialValue: DateTime.now(),
                            lastDate: DateTime.now(),
                            decoration: InputDecoration(
                              labelText: 'Date',
                              icon: Icon(Icons.date_range),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          FormBuilderSlider(
                            name: 'plantEstimated',
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                            min: 1.0,
                            max: 12.0,
                            initialValue: 5.0,
                            divisions: 11,
                            label: 'Weeks',
                            activeColor: Colors.red,
                            inactiveColor: Colors.pink[100],
                            decoration: InputDecoration(
                              labelText: 'Estimated Harvest Date',
                              icon: Icon(Icons.timelapse),
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            color: Colors.red,
                            child: Text(
                              "Reset",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _formKey.currentState?.reset();
                            },
                          ),
                        ),
                        SizedBox(width: 20.h),
                        Expanded(
                          child: MaterialButton(
                            color: Theme.of(context).colorScheme.secondary,
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _formKey.currentState?.save();
                              if (_formKey.currentState!.validate()) {
                                addData(_formKey.currentState!.value);
                                Navigator.pop(context);
                              } else {
                                print("validation failed");
                              }
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
