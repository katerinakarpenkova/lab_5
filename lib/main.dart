import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
        create: (context) => Data(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Мастер-класс',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: const MyHomePage(title: 'Регистрация'),
        )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


bool checked = false;
enum GenderList {male, female}
const List<String> list = <String>['Маргарита', 'Четыре сезона', 'Карбонара', 'Каприччиоза', 'Песто'];
const List<String> list2 = <String>['1 год и менее', '1 - 5 лет', '5 - 10 лет', 'более 10 лет'];
GenderList? _gender = GenderList.male;

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          const Padding(padding: EdgeInsets.only(top:5)),
          Row(mainAxisAlignment: MainAxisAlignment.center,
              children:const [Text('Регистрация пиццамейкера на мастер-класс:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]),

          Row(children:[
                const Padding(padding: EdgeInsets.only(left:50)),
                const Text("1. Псевдоним: ", style: TextStyle(fontSize: 16)),
                const Padding(padding: EdgeInsets.only(left:10)),
                SizedBox(width: 150,
                    child: TextField(
                      onChanged: (newData) => context.read<Data>().changeStringName(newData),
                    )
                ),],
          ),

          const Padding(padding: EdgeInsets.only(top:20)),
          Row(children:[
               const Padding(padding: EdgeInsets.only(left:50)),
               const Text('2. Мне исполнилось 18 лет', style: TextStyle(fontSize: 16)),
               const Padding(padding: EdgeInsets.only(left:10)),
               const SizedBox(height: 20.0),
               Checkbox(
                 value: checked,
                 onChanged: (bool? value) => {
                   setState(() {
                     checked = value!;
                   })
                 },
               ),],
          ),

          const Padding(padding: EdgeInsets.only(top:15)),
          Row(children:const [
              Padding(padding: EdgeInsets.only(left:50)),
              Text('3. Стаж работы:', style: TextStyle(fontSize: 16)),
              Padding(padding: EdgeInsets.only(left:10)),
              DropdownButtonExample2(),
            ],
          ),

          const Padding(padding: EdgeInsets.only(top:15)),
          Row(children: [
              const Padding(padding: EdgeInsets.only(left:50)),
              const Text('4. Пол:', style: TextStyle(fontSize: 16)),
              SizedBox(width: 170,
                  child: RadioListTile<GenderList>(
                    title: const Text('Мужской'),
                    value: GenderList.male,
                    groupValue: _gender,
                    onChanged: (GenderList? value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
              ),
              SizedBox(width: 180,
                child: RadioListTile<GenderList>(
                  title: const Text('Женский'),
                  value: GenderList.female,
                  groupValue: _gender,
                  onChanged: (GenderList? value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
              ),],
          ),

          const Padding(padding: EdgeInsets.only(top:15)),
          Row(children: const [
              Padding(padding: EdgeInsets.only(left:50)),
              Text('5. Пицца для мастер-класса:', style: TextStyle(fontSize: 16)),
              Padding(padding: EdgeInsets.only(left:10)),
              DropdownButtonExample1(),
            ]
          ),

          const Padding(padding: EdgeInsets.only(top:15)),
          Row(children:[
              const Padding(padding: EdgeInsets.only(left:50)),
              const Text('6. Дата мастер-класса:', style: TextStyle(fontSize: 16)),
              const Padding(padding: EdgeInsets.only(left:10)),
              SizedBox(width: 85,
                child: TextField(
                  onChanged: (newData) => context.read<Data>().changeStringDate(newData),
                ),
              ),],
          ),

          const Padding(padding: EdgeInsets.only(top:25)),
          Row(children:const [
              Padding(padding: EdgeInsets.only(left:50)),
              Text('7. Расскажите о себе:', style: TextStyle(fontSize: 16)),
              Padding(padding: EdgeInsets.only(left:10)),
            ],
          ),
          Row(children:[
            const Padding(padding: EdgeInsets.only(left:70)),
            SizedBox(width: 140,
                child: TextField(decoration: const InputDecoration(
                  border: OutlineInputBorder()),
                  onChanged: (newData) => context.read<Data>().changeStringAbout(newData),
                )
            ),],
          ),

          const Padding(padding: EdgeInsets.only(top: 20)),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondScreen()));
              },
                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(Colors.purple)),
                  child: const Text("Зарегистрироваться", style: TextStyle(fontSize: 16))
              )],
          ),
        ],
      ),
    );
  }
}
///--------------------------------------------------------------------------///
class DropdownButtonExample1 extends StatefulWidget {
  const DropdownButtonExample1({super.key});

