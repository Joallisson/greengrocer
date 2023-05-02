import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/commom_widgets/custom_text_field.dart';
import 'package:greengrocer/src/config/app_data.dart' as appData;

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil do usuário"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        physics: const BouncingScrollPhysics(),
        children: const [

          //EMAIL
          CustomTextField(
            icon: Icons.email,
            label: "email"
          ),

          //NOME
          CustomTextField(
            icon: Icons.person,
            label: "Nome"
          ),

          //CELULAR
          CustomTextField(
            icon: Icons.phone,
            label: "Celular"
          ),

          //CPF
          CustomTextField(
            icon: Icons.file_copy,
            label: "email",
            isSecret: true,
          ),

          //BOTÃO PARA ATUALIZAR SENHA

        ],
      ),
    );
  }
}