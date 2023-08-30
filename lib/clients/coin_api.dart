import 'networking.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const host = 'https://rest.coinapi.io/v1/exchangerate';

class CoinApi extends NetworkHelper {

  Map<String, String> headers = { 'X-CoinAPI-Key': dotenv.get('COINAPI_KEY') };

  Future<double> getBTCRate(String to) async {

    String url = '$host/BTC/$to';

    dynamic result = await getData(url, headers);
    return result['rate'];
  }
  
  Future<double> getETHRate(String to) async {

    String url = '$host/ETH/$to';

    dynamic result = await getData(url, headers);
    return result['rate'];
  }

  Future<double> getLTCRate(String to) async {

    String url = '$host/LTC/$to';

    dynamic result = await getData(url, headers);
    return result['rate'];
  }

}