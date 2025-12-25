# 🌐 AWS Infrastructure with Terraform (Modular)

Este repositório contém um projeto de infraestrutura escalável na AWS, utilizando **Terraform**. O foco principal é a aplicação de **boas práticas de Infraestrutura como Código (IaC)**, garantindo modularidade, segurança e automação.



---

## 🚀 Tecnologias Utilizadas

* **Terraform**: Orquestração e automação de infraestrutura.
* **AWS**: Provedor de nuvem líder de mercado.
* **S3**: Backend remoto para armazenamento do estado (`tfstate`) com segurança e suporte a State Locking.

---

## 🏗️ Arquitetura do Projeto

A infraestrutura é composta por camadas modulares e interdependentes:

### 📡 Network Layer (VPC & Connectivity)
* **Subnets Públicas**: Associadas a um **Internet Gateway (IGW)** para tráfego externo.
* **Subnets Privadas**: Isoladas para camadas de dados, seguindo o princípio de privilégio mínimo.
* **NAT Gateway**: Implementado em subnet pública com **Elastic IP (EIP)**, permitindo que recursos nas subnets privadas acessem a internet para atualizações sem exposição direta.
* **Route Tables**: Tabelas distintas para gerenciar o fluxo de saída via IGW (Público) e NAT Gateway (Privado).

### 🛡️ Security Layer (Firewall)
* **Security Groups**: Regras de firewall *stateful* configuradas para permitir **SSH (22)** e **HTTP (80)**.
* **Egress Control**: Saída total liberada (`0.0.0.0/0`) para permitir que as instâncias realizem patches de segurança.

### 💻 Compute Layer (Web Server)
* **EC2 Instance**: Servidor Ubuntu 22.04 LTS provisionado em subnet pública.
* **Bootstrap (User Data)**: Automação via script shell para instalação e configuração automática do servidor **Nginx** no primeiro boot.
* **Connectivity**: Validação de conectividade externa via IP público e interna via rotas NAT.

---

## 🛠️ Diferenciais Técnicos Aplicados

* **Orquestração de NAT Gateway**: Configuração de conectividade segura para redes privadas, um padrão essencial para ambientes produtivos.
* **Modularização Avançada**: Separação total entre Network, Security e EC2, facilitando a manutenção e testes isolados.
* **Interdependência Dinâmica**: Uso de `outputs` e `inputs` para conectar módulos (VPC -> Security -> EC2) sem valores fixos (hardcoded).
* **Backend Remoto**: Uso de S3 para persistência de estado, permitindo colaboração e segurança dos dados da infraestrutura.
* **Tags Padronizadas**: Governança aplicada através de `default_tags` no provider para rastreio de recursos e custos.

---

## 📁 Estrutura de Arquivos

```plaintext
.
├── main.tf             # Orquestrador: chama os módulos Network, Security e EC2
├── variables.tf        # Variáveis globais da raiz
├── terraform.tfvars    # Valores reais (excluído do Git via .gitignore)
├── backend.tf          # Configuração do backend remoto S3
├── provider.tf         # Configuração do provider AWS e tags padrão
└── modules/
    ├── vpc/            # Rede: VPC, Subnets, IGW, NAT Gateway, EIP e Rotas
    ├── security/       # Segurança: Security Groups e Regras de Acesso
    └── ec2/            # Computação: Instâncias EC2 e Cloud-Init (User Data)