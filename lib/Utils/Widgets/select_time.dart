import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart'; // Import intl package
import 'package:provider/provider.dart';

import '../../Constants/app_color.dart';
import '../../Exhibitor/Controllers/appointment_provider.dart';

class NumberPage extends StatefulWidget {
  final int eventId;
  final int appointmentId;
  final List<dynamic> eventDates; // Ensure the type is dynamic to match the input

  NumberPage({super.key, required this.eventId, required this.appointmentId, required this.eventDates});

  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  var hour = 10;
  var minute = 0;
  String? selectedDate;

  List<String> formattedDates = [];

  void _formatDates() {
    formattedDates = widget.eventDates.map((date) {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _formatDates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: AlertDialog(
          title: Text(
            'Select Date and Time',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomRadioGroup(
                options: formattedDates, // Use the formatted dates
                onChanged: (selectedValue) {
                  setState(() {
                    selectedDate = selectedValue;
                  });
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NumberPicker(
                      minValue: 10,
                      maxValue: 18,
                      value: hour,
                      zeroPad: true,
                      infiniteLoop: true,
                      itemWidth: 80,
                      itemHeight: 60,
                      onChanged: (value) {
                        setState(() {
                          hour = value;
                        });
                      },
                      textStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                      selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
                      decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: Colors.white,
                            ),
                            bottom: BorderSide(color: Colors.white)),
                      ),
                    ),
                    NumberPicker(
                      minValue: 0,
                      maxValue: 59,
                      value: minute,
                      zeroPad: true,
                      infiniteLoop: true,
                      itemWidth: 80,
                      itemHeight: 60,
                      onChanged: (value) {
                        setState(() {
                          minute = value;
                        });
                      },
                      textStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                      selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
                      decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: Colors.white,
                            ),
                            bottom: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String selectedTime =
                    "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, "0")}";
                Provider.of<AppointmentProvider>(context, listen: false).actionRescheduled(
                    widget.eventId, widget.appointmentId, selectedDate, selectedTime);
                Navigator.of(context).pop(selectedTime);
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRadioGroup extends StatefulWidget {
  final List<String> options;
  final Function(String) onChanged;

  CustomRadioGroup({
    required this.options,
    required this.onChanged,
  });

  @override
  _CustomRadioGroupState createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends State<CustomRadioGroup> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((option) {
        return RadioListTile(
          title: Text(option),
          value: option,
          activeColor: AppColor.secondary,
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value as String;
              widget.onChanged(_selectedValue!);
            });
          },
        );
      }).toList(),
    );
  }
}
