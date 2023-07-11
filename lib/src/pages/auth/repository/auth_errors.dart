String authErrorsStr(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return "Email e/ou senha inválidos";
    case 'Invalid session token':
      return 'Token inválido!';
    case 'INVALID_FULLNAME':
      return 'Nome inválido!';
    case 'INVALID_PHONE':
      return 'Fone inválido!';
    case 'INVALID_CPF':
      return 'CPF inválido!';
    default:
      return "Algum outro erro";
  }
}
