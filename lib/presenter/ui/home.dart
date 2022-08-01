import 'package:flutter/material.dart';

import '../../repository/request.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late GetFromApi request;
  @override
  void initState() {
    request = GetFromApi(cep: '89031671');
    super.initState();
    request.getEnderecoObj();
  }

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    TextEditingController cepController = TextEditingController();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: _calculation,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                {
                  return Container();
                  break;
                }

              case ConnectionState.done:
                {
                  return SingleChildScrollView(
                    child: SizedBox(
                      height: size.height,
                      width: size.width,
                      child: Column(
                        children: [
                          FractionallySizedBox(
                            widthFactor: 0.6,
                            // heightFactor: 0.1,
                            child: Image.network(
                                'https://play-lh.googleusercontent.com/PAq27s27KH4odIqh2ugqkCZcipLYrXqYPRQCKYOjqwgwS212t7tmYAhSnicyUaVy1Mw3'),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: TextField(
                                    controller: cepController,
                                    decoration: InputDecoration(
                                        labelText: 'Digite o seu cep',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 3, color: Colors.blue),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 3, color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        )),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.blueGrey,
                                        style: BorderStyle.solid),
                                    primary: Colors.amber.shade300,
                                    shadowColor: Color.fromARGB(255, 0, 0, 0),
                                    onPrimary:
                                        Color.fromARGB(255, 255, 255, 255)),
                                onPressed: () {
                                  print('object');
                                  request.setcep(cepController.text);
                                  // request.getEnderecoObj();
                                },
                                child: Text('Buscar'),
                              )
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(request.endere.logradouro,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text(
                                      request.endere.complemento.isEmpty
                                          ? 'Sem complemento'
                                          : request.endere.complemento,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text(request.endere.bairro,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text(request.endere.localidade,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text(request.endere.uf,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              default:
                {
                  return CircularProgressIndicator();
                }
            }
          }),
    );
  }
}