  @override
  State<DropdownButtonExample1> createState() => _DropdownButtonExample1State();
}
String dropdownValue = list.first;
class _DropdownButtonExample1State extends State<DropdownButtonExample1> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.purple,
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
///--------------------------------------------------------------------------///
class DropdownButtonExample2 extends StatefulWidget {
  const DropdownButtonExample2({super.key});

  @override
  State<DropdownButtonExample2> createState() => _DropdownButtonExample2State();
}
String dropdownValue2 = list2.first;
class _DropdownButtonExample2State extends State<DropdownButtonExample2> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue2,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.purple,
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue2 = value!;
        });
      },
      items: list2.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
///--------------------------------------------------------------------------///
class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}
class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Анкета участника')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          Row(children:[
            const Padding(padding: EdgeInsets.only(left:50)),
            const Text("1. Псевдоним: ", style: TextStyle(fontSize: 16)),
            Text(context.watch<Data>().getName, style: const TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.only(left:10)),
          ],
          ),

          Row(children:[
            const Padding(padding: EdgeInsets.only(left:50)),
            const Text('2. Мне исполнилось 18 лет', style: TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.only(left:10)),
            Checkbox(
              value: checked,
              onChanged: (value) => {
                setState(() {
                  checked = value!;
                })
              },
            ),
          ],
          ),

          Row(children:[
            const Padding(padding: EdgeInsets.only(left:50)),
            const Text('3. Стаж работы:', style: TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.only(left:10)),
            Text(dropdownValue2, style: const TextStyle(fontSize: 16)),
          ],
          ),

          Row(children:[
            const Padding(padding: EdgeInsets.only(left:50)),
            const Text('4. Пол:', style: TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.only(left:10)),
            SizedBox(width: 170,
              child: RadioListTile<GenderList>(
                title: const Text('Мужской'),
                value: GenderList.male,
                groupValue: _gender,
                onChanged: (GenderList? value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
            ),
            SizedBox(width: 180,
              child: RadioListTile<GenderList>(
                title: const Text('Женский'),
                value: GenderList.female,
                groupValue: _gender,
                onChanged: (GenderList? value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
            ),
          ],
          ),

          Row(children:[
            const Padding(padding: EdgeInsets.only(left:50)),
            const Text('5. Пицца для мастер-класса:', style: TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.only(left:10)),
            Text(dropdownValue, style: const TextStyle(fontSize: 16)),
          ],
          ),

          Row(children:[
            const Padding(padding: EdgeInsets.only(left:50)),
            const Text('6. Дата мастер-класса:', style: TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.only(left:10)),
            Text(context.watch<Data>().getDate, style: const TextStyle(fontSize: 16)),
          ],
          ),

          Row(children:[
            const Padding(padding: EdgeInsets.only(left:50)),
            const Text('7. Расскажите о себе:', style: TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.only(left:10)),
            Text(context.watch<Data>().getAbout, style: const TextStyle(fontSize: 16)),
          ],
          ),

          Row(mainAxisAlignment: MainAxisAlignment.center,
            children:const [
            Padding(padding: EdgeInsets.only(left:50)),
            Text('Обязательно проверьте введеные данные!', style: TextStyle(fontSize: 16, color: Colors.purple)),
          ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class Data with ChangeNotifier{
  String _name = "Вы не ввели свой псевдоним";
  String get getName => _name;
  void changeStringName(String newString){
    _name = newString;
    notifyListeners();
  }

  String _date = "Вы не выбрали дату";
  String get getDate => _date;
  void changeStringDate(String newString){
    _date = newString;
    notifyListeners();
  }

  String _about = "Вы ничего не рассказали о себе";
  String get getAbout => _about;
  void changeStringAbout(String newString){
    _about = newString;
    notifyListeners();
  }
}

