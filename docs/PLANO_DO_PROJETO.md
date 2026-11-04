# AgroRota — Plano do projeto

## Objetivo
Aplicativo Android de planejamento e acompanhamento de operações agrícolas, com mapas, GPS e ferramentas de precisão. Desenvolver por etapas, validando cada etapa em aparelho real antes de avançar.

## Funcionalidades previstas

### 1. Cadastro e mapa de propriedades
- Cadastrar propriedades, áreas e talhões.
- Visualizar mapa base e imagem de satélite por provedor compatível e com as devidas licenças.
- Desenhar, editar e salvar limites dos talhões.
- Calcular área em hectares e perímetro.

### 2. Planejamento de operações
- Pulverização, plantio e fertilização.
- Configurar largura de trabalho do implemento, espaçamento e sobreposição.
- Gerar linhas de passadas conforme direção, padrão e limites do talhão.
- Estimar passadas, distância e área planejada.

### 3. Obstáculos e zonas de exclusão
- Registrar obstáculos como árvores, postes, pedras e açudes.
- Desenhar zonas que a máquina deve evitar.
- Considerar limites e zonas de exclusão no planejamento das linhas.

### 4. GPS durante a operação
- Mostrar posição atual da máquina no mapa.
- Exibir orientação e linhas planejadas durante o deslocamento.
- Registrar trajeto, cobertura realizada e áreas ainda não trabalhadas.
- Indicar precisão/qualidade do sinal quando disponível.
- Tratar perda de sinal e avisar que GPS de celular pode não ter precisão suficiente para orientar operações de alta precisão.

### 5. GPS de alta precisão e equipamentos
- Prever integração com receptores GNSS externos compatíveis.
- Planejar suporte a correções RTK quando o receptor, serviço de correção e região oferecerem suporte.
- Exibir o estado da conexão, qualidade do posicionamento e alertas de perda de correção.
- Criar cadastro de máquinas e tratores, com apelido, modelo e configurações.
- Criar cadastro de implementos: pulverizador, plantadeira, distribuidor e outros.
- Salvar largura de trabalho, espaçamento e demais configurações por implemento.
- Permitir selecionar máquina e implemento antes de iniciar uma operação.
- Desenvolver integrações específicas com monitores e controladores somente após validar os protocolos e formatos de cada fabricante.

### 6. Histórico e gestão
- Salvar operações por propriedade, talhão, data e tipo.
- Registrar máquina, implemento, largura, produtos e quantidades informadas.
- Gerar relatórios de área planejada e realizada, distância e histórico.

### 7. Uso sem internet
- Guardar dados, talhões, operações e mapas previamente baixados.
- Permitir consultar e registrar operações offline.
- Sincronizar alterações quando a conexão voltar.
- Respeitar limites de cache e licenças do provedor de mapas.

### 8. Importação e exportação
- Planejar suporte a formatos geográficos como GeoJSON e KML.
- Avaliar formatos de linhas e mapas aceitos por cada marca/modelo de monitor agrícola antes de prometer compatibilidade.
- Exportar relatórios em PDF/CSV.

## Etapas de desenvolvimento
1. Base Android compilável e primeira instalação de teste.
2. Mapa, localização e cadastro de propriedade/talhão.
3. Desenho de polígonos e cálculo de hectares.
4. Cadastro de máquinas/implementos, largura de trabalho e geração de linhas.
5. Obstáculos e zonas de exclusão.
6. GPS em operação e registro de cobertura.
7. Integração GNSS externo e avaliação de RTK.
8. Histórico, relatórios e exportações.
9. Mapas offline, sincronização e testes em campo.
10. Compatibilidade de importação/exportação com equipamentos específicos.

## Critérios importantes
- Testar cada etapa no Android antes de avançar.
- Não afirmar precisão centimétrica usando apenas GPS comum de celular.
- Para orientação de alta precisão, avaliar receptores GNSS externos e correções RTK, conforme equipamento e região.
- Validar segurança operacional: o aplicativo é uma ferramenta de apoio e o operador deve manter atenção ao terreno e às condições reais.
- Usar serviços de mapas conforme seus termos, limites e licenças.

## Estado atual
- Estrutura Flutter inicial criada.
- Tela inicial provisória criada.
- Workflow do GitHub Actions configurado para tentar gerar APK Android.
- Próxima entrega: confirmar compilação e instalar o primeiro APK de teste; depois iniciar mapa e cadastro de talhões.
