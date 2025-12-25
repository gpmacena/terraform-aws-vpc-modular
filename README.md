# 🌐 AWS Infrastructure with Terraform & GitHub Actions (v1.4)

Este repositório contém um projeto de infraestrutura escalável na AWS, utilizando **Terraform** e automação via **GitHub Actions**. O foco principal desta versão é a implementação de **CI/CD (Continuous Integration / Continuous Deployment)**, garantindo que a infraestrutura seja testada e aplicada automaticamente a cada mudança no código.



---

## 🚀 Tecnologias Utilizadas

* **Terraform**: Orquestração e automação de infraestrutura (IaC).
* **AWS**: Provedor de nuvem (VPC, EC2, NAT Gateway).
* **GitHub Actions**: Pipeline de automação para ciclo de vida completo (Plan, Apply, Destroy).
* **S3**: Backend remoto para persistência do `tfstate` com suporte a State Locking.

---

## 🏗️ Arquitetura do Projeto

A infraestrutura é organizada em camadas modulares para máxima reusabilidade:

### 📡 Network Layer (VPC & Connectivity)
* **Segregação de Subnets**: Divisão entre redes públicas e privadas para isolamento de recursos.
* **NAT Gateway**: Implementado para permitir que recursos em redes privadas realizem atualizações de segurança sem exposição direta à internet.
* **Tabelas de Rotas**: Roteamento inteligente para tráfego interno e externo.

### 🛡️ Security Layer (Firewall)
* **Security Groups**: Regras de firewall *stateful* permitindo acesso via **SSH (22)** e **HTTP (80)**.
* **Controle de Egresso**: Saída liberada para patches de segurança e updates.

### 💻 Compute Layer (Web Server)
* **EC2 Instance**: Provisionamento de servidor Ubuntu 22.04 LTS.
* **Bootstrap (User Data)**: Automação via script shell para instalação e inicialização do servidor **Nginx**.

---

## 🤖 Pipeline CI/CD (O Diferencial da v1.4)

O grande salto desta versão é a automação total do ciclo de vida através do GitHub Actions:

1.  **Validação Automática**: Todo código é verificado sintaticamente (`terraform validate`).
2.  **Plano de Execução**: O GitHub gera um `terraform plan` em todo Pull Request, permitindo revisar custos e mudanças antes do deploy.
3.  **Continuous Deployment**: Ao realizar o push na branch `main`, o `terraform apply` é executado automaticamente.
4.  **Destroy sob Aprovação**: Um gatilho de destruição manual foi configurado, exigindo aprovação via *GitHub Environments* para evitar a remoção acidental da infraestrutura.



---

## 🛠️ Diferenciais Técnicos

* **GitOps**: A infraestrutura é tratada como software, com versionamento e esteira de deploy.
* **Segurança de Credenciais**: Uso de *GitHub Secrets* para proteger chaves de acesso da AWS.
* **Modularização Profissional**: Divisão clara entre Rede, Segurança e Computação.
* **Backend Remoto**: Uso de S3 para colaboração e integridade do estado da infraestrutura.

---

## 📁 Estrutura de Arquivos

```plaintext
.
├── .github/workflows/  # Pipeline de automação (CI/CD)
├── main.tf             # Orquestrador da infraestrutura
├── backend.tf          # Configuração do estado remoto no S3
├── provider.tf         # Provedor AWS e Tags padronizadas
└── modules/
    ├── vpc/            # Rede (VPC, Subnets, IGW, NAT)
    ├── security/       # Segurança (Security Groups)
    └── ec2/            # Computação (Instâncias e Scripts)