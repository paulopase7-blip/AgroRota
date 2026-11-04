import 'package:flutter/material.dart';

void main() {
  runApp(const AgroRotaApp());
}

class AgroRotaApp extends StatelessWidget {
  const AgroRotaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroRota',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AgroRota'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Planejamento agrícola inteligente',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Organize suas operações no campo em um só lugar.'),
          const SizedBox(height: 24),
          _FeatureCard(
            icon: Icons.map_outlined,
            title: 'Mapear lavoura',
            subtitle: 'Desenhe talhões e calcule a área.',
            onTap: () => _showComingSoon(context),
          ),
          _FeatureCard(
            icon: Icons.route,
            title: 'Planejar passadas',
            subtitle: 'Configure a largura do implemento e as linhas de trabalho.',
            onTap: () => _showComingSoon(context),
          ),
          _FeatureCard(
            icon: Icons.agriculture,
            title: 'Operações agrícolas',
            subtitle: 'Pulverização, fertilização e plantio.',
            onTap: () => _showComingSoon(context),
          ),
          _FeatureCard(
            icon: Icons.warning_amber_outlined,
            title: 'Obstáculos e exclusões',
            subtitle: 'Marque áreas que as máquinas devem evitar.',
            onTap: () => _showComingSoon(context),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Este recurso será desenvolvido na próxima etapa.')),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
