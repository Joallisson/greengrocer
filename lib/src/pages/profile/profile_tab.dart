import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/commom_widgets/custom_text_field.dart';
import 'package:greengrocer/src/services/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil do usuário"),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        physics: const BouncingScrollPhysics(),
        children: [
          //EMAIL
          CustomTextField(
              readOnly: true,
              initialValue: authController.user.email,
              icon: Icons.email,
              label: "email"),

          //NOME
          CustomTextField(
              readOnly: true,
              initialValue: authController.user.name,
              icon: Icons.person,
              label: "Nome"),

          //CELULAR
          CustomTextField(
              readOnly: true,
              initialValue: authController.user.phone,
              icon: Icons.phone,
              label: "Celular"),

          //CPF
          CustomTextField(
            readOnly: true,
            initialValue: authController.user.cpf,
            icon: Icons.file_copy,
            label: "CPF",
            isSecret: true,
          ),

          //BOTÃO PARA ATUALIZAR SENHA
          SizedBox(
            height: 50,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.green),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  updatePassword();
                },
                child: const Text("Atualizar senha")),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

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
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //TÍTULO
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "Atualização de senha",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        //SENHA ATUAL
                        CustomTextField(
                          isSecret: true,
                          icon: Icons.lock,
                          label: "Senha atual",
                          validator: passwordValidator,
                          controller: currentPasswordController,
                        ),

                        //NOVA SENHA
                        CustomTextField(
                          isSecret: true,
                          icon: Icons.lock_outline,
                          label: "Nova senha",
                          validator: passwordValidator,
                          controller: newPasswordController,
                        ),

                        //CONFIRMAR NOVA SENHA
                        CustomTextField(
                          isSecret: true,
                          icon: Icons.lock_outline,
                          label: "Confirmar nova senha",
                          validator: (password) {
                            final result = passwordValidator(password);

                            if (result != null) {
                              return result;
                            }

                            if (password != newPasswordController.text) {
                              return 'As senhas devem ser iguais';
                            }

                            return null;
                          },
                        ),

                        //BOTÃO DE CONFIRMAÇÃO
                        SizedBox(
                          height: 45,
                          child: Obx(
                            () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        await authController.changePassword(
                                          currentPassword: currentPasswordController.text,
                                          newPassword: newPasswordController.text,
                                        );
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text("Atualizar"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                //BOTÃO DE FECHAR SHOW DIALOG DE ATUALIZA SENHA
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                )
              ],
            ),
          );
        });
  }
}
