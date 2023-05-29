import './networking.dart';
import '../utilities/configure.dart';

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class Brain {
  Brain({this.coin, this.currency});

  String? coin;
  String? currency;

  Future<dynamic> getExchangeRate() async {
    Network network =
        Network(url: '$coinAPIURL/$coin/$currency?apikey=$coinAPI');

    var exchangeRate = await network.getData();
    return exchangeRate;
  }
}
