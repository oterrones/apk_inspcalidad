import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Main entry point
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

// Login Page
class LoginPage extends StatelessWidget {
  final RxBool _passwordVisible = false.obs; // Estado para visibilidad de la contraseña
  final RxBool _rememberMe = false.obs; // Estado para el checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade600, Colors.blue.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Contenedor principal que contiene el formulario
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container que encapsula todo el formulario
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Logo
                          Image.asset(
                            'assets/img/logo_agrovision.png',
                            height: 100,
                          ),
                          const SizedBox(height: 20),
                          // Usuario
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Usuario",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Contraseña con botón de "ojo"
                          Obx(
                                () => TextField(
                              obscureText: !_passwordVisible.value,
                              decoration: InputDecoration(
                                labelText: "Contraseña",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    _passwordVisible.value =
                                    !_passwordVisible.value;
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Botón Iniciar Sesión
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Color del botón
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30), // Bordes
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 40), // Tamaño del botón
                            ),
                            onPressed: () {
                              // Acción del botón
                              Get.snackbar(
                                "Iniciar Sesión",
                                "Credenciales ingresadas correctamente",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                            },
                            child: const Text(
                              "Iniciar Sesión",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold, // Texto en negrita
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Checkbox Recordar Credenciales
                          Obx(
                                () => CheckboxListTile(
                              title: const Text("Recordar credenciales"),
                              value: _rememberMe.value,
                              onChanged: (value) {
                                _rememberMe.value = value ?? false;
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Olvidé mi contraseña en la parte inferior
            Positioned(
              bottom: 20, // Ajusta el valor para el margen inferior
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // Redirigir a la página de recuperación de contraseña
                  Get.to(() => ForgotPasswordPage());
                },
                child: const Text(
                  "Olvidé mi contraseña",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue, // Color del subrayado
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para mostrar el diálogo de sincronización
  void _showSyncDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Evita que el usuario cierre el diálogo
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icono de carga (loading)
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Sincronizando Data",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Espere unos minutos...",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Forgot Password Page
class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade600, Colors.blue.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container que encapsula todo el formulario
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Logo
                      Image.asset(
                        'assets/img/logo_agrovision.png',
                        height: 100,
                      ),
                      const SizedBox(height: 20),
                      // Recuperar Contraseña
                      const Text(
                        "Recuperar Contraseña",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Input de correo
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Correo Electrónico",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Botón Enviar
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Color del botón
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Bordes
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 40), // Tamaño del botón
                        ),
                        onPressed: () {
                          // Acción del botón
                          Get.snackbar(
                            "Recuperar Contraseña",
                            "Te hemos enviado un correo con instrucciones",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        },
                        child: const Text(
                          "Enviar",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold, // Texto en negrita
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Texto para regresar al inicio de sesión
                      GestureDetector(
                        onTap: () {
                          // Acción para ir al formulario de inicio de sesión
                          Get.back();
                        },
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black, // Color por defecto para el texto
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "¿Ya tienes una cuenta? ", // Texto normal
                                style: TextStyle(color: Colors.black), // Puedes cambiar el color si lo deseas
                              ),
                              TextSpan(
                                text: "Iniciar Sesión", // Texto clickeable
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline, // Subrayado
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
