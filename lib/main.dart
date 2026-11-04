import 'package:flutter/material.dart';

void main() => runApp(const AgroRotaApp());

class AgroRotaApp extends StatelessWidget {
  const AgroRotaApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'AgroRota',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF246B35)),
      scaffoldBackgroundColor: const Color(0xFFF5F7F2),
      useMaterial3: true,
    ),
    home: const HomePage(),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Row(children: [
        Icon(Icons.agriculture), SizedBox(width: 10),
        Text('AgroRota', style: TextStyle(fontWeight: FontWeight.bold)),
      ]),
      backgroundColor: const Color(0xFFE4EFDF),
    ),
    body: ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF246B35),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PLANEJAMENTO AGRÍCOLA',
                  style: TextStyle(color: Colors.white70, letterSpacing: 1.1)),
              SizedBox(height: 8),
              Text('Sua lavoura,\nmais organizada.',
                  style: TextStyle(color: Colors.white, fontSize: 27,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Organize talhões e operações em um só lugar.',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const Text('Ferramentas',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _ToolCard(
          icon: Icons.calculate_outlined,
          title: 'Calculadora de área',
          subtitle: 'Calcule hectares pelas medidas do talhão.',
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AreaCalculatorPage())),
        ),
        const _ToolCard(icon: Icons.map_outlined, title: 'Mapa dos talhões',
            subtitle: 'Desenho de áreas no mapa por satélite.', comingSoon: true),
        const _ToolCard(icon: Icons.route_outlined, title: 'Planejar passadas',
            subtitle: 'Largura do implemento e linhas de trabalho.', comingSoon: true),
        const _ToolCard(icon: Icons.agriculture_outlined, title: 'Operações agrícolas',
            subtitle: 'Pulverização, plantio e fertilização.', comingSoon: true),
        const _ToolCard(icon: Icons.warning_amber_outlined, title: 'Obstáculos e exclusões',
            subtitle: 'Áreas que a máquina deve evitar.', comingSoon: true),
        const SizedBox(height: 12),
        const Text('Versão inicial de testes. Mapa, GPS e navegação serão adicionados nas próximas etapas.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 12)),
      ],
    ),
  );
}

class _ToolCard extends StatelessWidget {
  const _ToolCard({required this.icon, required this.title, required this.subtitle,
    this.onTap, this.comingSoon = false});
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool comingSoon;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      leading: Icon(icon, size: 30, color: const Color(0xFF246B35)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: Icon(comingSoon ? Icons.lock_outline : Icons.chevron_right,
          color: Colors.black45),
      onTap: onTap ?? () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Esta ferramenta será liberada em uma próxima atualização.')),
      ),
    ),
  );
}

class AreaCalculatorPage extends StatefulWidget {
  const AreaCalculatorPage({super.key});
  @override
  State<AreaCalculatorPage> createState() => _AreaCalculatorPageState();
}

class _AreaCalculatorPageState extends State<AreaCalculatorPage> {
  final lengthController = TextEditingController();
  final widthController = TextEditingController();
  double? hectares;

  double? number(String value) =>
      double.tryParse(value.trim().replaceAll(',', '.'));

  void calculate() {
    final length = number(lengthController.text);
    final width = number(widthController.text);
    if (length == null || width == null || length <= 0 || width <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe comprimento e largura válidos em metros.')),
      );
      return;
    }
    setState(() => hectares = (length * width) / 10000);
  }

  @override
  void dispose() {
    lengthController.dispose();
    widthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Calculadora de área')),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Talhão retangular',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Informe as medidas em metros para calcular a área aproximada.'),
        const SizedBox(height: 22),
        TextField(
          controller: lengthController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Comprimento (metros)',
              border: OutlineInputBorder(), prefixIcon: Icon(Icons.straighten)),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: widthController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Largura (metros)',
              border: OutlineInputBorder(), prefixIcon: Icon(Icons.width_normal)),
        ),
        const SizedBox(height: 18),
        FilledButton.icon(onPressed: calculate, icon: const Icon(Icons.calculate),
            label: const Text('Calcular hectares')),
        if (hectares != null) ...[
          const SizedBox(height: 22),
          Card(
            color: const Color(0xFFE4EFDF),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                const Text('Área calculada'),
                const SizedBox(height: 6),
                Text('${hectares!.toStringAsFixed(4)} ha',
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold,
                        color: Color(0xFF246B35))),
                Text('${(hectares! * 10000).toStringAsFixed(1)} m²'),
              ]),
            ),
          ),
        ],
        const SizedBox(height: 16),
        const Text('Cálculo para talhão retangular. Áreas irregulares serão calculadas pelo desenho do polígono no mapa.',
            style: TextStyle(color: Colors.black54, fontSize: 12)),
      ],
    ),
  );
}
