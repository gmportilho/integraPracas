import 'dart:convert';

class Usuario {
  final String id;
  final String cpf;
  final String email;
  final String senha;
  final String? endereco;
  
  Usuario({
    required this.id,
    required this.cpf,
    required this.email,
    required this.senha,
    this.endereco,
  });

  
  

  Usuario copyWith({
    String? id,
    String? cpf,
    String? email,
    String? senha,
    String? endereco,
  }) {
    return Usuario(
      id: id ?? this.id,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      endereco: endereco ?? this.endereco,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cpf': cpf,
      'email': email,
      'senha': senha,
      'endereco': endereco,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      cpf: map['cpf'],
      email: map['email'],
      senha: map['senha'],
      endereco: map['endereco'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Usuario(id: $id, cpf: $cpf, email: $email, senha: $senha, endereco: $endereco)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Usuario &&
      other.id == id &&
      other.cpf == cpf &&
      other.email == email &&
      other.senha == senha &&
      other.endereco == endereco;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      cpf.hashCode ^
      email.hashCode ^
      senha.hashCode ^
      endereco.hashCode;
  }
}
