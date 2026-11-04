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
            Icon(Icons.agriculture),
            SizedBox(width: 10),
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
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
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
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AreaCalculatorPage()),
              ),
            ),
            _ToolCard(
              icon: Icons.route_outlined,
              title: 'Planejar passadas',
              subtitle: 'Calcule linhas conforme a largura do implemento.',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PassPlannerPage()),
              ),
            ),
            const _ToolCard(
                icon: Icons.map_outlined,
                title: 'Mapa dos talhões',
                subtitle: 'Desenho de áreas no mapa por satélite.',
                comingSoon: true),
            const _ToolCard(
                icon: Icons.agriculture_outlined,
                title: 'Operações agrícolas',
                subtitle: 'Pulverização, plantio e fertilização.',
                comingSoon: true),
            const _ToolCard(
                icon: Icons.warning_amber_outlined,
                title: 'Obstáculos e exclusões',
                subtitle: 'Áreas que a máquina deve evitar.',
                comingSoon: true),
            const SizedBox(height: 12),
            const Text(
                'Versão inicial de testes. Os cálculos de passadas são estimativas; navegação por GPS será adicionada em etapa futura.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 12)),
          ],
        ),
      );
}

class _ToolCard extends StatelessWidget {
  const _ToolCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.comingSoon = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool comingSoon;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          leading: Icon(icon, size: 30, color: const Color(0xFF246B35)),
          title: Text(title,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(subtitle),
          trailing: Icon(
              comingSoon ? Icons.lock_outline : Icons.chevron_right,
              color: Colors.black45),
          onTap: onTap ??
              () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Esta ferramenta será liberada em uma próxima atualização.')),
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
        const SnackBar(
            content: Text('Informe comprimento e largura válidos em metros.')),
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
            const Text(
                'Informe as medidas em metros para calcular a área aproximada.'),
            const SizedBox(height: 22),
            TextField(
              controller: lengthController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                  labelText: 'Comprimento (metros)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.straighten)),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: widthController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                  labelText: 'Largura (metros)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.width_full)),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
                onPressed: calculate,
                icon: const Icon(Icons.calculate),
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
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF246B35))),
                    Text('${(hectares! * 10000).toStringAsFixed(1)} m²'),
                  ]),
                ),
              ),
            ],
            const SizedBox(height: 16),
            const Text(
                'Cálculo para talhão retangular. Áreas irregulares serão calculadas pelo desenho do polígono no mapa.',
                style: TextStyle(color: Colors.black54, fontSize: 12)),
          ],
        ),
      );
}

class PassPlannerPage extends StatefulWidget {
  const PassPlannerPage({super.key});

  @override
  State<PassPlannerPage> createState() => _PassPlannerPageState();
}

class _PassPlannerPageState extends State<PassPlannerPage> {
  final lengthController = TextEditingController();
  final fieldWidthController = TextEditingController();
  final implementController = TextEditingController(text: '24');
  final overlapController = TextEditingController(text: '5');
  String operation = 'Pulverização';
  int? passes;
  double? effectiveWidth;
  double? totalDistance;
  double? area;

  double? parse(String value) =>
      double.tryParse(value.trim().replaceAll(',', '.'));

  void calculate() {
    final length = parse(lengthController.text);
    final fieldWidth = parse(fieldWidthController.text);
    final implementWidth = parse(implementController.text);
    final overlap = parse(overlapController.text);

    if (length == null ||
        fieldWidth == null ||
        implementWidth == null ||
        overlap == null ||
        length <= 0 ||
        fieldWidth <= 0 ||
        implementWidth <= 0 ||
        overlap < 0 ||
        overlap >= 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Confira as medidas. A sobreposição deve ser entre 0 e 99%.')),
      );
      return;
    }

    final workingWidth = implementWidth * (1 - overlap / 100);
    setState(() {
      effectiveWidth = workingWidth;
      passes = (fieldWidth / workingWidth).ceil();
      totalDistance = (fieldWidth / workingWidth).ceil() * length;
      area = length * fieldWidth / 10000;
    });
  }

  @override
  void dispose() {
    lengthController.dispose();
    fieldWidthController.dispose();
    implementController.dispose();
    overlapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Planejar passadas')),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('Dados do talhão e implemento',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
                'Informe as dimensões retangulares e a largura real do implemento.'),
            const SizedBox(height: 18),
            DropdownButtonFormField<String>(
              value: operation,
              decoration: const InputDecoration(
                  labelText: 'Tipo de operação', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(
                    value: 'Pulverização', child: Text('Pulverização')),
                DropdownMenuItem(value: 'Plantio', child: Text('Plantio')),
                DropdownMenuItem(
                    value: 'Fertilização', child: Text('Fertilização')),
              ],
              onChanged: (value) =>
                  setState(() => operation = value ?? operation),
            ),
            const SizedBox(height: 14),
            _numberField(lengthController, 'Comprimento do talhão (m)'),
            const SizedBox(height: 12),
            _numberField(fieldWidthController, 'Largura do talhão (m)'),
            const SizedBox(height: 12),
            _numberField(implementController, 'Largura do implemento (m)'),
            const SizedBox(height: 12),
            _numberField(overlapController, 'Sobreposição desejada (%)'),
            const SizedBox(height: 18),
            FilledButton.icon(
                onPressed: calculate,
                icon: const Icon(Icons.route),
                label: const Text('Calcular passadas')),
            if (passes != null) ...[
              const SizedBox(height: 20),
              Card(
                color: const Color(0xFFE4EFDF),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(operation.toUpperCase(),
                          style: const TextStyle(
                              color: Color(0xFF246B35),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1)),
                      const SizedBox(height: 12),
                      _result('Número estimado de passadas', '$passes'),
                      _result('Largura útil por passada',
                          '${effectiveWidth!.toStringAsFixed(2)} m'),
                      _result('Distância em linhas retas',
                          '${totalDistance!.toStringAsFixed(0)} m'),
                      _result('Área do talhão', '${area!.toStringAsFixed(3)} ha'),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 14),
            const Text(
                'Estimativa simplificada para talhão retangular. Não considera manobras, bordaduras, obstáculos, relevo ou curvas. Não use este cálculo como orientação automática da máquina.',
                style: TextStyle(color: Colors.black54, fontSize: 12)),
          ],
        ),
      );

  Widget _numberField(TextEditingController controller, String label) =>
      TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.straighten)),
      );

  Widget _result(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(label)),
            const SizedBox(width: 12),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
}
