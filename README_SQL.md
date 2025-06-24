# 🗃️ Como Rodar a Sequência de Códigos SQL

---

## ✅ Pré-requisitos

- Ter instalado o PostgreSQL
- Acesso ao cliente SQL (pgAdmin)
- Scripts SQL salvos em arquivos `.sql` (ex: `1-CreatingTables.sql`, `2-InsertingData.sql`)

---

## 📁 Organização dos Arquivos

/trabalhoBD
│
├── 1-CreatingTables.sql
├── 2-InsertingData.sql
├── 3-Queries.sql
├── 4.1-carga_adicional.sql
├── 4.2-Index.sql
└── 5-CriacaoViews.sql

---

## 🔄 Executando os scripts

1. Abra o pgAdmin
2. Execute os arquivos `.sql` **na ordem correta**:
   - `1-CreatingTables.sql`
   - `2-InsertingData.sql`
   - `3-Queries.sql`
     - Obs.: Execute uma query por vez 
   - `4.1-carga_adicional.sql`
     - Obs.: Caso haja erro de chave duplicada executar novamente 
   - `4.2-Index.sql`
     - Obs.: Execute um comando por vez para analisar as diferenaças de desempenho
   - `5-CriacaoViews.sql`
    
3. Use `F5` ou o botão de *Run* para cada script.

---
