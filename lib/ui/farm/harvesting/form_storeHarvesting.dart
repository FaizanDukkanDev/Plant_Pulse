import 'package:plantpulse/data/farm/repositories/harvest_storeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:intl/intl.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../app_theme.dart';

class StoreHarvesting extends StatefulWidget {
  final String documentID;
  final String plantName;
  final String plantNo;
  final String plantDate;
  final double plantEstimate;
  final String plantHarvest;
  final int plantMonth;

  StoreHarvesting({
    required this.documentID,
    required this.plantName,
    required this.plantNo,
    required this.plantDate,
    required this.plantEstimate,
    required this.plantHarvest,
    required this.plantMonth,
  });

  @override
  _StoreHarvestingState createState() => _StoreHarvestingState(
      name: plantName,
      no: plantNo,
      date: plantDate,
      estimate: plantEstimate,
      harvest: plantHarvest,
      id: documentID,
      month: plantMonth);
}

class _StoreHarvestingState extends State<StoreHarvesting> {
  final _formKey = GlobalKey<FormBuilderState>();

  final String id;
  final String name;
  final String no;
  final String date;
  final double estimate;
  final String harvest;
  final int month;

  _StoreHarvestingState({
    required this.id,
    required this.name,
    required this.no,
    required this.date,
    required this.estimate,
    required this.harvest,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GFAppBar(
          leading: GFIconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            type: GFButtonType.transparent,
          ),
          title: Text(
            "Create Harvesting Entry",
            style: AppTheme.appTheme.textTheme.labelLarge
          ),
          backgroundColor: AppTheme.appTheme.primaryColor,
        ),
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
                            readOnly: true,
                            initialValue: name,
                            name: 'plantName',
                            decoration: InputDecoration(
                              labelText: "Plant Name",
                              icon: Icon(Icons.local_florist_outlined),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 10),
                          FormBuilderTextField(
                            readOnly: true,
                            name: 'plantNumber',
                            initialValue: no,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "No. of Plants",
                              icon: Icon(Icons.format_list_numbered),
                            ),
                          ),
                          SizedBox(height: 10),
                          FormBuilderTextField(
                            readOnly: true,
                            name: 'plantDate',
                            initialValue: date,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Date',
                              icon: Icon(Icons.date_range),
                            ),
                          ),
                          SizedBox(height: 10),
                          FormBuilderSlider(
                            enabled: false,
                            name: 'plantEstimated',
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
                            min: 1.0,
                            max: 12.0,
                            initialValue: estimate,
                            divisions: 11,
                            label: 'Weeks',
                            activeColor: Colors.red,
                            inactiveColor: Colors.pink[100],
                            decoration: InputDecoration(
                              labelText: 'Estimated Harvest Date (weeks)',
                              icon: Icon(Icons.timelapse),
                            ),
                          ),
                          SizedBox(height: 10),
                          FormBuilderTextField(
                            readOnly: true,
                            name: 'plantEstimatedDate',
                            initialValue: harvest,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Estimated Harvest Date',
                              icon: Icon(Icons.date_range),
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(
                            color: Colors.black,
                            height: 10.0,
                          ),
                          SizedBox(height: 10),
                          FormBuilderTextField(
                            name: 'harvestQuantity',
                            validator: Validators.compose([
                              Validators.required('Required'),
                              Validators.patternRegExp(
                                RegExp(r'^[0-9]*$'),
                                'Invalid Number',
                              ),
                            ]),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Harvest Yield",
                              icon: Icon(Icons.format_list_numbered),
                            ),
                          ),
                          SizedBox(height: 10),
                          FormBuilderDateTimePicker(
                            name: 'harvestDate',
                            format: DateFormat('dd-MM-yyyy'),
                            currentDate: DateTime.now(),
                            inputType: InputType.date,
                            initialValue: DateTime.now(),
                            lastDate: DateTime.now(),
                            decoration: InputDecoration(
                              labelText: 'Harvest Date',
                              icon: Icon(Icons.date_range),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
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
                        SizedBox(width: 20),
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
                                print(_formKey.currentState?.value);
                                print(id);
                                updatePlanting(id);
                                harvestData(_formKey.currentState!.value);
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
