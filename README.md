# Relatório Técnico: Sistema de Gestão de Biblioteca

## 1. Introdução

Este relatório apresenta o desenvolvimento de um sistema de gestão de biblioteca utilizando uma arquitetura moderna e distribuída. O sistema foi implementado seguindo os requisitos especificados, utilizando a framework Loopback 4 para o backend e React-Admin para o frontend, proporcionando uma solução robusta e escalável para a gestão de recursos bibliográficos.

## 2. Arquitetura do Sistema

### 2.1 Visão Geral

O sistema foi desenvolvido utilizando uma arquitetura cliente-servidor, com duas componentes principais:

- Backend: API REST desenvolvida com Loopback 4
- Frontend: Aplicação web administrativa desenvolvida com React-Admin

### 2.2 Tecnologias Utilizadas

- **Backend:**
  - Node.js 18
  - Loopback 4
  - TypeScript
  - JSON Server (para persistência de dados em desenvolvimento)

- **Frontend:**
  - React 19.0.0
  - React-Admin 5.4.3
  - Material-UI
  - React-Admin-LB4 (para integração com Loopback 4)

## 3. Implementação do Backend (API REST)

### 3.1 Recursos Implementados

O sistema disponibiliza quatro recursos principais através da API REST:

1. **Livros (books)**
   - Gestão completa do catálogo de livros
   - Campos: título, autor, ano de publicação, categoria
   - Relacionamento com categorias (N:1)

2. **Utilizadores (users)**
   - Gestão de utilizadores do sistema
   - Campos: nome, email, tipo de utilizador
   - Relacionamento com empréstimos (1:N)

3. **Empréstimos (loans)**
   - Controle de empréstimos de livros
   - Campos: data de empréstimo, data de devolução
   - Relacionamentos com livros e utilizadores

4. **Categorias (categories)**
   - Classificação de livros
   - Campo: nome
   - Relacionamento com livros (1:N)

### 3.2 Endpoints REST

Todos os recursos implementam as operações CRUD completas:

- GET /{recurso} - Listar todos
- GET /{recurso}/{id} - Obter um específico
- POST /{recurso} - Criar novo
- PUT /{recurso}/{id} - Atualizar
- DELETE /{recurso}/{id} - Remover

### 3.3 Relacionamentos

Foram implementados os seguintes relacionamentos:

- Categoria 1:N Livros
- Utilizador 1:N Empréstimos
- Livro 1:N Empréstimos

## 4. Implementação do Frontend

### 4.1 Interface Administrativa

A interface administrativa foi desenvolvida utilizando React-Admin, oferecendo:

- Dashboard com estatísticas gerais
- CRUD completo para todos os recursos
- Navegação intuitiva entre recursos relacionados
- Validação de formulários
- Interface responsiva

### 4.2 Componentes Principais

- **Dashboard:**
  - Visão geral do sistema
  - Contadores de livros, utilizadores, empréstimos e categorias
  - Layout em grid responsivo

- **Gestão de Recursos:**
  - Listagens com paginação
  - Formulários de criação e edição
  - Validação de campos obrigatórios
  - Seleção de relacionamentos via dropdowns

## 5. Containerização

### 5.1 Estrutura Docker

O sistema foi containerizado utilizando Docker, com:

- Dockerfile específico para backend
- Dockerfile específico para frontend
- Docker Compose para orquestração

### 5.2 Configuração do Docker Compose

```yaml
version: '3.8'
services:
  api:
    image: biblioteca-api
    ports:
      - "3000:3000"
  admin:
    image: biblioteca-frontend
    ports:
      - "3001:3001"
    depends_on:
      - api
```

## 6. Validações e Requisitos Atendidos

### 6.1 Requisitos Técnicos

✓ Utilização de Loopback 4 para API REST
✓ Implementação de pelo menos 4 verbos HTTP
✓ Disponibilização de 4 recursos diferentes
✓ Relacionamentos 1:n entre recursos
✓ Representação JSON dos recursos
✓ Documentação OpenAPI 3.0
✓ Collection Postman disponível
✓ Interface administrativa React-Admin

### 6.2 Requisitos Adicionais

✓ Filtros via parâmetros HTTP
✓ Validação HTML5/CSS
✓ Filtros nas listagens
✓ Containerização multi-container

## 7. Conclusão

O sistema desenvolvido atende completamente aos requisitos especificados, oferecendo uma solução moderna e funcional para gestão de biblioteca. A arquitetura escolhida proporciona boa manutenibilidade e escalabilidade, enquanto as tecnologias utilizadas garantem uma experiência de usuário fluida e profissional.

A implementação demonstra boas práticas de desenvolvimento, incluindo:
- Separação clara de responsabilidades
- Uso adequado de padrões REST
- Interface de usuário intuitiva
- Containerização para facilitar deployment

O sistema está pronto para uso em ambiente de produção, com possibilidade de expansão futura para incluir funcionalidades adicionais conforme necessário.

## Participantes
 - Rodrigo Pererira A045580
 - Miguel Caetano - A045911