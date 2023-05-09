import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  final Function(String, double, double, double) onSubmit;

  InputForm({required this.onSubmit});

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  String _url = '';
  String _minPrice = '';
  String _maxPrice = '';
  String _minRating = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSubmit(
        _url,
        double.parse(_minPrice),
        double.parse(_maxPrice),
        double.parse(_minRating),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Amazon URL'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a URL';
                }
                return null;
              },
              onSaved: (value) => _url = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Min Price'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a minimum price';
                }
                return null;
              },
              onSaved: (value) => _minPrice = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Max Price'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a maximum price';
                }
                return null;
              },
              onSaved: (value) => _maxPrice = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Min Rating'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a minimum rating';
                }
                return null;
              },
              onSaved: (value) => _minRating = value!,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
