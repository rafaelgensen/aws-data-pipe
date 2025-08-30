# Glue Job - Feature Store para Inferência de Crédito

Este repositório contém a infraestrutura e o script PySpark para geração de uma Feature Store no S3 utilizando AWS Glue com Spark puro (sem GlueContext). Todo o processo está modularizado e com deploy automatizado via GitHub Actions.

## 📁 Estrutura do Projeto 

```
├── infra/                          # Infraestrutura como código (Terraform)
│   ├── main.tf                     # Recursos AWS (Glue Job, IAM, etc.)
│   ├── policy/
│   │   ├── assume_role.json        # Política de trust da role do Glue
│   │   └── glue_access_policy.json# Política de acesso ao S3
│
├── src/
│   └── featurestore/
│       ├── main.py                # Ponto de entrada do Glue Job
│       ├── feature_store.py       # Classe de orquestração do fluxo ETL
│       └── utils.py               # SparkSession + FeatureEngineering modularizado
│
├── .github/workflows/
│   └── deploy.yml                 # Pipeline de CI/CD com GitHub Actions
```

## 🚀 Deploy

O deploy é realizado automaticamente via **GitHub Actions** ao fazer `push` na branch `main`. Ele realiza:

1. Compressão dos scripts (`main.py`, `utils.py`, `feature_store.py`)
2. Upload do `.zip` no S3 (em um bucket versionado/artifactory)
3. Execução do `terraform apply` na pasta `infra/` para criar/atualizar o Glue Job

---

## 📦 Execução do Glue Job

O job pode ser executado de duas formas:

### 🔁 Via Step Functions ou outro orquestrador

Você pode passar os parâmetros `--input_path` e `--output_path` diretamente para o Glue Job via trigger ou orquestrador:

```json
--input_path=s3://meu-bucket-transient/meus-dados/
--output_path=s3://meu-bucket-sot/feature-store/
```

### 🖥️ Manualmente pelo Console AWS Glue

1. Vá até o [AWS Glue Console](https://console.aws.amazon.com/glue/).
2. Clique no Job `glue-featurestore-job`.
3. Clique em **"Run Job"**.
4. Em *Script parameters (optional)*, adicione:

```
--input_path=s3://meu-bucket-transient/meus-dados/
--output_path=s3://meu-bucket-sot/feature-store/
```

---

## ✅ Pré-requisitos Locais

Antes de rodar o pipeline:

- Ter [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) configurado (`aws configure`)
- Ter [Terraform](https://developer.hashicorp.com/terraform/downloads) instalado
- Ter as variáveis de ambiente do GitHub configuradas:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`

---

## 🧠 O que este job faz?

- Lê arquivos `.csv` da camada **transient**
- Realiza diversas transformações e categorização de dados
- Aplica *one-hot encoding* customizado
- Salva os dados tratados em `.parquet` na camada **SOT** (feature-store), particionando por data (`anomesdia`)

---

## 📌 Observações

- O script é compatível com Spark puro, sem uso de `GlueContext`
- As transformações estão modularizadas para facilitar manutenção e reuso
- Suporte completo para execução via esteira ou console manual
