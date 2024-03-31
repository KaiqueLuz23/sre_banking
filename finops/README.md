## Otimize Custos na AWS: Automatize Inicialização e Interrupção de Instâncias no Amazon EC2 e RDS

Economizar dinheiro na AWS é crucial. Desligar manualmente servidores ociosos é uma prática, mas gerenciar vários servidores manualmente é complicado e demorado. Este script automatiza a parada/inicialização de EC2 e RDS, permitindo agendamento fixo, flexível ou ambos.

Ao interromper instâncias fora do horário comercial e iniciá-las automaticamente quando necessário, você reduz custos operacionais, pois só paga pelas horas de execução. A solução exige configuração única de tags EC2. Implemente o modelo CloudFormation (CFN) conforme indicado abaixo para otimizar seus recursos.

### CloudFormation (CFN) template -
O modelo CloudFormation <code>template/cfn_auto_start_stop_ec2.yaml</code> cria automaticamente todos os recursos da AWS necessários para o funcionamento da solução Amazon EC2. Conclua as etapas a seguir para criar seus recursos AWS por meio do modelo CloudFormation:

1. No console do AWS CloudFormation, escolha Criar pilha.
2. Escolha Com novos recursos (padrão).
3. Escolha O modelo está pronto e escolha Carregar um arquivo de modelo.
4. Carregue o arquivo .yaml fornecido e escolha Próximo.
5. Para o nome da pilha, insira cfn-auto-start-stop-ec2.
6. Modifique os valores dos parâmetros que definem o planejamento cron padrão conforme necessário.
7. Para RegionTZ, escolha qual fuso horário da região usar. Este é o fuso horário da região em que suas instâncias do EC2 estão implantadas e você deseja definir horários convenientes para esse fuso horário específico.
8. Escolha Próximo e forneça tags, se necessário.
9. Escolha Próximo e revise os detalhes da pilha.
10. Marque a caixa de seleção de confirmação porque esse modelo cria uma função e uma política do IAM.
11. Escolha Criar pilha.
12. Abra a pilha e navegue até a guia Recursos para rastrear o status de criação do recurso.

Para excluir todos os recursos criados por meio deste modelo, escolha a pilha no console do AWS CloudFormation e selecione Excluir. Escolha Excluir pilha para confirmar a exclusão da pilha.

### Configurações
Ao implementar esta solução com tags do Amazon EC2, você pode escolher entre duas configurações. Dependendo das necessidades do seu negócio, você pode usar um ou ambos:

* <b>Tempo fixo</b> – Uma configuração de tempo fixo tem os seguintes componentes:
    * Uma única programação se aplica a todas as instâncias do EC2; por exemplo, você precisa iniciar várias instâncias não de produção em um horário fixo, como diariamente às 9h, e interrompê-las às 18h
    * Os horários de início e término são configurados em um cron de regras do EventBridge no fuso horário UTC
    * Você pode habilitar a solução definindo um <code>true</code> valor de sinalização booleana (sem distinção entre maiúsculas e minúsculas) no valor da chave da tag do Amazon EC2
    *Você desativa a configuração não criando tags ou definindo o <code>false</code> booleano (sem distinção entre maiúsculas e minúsculas) na tag do Amazon EC2
    * As chaves da tag são <code>AutoStart</code> e <code>AutoStop</code>
* <b>Horário flexível</b> – Uma configuração de horário flexível possui os seguintes componentes:
    * Um cronograma diferente se aplica a cada instância do EC2; por exemplo, se você deseja iniciar alguns servidores às 7h, alguns às 8h30 e assim por diante, e parar alguns às 16h, outros às 18h e assim por diante
    * Os horários de início e término são configurados em tags do Amazon EC2 no formato HH:MM no fuso horário da região em que o Amazon EC2 está hospedado
    * Você habilita essa configuração definindo o valor de tempo no valor da chave da tag do Amazon EC2
    * Você desativa essa configuração não criando uma tag ou definindo um valor em branco (vazio ou <code>null</code>) na tag do Amazon EC2
    * As chaves de tag são <code>StartWeekDay</code>, <code>StopWeekDay</code>, <code>StartWeekEnd</code>, e <code>StopWeekEnd</code>

### Tags
Configure 6 tags predefinidas no Amazon EC2:

* AutoStart – Defina o valor como <code>True</code> ou <code>False</code> (sem distinção entre maiúsculas e minúsculas) com uma programação definida na regra de início automático
* AutoStop – Defina o valor como <code>True</code> ou <code>False</code> (sem distinção entre maiúsculas e minúsculas) com uma programação definida na regra de parada automática
* StartWeekDay – Defina o valor em HH:MM para iniciar em um dia da semana (segunda a sexta)
* StopWeekDay – Defina o valor em HH:MM para parar em um dia da semana (segunda a sexta)
* StartWeekEnd – Defina o valor em HH:MM para começar em um fim de semana (sábado a domingo)
* StopWeekEnd – Defina o valor em HH:MM para parar em um final de semana (sábado a domingo)