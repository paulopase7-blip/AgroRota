# AgroRota 🚜

Aplicativo Flutter para planejamento de operações agrícolas.

## Primeira versão

- Painel inicial do AgroRota.
- Calculadora de área para talhões retangulares (comprimento × largura).
- Estrutura inicial para mapa, planejamento de passadas, operações e áreas de exclusão.

## Executar localmente

É necessário ter Flutter instalado:

```bash
flutter pub get
flutter run
```

## Gerar APK Android

```bash
flutter build apk --release
```

O APK será gerado em `build/app/outputs/flutter-apk/app-release.apk`.

## Próximas etapas

1. Configurar e validar o projeto Android.
2. Adicionar mapa e imagens de satélite.
3. Desenhar polígonos e calcular áreas irregulares.
4. Criar planejamento de passadas com largura configurável.
5. Adicionar GPS, obstáculos e áreas de exclusão.

> Esta é uma versão inicial de desenvolvimento. Os recursos listados como próximos passos ainda não estão implementados.
