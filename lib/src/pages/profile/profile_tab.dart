import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercadinho/src/pages/auth/controller/auth_controller.dart';
import 'package:mercadinho/src/pages/common_widgets/custom_text_field.dart';
import 'package:mercadinho/src/services/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil do Usuário"),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          // Email
          CustomTextField(
            icon: Icons.email,
            label: "Email",
            initialValue: authController.user.email,
            readOnly: true,
          ),
          // Nome
          CustomTextField(
            icon: Icons.person,
            label: "Nome",
            initialValue: authController.user.name,
            readOnly: true,
          ),
          // Celular
          CustomTextField(
            icon: Icons.phone,
            label: "Celular",
            initialValue: authController.user.phone,
            readOnly: true,
          ),
          // CPF
          CustomTextField(
            icon: Icons.file_copy,
            label: "CPF",
            isSecret: true,
            initialValue: authController.user.cpf,
            readOnly: true,
          ),
          // Botao para atualizar a senha
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: const BorderSide(
                  color: Colors.green,
                ),
              ),
              onPressed: () {
                updatePassword();
              },
              child: const Text("Atualizar Senha"),
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Titulo
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'Atualização de Senha',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // Senha atual
                        CustomTextField(
                          icon: Icons.lock,
                          label: "Senha Atual",
                          controller: currentPasswordController,
                          validator: passwordValidator,
                          isSecret: true,
                        ),
                        // Nova Senha
                        CustomTextField(
                          icon: Icons.lock_outline,
                          label: "Nova Senha",
                          validator: passwordValidator,
                          controller: newPasswordController,
                          isSecret: true,
                        ),
                        // Repita Senha
                        CustomTextField(
                          icon: Icons.lock_outline,
                          label: "Confirmar Nova Senha",
                          validator: (password) {
                            final result = passwordValidator(password);
                            if (result != null) {
                              return result;
                            }
                            if (password != newPasswordController.text) {
                              return "Senha diferem";
                            }
                            return null;
                          },
                          isSecret: true,
                        ),
                        // botao de confirmacao
                        SizedBox(
                          height: 45,
                          child: Obx(
                            () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        authController.changePassword(
                                          currentPassword:
                                              currentPasswordController.text,
                                          newPassword:
                                              newPasswordController.text,
                                        );
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text("Atualizar"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
