import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLogged = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
  }

  void _login() {
    // Simular la lógica de inicio de sesión aquí
    // En un caso real, verificarías las credenciales del usuario
    // y establecerías _isLogged en verdadero si el inicio de sesión es exitoso.

    setState(() {
      _isLogged = true;
    });

    // Navegar a la pantalla de inicio cuando el inicio de sesión sea exitoso
    Navigator.pushNamed(context, '/dash');

    if (_rememberMe) {
      // Guarda la preferencia "Mantener sesión iniciada" si el checkbox está marcado
      _saveRememberMePreference(true);
    }
  }

  Future<void> _saveRememberMePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_isLogged)
              Column(
                children: [
                  Text('Has iniciado sesión correctamente.'),
                  // Aquí puedes mostrar otros elementos relacionados con la sesión iniciada
                ],
              )
            else
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Usuario'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
                      Text('Mantener sesión iniciada'),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _login(); // Simula el inicio de sesión
                    },
                    child: Text('Iniciar Sesión'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
