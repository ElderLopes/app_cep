import 'dart:convert';

import 'package:app_cep/model/viacep_model.dart';
import 'package:app_cep/repository/cep_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class ViacepViewlModel extends BaseViewModel {
  List<ViacepModel> listCep = [];
  ViacepModel viacepModel = ViacepModel();
  ViacepViewlModel() {
    readCEP();
  }

  getCEP(String cep) async {
    var url = Uri.parse(
      'https://viacep.com.br/ws/$cep/json/',
    );
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var viacep = ViacepModel.fromJson(json);
    viacepModel = ViacepModel.create(
      cep: viacep.cep,
      bairro: viacep.bairro,
      complemento: viacep.complemento,
      ddd: viacep.ddd,
      gia: viacep.gia,
      ibge: viacep.ibge,
      localidade: viacep.localidade,
      logradouro: viacep.logradouro,
      siafi: viacep.siafi,
      uf: viacep.uf,
    );

    notifyListeners();
  }

  saveCEP(ViacepModel viacepModel) async {
    print(" estou aqui...");
  }

  readCEP() async {
    var cep = CepRepository();
    CepBack4AppModel listCepBack = await cep.get();
    listCepBack.results?.forEach((element) {
      listCep.add(element);
    });
    notifyListeners();
  }

  deleteCEP(String id) async {
    var cep = CepRepository();
    print(id);
    await cep.delete(id);
    listCep.clear();
    await readCEP();
    notifyListeners();
  }
}
