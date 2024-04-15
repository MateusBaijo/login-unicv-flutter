import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(const Cadastro());
}

class Cadastro extends StatelessWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 46, 145, 87),
        toolbarHeight: 60, // Ajusta a altura da AppBar
        title: Text(
          'Centro Universitário Cidade Verde',
          style: TextStyle(
            color: Colors.white, // Cor do texto como branco
          ),
        ),
      ),
      backgroundColor:
          Color.fromARGB(255, 246, 248, 247), // Define o fundo verde
      body: Container(
        height: double.infinity, // Define a altura como infinita
        color: Color.fromARGB(255, 246, 248, 247), // Define o fundo verde
        // Define o fundo verde para a tela inteira
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: CadastroForm(),
                ),
              ),
            ),
            Container(
              color: Color.fromARGB(255, 46, 145, 87),
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: Color.fromARGB(255, 26, 99, 56),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _CadastroFormState? formState =
                            CadastroForm.of(context);
                        if (formState != null && formState.validate()) {
                          formState.save();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Cadastro realizado com sucesso!',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Concluir',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: Color.fromARGB(255, 26, 99, 56),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CadastroForm extends StatefulWidget {
  const CadastroForm({Key? key}) : super(key: key);

  @override
  _CadastroFormState createState() => _CadastroFormState();

  static _CadastroFormState? of(BuildContext context) {
    return context.findAncestorStateOfType<_CadastroFormState>();
  }
}

class _CadastroFormState extends State<CadastroForm> {
  final _chaveForm = GlobalKey<FormState>();
  var _nomeUsuario = '';
  var _senha = '';
  var _ra = '';
  var _email = '';
  var _tipoUsuario;

  final Logger _logger = Logger();

  List<bool> _selections = List.generate(3, (_) => false);

  bool validate() {
    return _chaveForm.currentState!.validate();
  }

  void save() {
    _chaveForm.currentState!.save();
    _logger.d(
        'Nome de Usuário: $_nomeUsuario, Senha: $_senha, Email: $_email, Tipo de Usuário: $_tipoUsuario, R.A.: $_ra');
  }

  final TextEditingController _confirmarSenhaController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _chaveForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: double.infinity, // Define a largura como infinita
                  child: Text(
                    'Crie sua conta',
                    textAlign: TextAlign.center, // Centraliza o texto
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 20, 117, 57),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nome de Usuário',
                    filled: true,
                    fillColor: Color.fromARGB(255, 246, 248,
                        247), // Define a cor de fundo como a mesma cor do plano de fundo
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(fontSize: 15), // Reduz o tamanho da fonte
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, insira um nome de usuário válido.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nomeUsuario = value!;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 15), // Reduz o espaçamento entre os campos
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha',
                filled: true,
                fillColor: Color.fromARGB(255, 246, 248,
                    247), // Define a cor de fundo como a mesma cor do plano de fundo
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Colors.grey[
                          300]!), // Altera a cor da borda para cinza claro
                ),
              ),
              style: TextStyle(fontSize: 15), // Reduz o tamanho da fonte
              obscureText: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor, insira uma senha válida.';
                }
                return null;
              },
              onSaved: (value) {
                _senha = value!;
              },
            ),
          ),
          const SizedBox(height: 15), // Reduz o espaçamento entre os campos
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: _confirmarSenhaController,
              decoration: InputDecoration(
                labelText: 'Confirme sua senha',
                filled: true,
                fillColor: Color.fromARGB(255, 246, 248,
                    247), // Define a cor de fundo como a mesma cor do plano de fundo
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Colors.grey[
                          300]!), // Altera a cor da borda para cinza claro
                ),
              ),
              style: TextStyle(fontSize: 15), // Reduz o tamanho da fonte
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, confirme sua senha.';
                } else if (value != _senha) {
                  return 'As senhas não coincidem.';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 15), // Reduz o espaçamento entre os campos
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'E-mail',
                filled: true,
                fillColor: Color.fromARGB(255, 246, 248,
                    247), // Define a cor de fundo como a mesma cor do plano de fundo
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: TextStyle(fontSize: 15), // Reduz o tamanho da fonte
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty ||
                    !value.contains('@')) {
                  return 'Por favor, insira um endereço de email válido.';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
          ),
          const SizedBox(height: 15), // Reduz o espaçamento entre os campos
          Text(
            'Identificação do usuário:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 16, 102, 49),
            ), // Define a cor do texto como branco
          ),
          const SizedBox(height: 15), // Reduz o espaçamento entre os campos
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _tipoUsuario = 'Estudante';
                    _selections = [true, false, false];
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: _selections[0]
                      ? Color.fromARGB(255, 250, 176, 16)
                      : Color.fromARGB(255, 241, 241, 239), // Cor do texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text('Estudante'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _tipoUsuario = 'Professor';
                    _selections = [false, true, false];
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: _selections[1]
                      ? Color.fromARGB(255, 250, 176, 16)
                      : Color.fromARGB(255, 241, 241, 239), // Cor do texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text('Professor'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _tipoUsuario = 'Coordenador';
                    _selections = [false, false, true];
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: _selections[2]
                      ? Color.fromARGB(255, 250, 176, 16)
                      : Color.fromARGB(255, 241, 241, 239), // Cor do texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text('Coordenador'),
              ),
            ],
          ),
          const SizedBox(height: 18), // Reduz o espaçamento entre os campos
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'R.A Institucional',
                filled: true,
                fillColor: Color.fromARGB(255, 246, 248,
                    247), // Define a cor de fundo como a mesma cor do plano de fundo
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: TextStyle(fontSize: 15), // Reduz o tamanho da fonte
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor, insira um R.A válido.';
                }
                return null;
              },
              onSaved: (value) {
                _ra = value!;
              },
            ),
          ),
          const SizedBox(height: 15), // Reduz o espaçamento entre os campos
        ],
      ),
    );
  }

  @override
  void dispose() {
    _confirmarSenhaController.dispose();
    super.dispose();
  }
}
