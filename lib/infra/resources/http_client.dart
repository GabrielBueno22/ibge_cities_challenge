import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:ibge_cities_challenge/core/resources/app_error.dart';
import 'package:ibge_cities_challenge/infra/resources/infra_error.dart';

abstract class HttpClient {
  Future<Either<AppError, dynamic>> getApiData(String route);
}

class HttpClientImp implements HttpClient {
  @override
  Future<Either<AppError, dynamic>> getApiData(String route) async {
    final client = http.Client();
    try {
      final response = await client.get(Uri.parse(route));
      if (response.statusCode != 200) {
        return Either.left(_onError(response));
      } else {
        return Either.right(response.body);
      }
    } catch (e) {
      return Either.left(InfraError(message: "Ocorreu um erro desconhecido"));
    }
  }

  AppError _onError(http.Response response) {
    String message;

    switch (response.statusCode) {
      case 400:
        message =
            "Requisição Inválida: O servidor não conseguiu entender a solicitação.";
        break;
      case 401:
        message =
            "Não Autorizado: Acesso negado devido a credenciais inválidas.";
        break;
      case 403:
        message = "Proibido: Você não tem permissão para acessar este recurso.";
        break;
      case 404:
        message =
            "Não Encontrado: O recurso solicitado não pôde ser encontrado.";
        break;
      case 500:
        message =
            "Erro Interno do Servidor: O servidor encontrou uma condição inesperada.";
        break;
      case 503:
        message =
            "Serviço Indisponível: O servidor não está conseguindo processar a solicitação.";
        break;
      default:
        message = "Ocorreu um erro desconhecido: ${response.statusCode}";
        break;
    }

    return InfraError(
      message: message,
    );
  }
}
