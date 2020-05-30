import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: BMICalculator(),
    ),
  );
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  int height = 0;
  double weight = 0.0;
  @override
  Widget build(BuildContext context) {
    // Text to provide an overview of BMI calculation
    Text bmiText = Text(
      'This application calculates your BMi (body-mass index). '
          'Healthy BMI range: 18.5 kg/m2 - 25 kg/m2 '
          'Normal BMI corresponds to the value in range'
          'Values below is underweight'
          'Value over is overweight',
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    );
    // Height input field to enter the height
    TextField heightField = TextField(
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: 'Height',
        hintText: 'Enter you height in cm',
      ),
      keyboardType: TextInputType.number,
      onChanged: (String s) {
        height = int.parse(s);
       // print(height);
      },
    );

    // Weight input field to enter the weight
    TextField weightField = TextField(
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: 'Weight',
        hintText: 'Enter you weight in kg',
      ),
      keyboardType: TextInputType.number,
      onChanged: (String s) {
        weight = double.parse(s);
        //print(weight);
      },
    );

    // A RaisedButton which on being clicked/tapped displays the BMI
    RaisedButton calcBMIButton = RaisedButton(
      color: Colors.blue,
      child: Text(
        'Calculate BMI',
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        double calculatedBMI = weight / ((height / 100.0) * (height / 100.0));
        calculatedBMI = double.parse(calculatedBMI.toStringAsFixed(2));

        //print('The calculated BMi is $calculatedBMI.');

        // Generate dialog
        AlertDialog dialog = AlertDialog(
          content: Text(
            'Your BMI: $calculatedBMI kg/m2\n'
                'Healthy BMI range: (18.5 - 25.0) kg/m2\n'
                '',
            textAlign: TextAlign.center,
          ),
        );

        // Show dialog
        showDialog(context: context, builder: (BuildContext context) => dialog);
      },
    );

    // Container to hold the TextFields and RaisedButton
    Container container = Container(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              weightField,
              heightField,
              calcBMIButton,
            ],
          ),
        ),
      ),
    );

    // AppBar
    AppBar appBar = AppBar(
      title: Text('BMI Calculator'),
    );
    // Scaffold
    Scaffold scaffold = Scaffold(
      appBar: appBar,
      body: container,
    );

    return scaffold;
  }
}
