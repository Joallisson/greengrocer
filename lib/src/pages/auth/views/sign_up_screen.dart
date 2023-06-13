import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:greengrocer/src/pages/commom_widgets/custom_text_field.dart';
import 'package:greengrocer/src/services/validators.dart' as validators;

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final cpfFormatter = MaskTextInputFormatter(
      mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});

  final phoneFormatter = MaskTextInputFormatter(
      mask: "(##) # ####-####", filter: {"#": RegExp(r'[0-9]')});

  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              //TELA COM TÍTULO E FORMULÁRIO
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    //TÍTULO CADASTRO
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Cadastro",
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      ),
                    ),

                    //FORMULÁRIO
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 40),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(45))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            icon: Icons.email,
                            label: "Email",
                            textInputType: TextInputType.emailAddress,
                            validator: validators.emailValidator,
                            onSaved: (value) {
                              authController.user.email = value;
                            },
                          ),
                          CustomTextField(
                              icon: Icons.lock,
                              label: "Senha",
                              isSecret: true,
                              validator: validators.passwordValidator,
                              onSaved: (value) {
                                authController.user.password = value;
                              }),
                          CustomTextField(
                              icon: Icons.person,
                              label: "Nome",
                              validator: validators.nameValidator,
                              onSaved: (value) {
                                authController.user.name = value;
                              }),
                          CustomTextField(
                              icon: Icons.phone,
                              label: "Celular",
                              inputFormatters: [phoneFormatter],
                              textInputType: TextInputType.phone,
                              validator: validators.phoneValidator,
                              onSaved: (value) {
                                authController.user.phone = value;
                              }),
                          CustomTextField(
                              icon: Icons.file_copy,
                              label: "CPF",
                              inputFormatters: [cpfFormatter],
                              textInputType: TextInputType.number,
                              validator: validators.cpfValidor,
                              onSaved: (value) {
                                authController.user.cpf = value;
                              }),

                          //BOTÃO Cadastrar Usuário
                          SizedBox(
                            height: 50,
                            child: Obx(() {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(28))),
                                onPressed: authController.isLoading.value
                                    ? null
                                    : () {

                                        FocusScope.of(context).unfocus();

                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          authController.signUp();
                                        }
                                      },
                                child: authController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        "Cadastrar usuário",
                                        style: TextStyle(fontSize: 18),
                                      ),
                              );
                            }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              //BOTÃO DE VOLTAR
              Positioned(
                left: 10,
                top: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
