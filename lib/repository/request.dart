import 'dart:convert';

import 'package:http/http.dart' as http;

class GetFromApi {
  late Endereco endere;
  String cep;
  GetFromApi({
    required this.cep,
  });

  void setcep(String Cep) {
    cep = Cep;
    getEnderecoObj();
  }

  Future<Endereco> getEnderecoObj() async {
    late Map<String, dynamic> responseMap = {};

    String request = 'https://viacep.com.br/ws/$cep/json/';
    // String request = 'https://viacep.com.br/ws/89040362/json/';

    http.Response response = await http.get(Uri.parse(request));

    responseMap = json.decode(response.body);

    print(responseMap);

    endere = Endereco(
        logradouro: responseMap['logradouro'],
        complemento: responseMap['complemento'],
        bairro: responseMap['bairro'],
        localidade: responseMap['localidade'],
        uf: responseMap['uf']);
    return endere;
  }
}

class Endereco {
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;
  Endereco({
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
  });
}
