# 🌐 AWS Infrastructure with Terraform (Modular)

Este repositório contém um projeto de infraestrutura escalável na AWS, utilizando **Terraform**. O foco principal é a aplicação de **boas práticas de Infraestrutura como Código (IaC)**, garantindo modularidade, segurança e automação.

[Image of AWS VPC architecture with public and private subnets, security groups, and internet gateway]

---

## 🚀 Tecnologias Utilizadas

* **Terraform**: Orquestração e automação de infraestrutura.
* **AWS**: Provedor de nuvem líder de mercado.
* **S3**: Backend remoto para armazenamento do estado (`tfstate`) com segurança e suporte a State Locking.

---

## 🏗️ Arquitetura do Projeto

A infraestrutura é composta por camadas modulares e interdependentes:

### 📡 Network Layer (VPC)
* **Subnets Públicas**: Associadas a um Internet Gateway (IGW) para hospedar serviços externos (ex: Load Balancers, Web Servers).
* **Subnets Privadas**: Isoladas para camadas de dados e aplicações internas, seguindo o princípio de privilégio mínimo.
* **Route Tables**: Segregação de tráfego garantindo que as subnets privadas não tenham exposição direta à internet.

### 🛡️ Security Layer (Firewall)
* **Security Groups**: Regras de firewall *stateful* configuradas especificamente para permitir tráfego **SSH (22)** e **HTTP (80)**.
* **Egress Control**: Saída total liberada para permitir que os recursos internos realizem atualizações de segurança e patches.

[Image of AWS Security Group ingress and egress rules flow]

---

## 🛠️ Diferenciais Técnicos Aplicados

* **Modularização Avançada**: Divisão entre rede e segurança, permitindo que cada módulo evolua de forma independente.
* **Interdependência de Módulos**: O módulo de segurança consome dinamicamente o `vpc_id` exportado pelo módulo de rede via **Outputs**.
* **Uso de `for_each`**: Implementado para a criação dinâmica de subnets e associações, garantindo um código mais limpo e resiliente a mudanças.
* **Backend Remoto Profissional**: Configuração no S3, prática indispensável para ambientes corporativos e trabalho em equipe.
* **Tags Padronizadas**: Governança aplicada através de `default_tags` no provider para facilitar o rastreio de custos e recursos.

---

## 📁 Estrutura de Arquivos

```plaintext
.
├── main.tf             # Orquestrador: chama os módulos Network e Security
├── variables.tf        # Variáveis globais da raiz
├── terraform.tfvars    # Valores reais (excluído do Git via .gitignore)
├── backend.tf          # Configuração do backend remoto S3
├── provider.tf         # Configuração do provider AWS
└── modules/
    ├── vpc/            # Módulo de Rede (VPC, Subnets, IGW, RT)
    └── security/       # Módulo de Segurança (Security Groups)