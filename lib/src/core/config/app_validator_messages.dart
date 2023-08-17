sealed class AppValidatorMessages {
  static const required = 'Por favor, preencha este campo.';
  static const email = 'Por favor, informe um e-mail válido.';
  static const compare = 'Valor de confirmação não é válido.';
  static const cpf = 'Por favor, informe um CPF válido.';
  static const cnpj = 'Por favor, informe um CNPJ válido.';
  static const number = 'Por favor, informe um número válido.';

  static String min(int minChars) => 'Este campo precisa ter pelo menos $minChars caracteres.';

  static String max(int maxChars) => 'Este campo precisa ter no máximo $maxChars caracteres.';
}
