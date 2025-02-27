# M3-API-Biblioteca-Versao-Exame

## Sistema de Gestão de Biblioteca

### Visão Geral

Este projeto é um sistema de gestão de biblioteca que consiste em:
- API RESTful com LoopBack 4
- Interface administrativa com React-Admin
- Banco de dados MySQL 8
- Configuração Docker para todos os componentes

### Estrutura do Repositório

```
M3-API-Biblioteca-Versao-Exame/
├── biblioteca-api-backend/      # API LoopBack 4
│   ├── src/
│   │   ├── controllers/        # Controladores para cada entidade
│   │   ├── models/            # Definição dos modelos
│   │   ├── repositories/      # Repositórios para acesso aos dados
│   │   └── datasources/       # Configuração da conexão com banco
│   └── Dockerfile
│
├── biblioteca-admin-frontend/   # Frontend React-Admin
│   ├── src/
│   │   ├── components/        # Componentes das entidades
│   │   └── App.js            # Configuração do React-Admin
│   └── Dockerfile
│
└── docker-compose.yml          # Orquestração dos containers
```

### Funcionalidades

O sistema oferece gerenciamento completo de:

**Livros**
- Cadastro, edição, listagem e remoção
- Associação com categorias
- Controle de disponibilidade

**Utilizadores**
- Gestão de usuários da biblioteca
- Perfis de acesso
- Histórico de empréstimos

**Empréstimos**
- Controle de empréstimos de livros
- Datas de empréstimo e devolução
- Validações automáticas

**Categorias**
- Organização dos livros
- Gestão flexível
- Relações com livros

**Dashboard**
- Estatísticas gerais
- Visão geral do sistema
- Indicadores importantes

### Como Iniciar o Projeto

1. Clone o repositório
```bash
git clone https://github.com/inf24dw1g05/M3-API-Biblioteca-Versao-Exame.git
cd M3-API-Biblioteca-Versao-Exame
```

2. Inicie os containers com Docker Compose
```bash
docker-compose up --build
```

3. Acesse as aplicações
- Interface Administrativa: http://localhost:3001
- API Swagger: http://localhost:3000/explorer
- URL Base da API: http://localhost:3000

### Componentes do Sistema

#### API (Porta 3000)
- Framework: LoopBack 4
- Endpoints RESTful para todas as entidades
- Documentação Swagger integrada
- Validações de negócio

#### Frontend Admin (Porta 3001)
- Framework: React-Admin
- Interface intuitiva para gestão
- Suporte a operações CRUD
- Dashboard informativo

#### Banco de Dados
- MySQL 8
- Porta externa: 3307
- Porta interna: 3306

### Comandos Docker Úteis

```bash
# Iniciar os containers
docker-compose up

# Iniciar em background
docker-compose up -d

# Reconstruir e iniciar
docker-compose up --build

# Parar os containers
docker-compose down

# Ver logs
docker-compose logs -f

# Ver logs de um serviço específico
docker-compose logs -f api
```

### Solução de Problemas Comuns

**Erro ao iniciar os containers**
- Verifique se as portas 3000, 3001 e 3307 estão livres
- Certifique-se que o Docker está rodando
- Use `docker-compose down` e tente novamente

**Frontend não carrega**
- Verifique se todos os containers estão rodando
- Confirme se a API está acessível
- Verifique os logs do container do frontend

**API não conecta ao banco**
- Aguarde o banco inicializar completamente
- Verifique os logs do container do banco
- Confirme se o container do banco está rodando

### Desenvolvimento

Para desenvolver localmente:

**API (biblioteca-api-backend)**
```bash
cd biblioteca-api-backend
npm install
npm start
```

**Frontend (biblioteca-admin-frontend)**
```bash
cd biblioteca-admin-frontend
npm install
npm start
```

### Estrutura do Banco de Dados

O sistema utiliza as seguintes tabelas:
- `livros`: Armazena o catálogo de livros
- `utilizadores`: Registro dos usuários
- `emprestimos`: Controle de empréstimos
- `categorias`: Categorias dos livros

### Imagens Docker

Este projeto usa as seguintes imagens Docker:
- `a045580/biblioteca-api:versaofinal`
- `a045580/biblioteca-frontend:versaofinal`
- `a045580/db-m3-biblioteca:versaofinal`

### Próximos Passos Sugeridos

- Implementar sistema de autenticação
- Adicionar testes automatizados
- Implementar sistema de reservas
- Adicionar relatórios exportáveis
- Melhorar validações de negócio

### Participantes

**Desenvolvedores**
- Rodrigo Pereira (A045580)
- Miguel Caetano (A045911)

---

Desenvolvido como parte do curso de Desenvolvimento Web  
ISMAI - Instituto Universitário da Maia  
2023/2024