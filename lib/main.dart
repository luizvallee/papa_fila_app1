import 'package:flutter/material.dart';

void main() {
  runApp(const PapaFilaApp());
}

class PapaFilaApp extends StatelessWidget {
  const PapaFilaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Papa-Fila',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
        ),
        useMaterial3: true,
      ),
      home: const ConfiguracoesPage(),
    );
  }
}

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  // Estado do Switch
  bool alertasAtivados = false;

  // Estado do Slider
  double volume = 0;

  // Estado da Mesa Express
  bool mesaExpressSelecionada = false;

  // Redefine todas as configurações
  void redefinirPadroes() {
    setState(() {
      alertasAtivados = false;
      volume = 0;
      mesaExpressSelecionada = false;
    });
  }

  // Exibe o resumo das configurações
  void mostrarResumo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Configurações Salvas'),
          content: Text(
            'Alertas: ${alertasAtivados ? "Ativados" : "Desativados"}\n'
            'Volume: ${volume.round()}%\n'
            'Mesa Express: ${mesaExpressSelecionada ? "Selecionada" : "Não selecionada"}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // [1] APPBAR + ICONBUTTON
      appBar: AppBar(
        title: const Text('Alertas e Entrega'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Sair',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Saindo da tela...'),
                ),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Configurações de Alertas',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // [2] SWITCH
            SwitchListTile(
              title: const Text('Alerta de lanche pronto'),
              subtitle: const Text(
                'Receber aviso quando o pedido estiver pronto',
              ),
              value: alertasAtivados,
              onChanged: (valor) {
                setState(() {
                  alertasAtivados = valor;

                  // Se desligar os alertas,
                  // o volume volta para zero.
                  if (!valor) {
                    volume = 0;
                  }
                });
              },
            ),

            const SizedBox(height: 20),

            Text(
              'Volume do alerta: ${volume.round()}%',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            // [3] SLIDER
            Slider(
              value: volume,
              min: 0,
              max: 100,
              divisions: 10,
              label: '${volume.round()}%',

              // Fica desativado quando o Switch for falso.
              onChanged: alertasAtivados
                  ? (valor) {
                      setState(() {
                        volume = valor;
                      });
                    }
                  : null,
            ),

            const SizedBox(height: 30),

            const Text(
              'Opções de Entrega',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // [4] GESTURE DETECTOR
            GestureDetector(
              onTap: () {
                print('Mesa Selecionada para Entrega!');

                setState(() {
                  mesaExpressSelecionada =
                      !mesaExpressSelecionada;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // Muda a cor ao selecionar.
                  color: mesaExpressSelecionada
                      ? Colors.green
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.table_restaurant,
                      color: mesaExpressSelecionada
                          ? Colors.white
                          : Colors.black,
                    ),

                    const SizedBox(width: 15),

                    Text(
                      'Mesa Express',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: mesaExpressSelecionada
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // [5] TEXTBUTTON
            TextButton(
              onPressed: redefinirPadroes,
              child: const Text(
                'Redefinir Padrões',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),

      // [6] FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: mostrarResumo,
        tooltip: 'Salvar',
        child: const Icon(Icons.save),
      ),
    );
  }
}