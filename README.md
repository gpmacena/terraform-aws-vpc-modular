# 🌐 AWS VPC Infrastructure with Terraform

Este repositório contém o primeiro módulo de um projeto de infraestrutura robusta na AWS, focado na criação de uma **Virtual Private Cloud (VPC)** utilizando **Terraform**.

O objetivo principal é aplicar **boas práticas de Infraestrutura como Código (IaC)**, garantindo **modularidade, escalabilidade** e **segurança na segregação de redes**.

---

## 🚀 Tecnologias Utilizadas

- **Terraform**: Orquestração e automação de infraestrutura.  
- **AWS**: Provedor de nuvem.  
- **S3**: Backend remoto para armazenamento do estado (`tfstate`) com segurança e colaboração.

---

## 🏗️ Arquitetura do Projeto

A VPC foi projetada com os seguintes componentes:

- **Subnets Públicas**: Configuradas com **Internet Gateway (IGW)** para tráfego externo.  
- **Subnets Privadas**: Isoladas, preparadas para camadas de banco de dados e aplicações internas.  
- **Tabelas de Rotas**: Segregação clara entre tráfego público e privado.  


---

## 🛠️ Diferenciais Técnicos Aplicados

- **Modularização**: Todo o código da rede foi isolado em um módulo reutilizável em `modules/vpc`.  
- **Uso de `for_each`**: Implementado para criação dinâmica de subnets, evitando problemas de indexação comuns ao usar `count`.  
- **Backend Remoto**: Configuração de estado no S3 para permitir colaboração entre equipes e evitar perda de dados localmente.  
- **Parametrização**: Uso extensivo de variáveis (`variables.tf`) e arquivo de valores (`terraform.tfvars`) para tornar o código flexível e reutilizável.  

---

## 📁 Estrutura de Arquivos

```plaintext
.
├── main.tf             # Chamada do módulo VPC
├── variables.tf        # Variáveis globais da raiz
├── terraform.tfvars    # Definição dos valores das variáveis
├── backend.tf          # Configuração do backend S3
├── provider.tf         # Configuração do provider AWS e tags padrão
└── modules/
    └── vpc/            # Módulo da VPC (recursos, variáveis e outputs)
