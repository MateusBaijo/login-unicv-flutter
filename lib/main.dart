import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'cadastro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remova a faixa de debug da tela
      home: TelaLogin(),
    );
  }
}

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _chaveForm = GlobalKey<FormState>();
  var _modoLogin = true;
  var _emailInserido = '';
  var _senhaInserida = '';
  final String _nomeUsuarioInserido = '';
  final Logger _logger = Logger();
  String? _cursoSelecionado;

  void _enviar() async {
    if (!_chaveForm.currentState!.validate()) {
      return;
    }

    _chaveForm.currentState!.save();

    try {
      if (_modoLogin) {
        //logar usuario
        _logger.d(
            'Usuário Logado. Email: $_emailInserido, Senha: $_senhaInserida, Curso: $_cursoSelecionado');
      } else {
        //criar usuario
        _logger.d(
            'Usuário Criado. Email: $_emailInserido, Senha: $_senhaInserida, Nome de Usuário: $_nomeUsuarioInserido, Curso: $_cursoSelecionado');
      }
    } catch (_) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha na autenticação.'),
        ),
      );
    }
  }

  void _irParaCadastro(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Cadastro()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 248, 247),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: Color.fromARGB(
              255, 46, 145, 87), // Cor da barra de navegação inferior
          toolbarHeight: 0,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(),
                child: Container(
                  width: 300,
                  child: Image.asset('assets/unicv-logo-site.png'),
                ),
              ),

              const SizedBox(height: 0),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 0),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              SizedBox(
                width: 250,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        !value.contains('@')) {
                      return 'Por favor, insira um endereço de email válido.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _emailInserido = value!;
                  },
                ),
              ),

              const SizedBox(height: 12),
              SizedBox(
                width: 250,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: const OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _senhaInserida = value!;
                  },
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                // Definindo largura fixa para o botão
                width: 100,
                child: ElevatedButton(
                  onPressed: _enviar,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 29, 94, 56),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  child: Text(
                    _modoLogin ? 'Entrar' : 'Cadastrar',
                    style: TextStyle(
                      color: Colors.white, // Cor do texto
                    ),
                  ),
                ),
              ),

              SizedBox(
                  height: 50), // Adicionado espaço entre o botão e o rodapé
              TextButton(
                onPressed: () {
                  _irParaCadastro(context); // Use a função _irParaCadastro
                },
                child: Text(
                  'Não possui uma conta? Registre-se aqui',
                  style: TextStyle(color: Color.fromARGB(255, 5, 61, 13)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
