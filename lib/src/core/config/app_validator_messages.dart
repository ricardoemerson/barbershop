class AppValidatorMessages {
  static AppValidatorMessages? _instance;

  AppValidatorMessages._();

  static AppValidatorMessages get instance {
    _instance ??= AppValidatorMessages._();

    return _instance!;
  }

  String get required => 'Por favor, preencha este campo.';
  String get email => 'Por favor, informe um e-mail válido.';
  String get compare => 'Valor de confirmação não é válido.';
  String get cpf => 'Por favor, informe um CPF válido.';
  String get cnpj => 'Por favor, informe um CNPJ válido.';
  String get number => 'Por favor, informe um número válido.';

  String min(int minChars) => 'Este campo precisa ter pelo menos $minChars caracteres.';

  String max(int maxChars) => 'Este campo precisa ter no máximo $maxChars caracteres.';
}
