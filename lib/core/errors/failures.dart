sealed class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Pas de connexion Internet']);
}

class ProductNotFoundFailure extends Failure {
  final String barcode;
  const ProductNotFoundFailure(this.barcode)
      : super('Produit introuvable pour ce code-barres');
}

class IncompleteDataFailure extends Failure {
  const IncompleteDataFailure([
    super.message =
        'Les informations nutritionnelles sont incomplètes pour ce produit',
  ]);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Erreur serveur, réessayez plus tard']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Une erreur est survenue']);
}
