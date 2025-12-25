🌐 AWS VPC Infrastructure with Terraform
Este repositório contém o primeiro módulo de um projeto de infraestrutura robusta na AWS, focado na criação de uma Virtual Private Cloud (VPC) utilizando Terraform.

O objetivo principal foi aplicar boas práticas de Infraestrutura como Código (IaC), garantindo modularidade, escalabilidade e segurança na segregação de redes.

🚀 Tecnologias Utilizadas
Terraform: Orquestração de infraestrutura.

AWS: Provedor de nuvem.

S3: Backend remoto para armazenamento do tfstate com segurança.

🏗️ Arquitetura do Projeto
A VPC foi desenhada com os seguintes componentes:

Subnets Públicas: Configuradas com Internet Gateway (IGW) para tráfego externo.

Subnets Privadas: Isoladas, preparadas para camadas de banco de dados e aplicações internas.

Tabelas de Rotas: Segregação clara entre tráfego público e privado.

Multi-AZ: Distribuição das subnets em diferentes zonas de disponibilidade para alta disponibilidade.

🛠️ Diferenciais Técnicos Aplicados
Modularização: O código da rede foi isolado em um módulo reutilizável em modules/vpc.

Uso de for_each: Implementado para criação dinâmica de subnets, evitando problemas de indexação comuns ao usar count.

Backend Remoto: Configuração de estado no S3 para permitir colaboração e evitar perda de dados localmente.

Parametrização: Uso extensivo de variáveis (variables.tf) e valores separados (terraform.tfvars).

📁 Estrutura de Arquivos
Plaintext

.
├── main.tf           # Chamada do módulo network
├── variables.tf      # Variáveis globais da raiz
├── terraform.tfvars  # Definição dos valores das variáveis
├── backend.tf        # Configuração do S3 Backend
├── provider.tf       # Configuração do provider AWS e Tags padrão
├── modules/
│   └── vpc/          # Lógica interna da VPC (Recursos, Vars e Outputs)
