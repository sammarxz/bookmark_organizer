# Bookmark Organizer

Uma aplicação Elixir para importar e organizar favoritos exportados do navegador.

## Visão Geral

Esta aplicação permite que usuários importem seus favoritos exportados do navegador (em formato HTML) e os organize de forma mais eficiente.

## Progresso do Desenvolvimento

- ✅ Configuração inicial do projeto
- ✅ Setup do sistema de autenticação
- ⏳ Parser de bookmarks HTML (Em progresso)
- 📝 Interface web (Pendente)
- 📝 Organização de bookmarks (Pendente)
- 📝 Testes e documentação (Pendente)

## Etapas de Desenvolvimento

### 1. Configuração Inicial ✅
- [x] Criar novo projeto Phoenix
  - `mix phx.new bookmark_organizer --no-mailer`
- [x] Configurar dependências necessárias
  - Floki para parsing HTML
  - Ecto para persistência de dados (já incluído no Phoenix)
  - Guardian para autenticação JWT
  - Bcrypt para hash de senhas
  - Swoosh para funcionalidades de email

### 2. Modelagem de Dados
- [x] Definir schema de Usuários
  - Email (único)
  - Senha (hash)
  - Timestamps
- [ ] Definir schemas para:
  - Bookmarks (favoritos)
    - título
    - URL
    - descrição (opcional)
    - data de criação
    - tags/categorias
  - Categorias/Tags
    - nome
    - descrição
    - cor (opcional)

### 3. Parser do Arquivo HTML
- [ ] Desenvolver módulo para:
  - Ler arquivo HTML exportado
  - Extrair informações dos favoritos usando Floki
  - Validar estrutura do arquivo
  - Mapear dados para nossa estrutura interna

### 4. Backend
- [ ] Implementar controllers e contextos para:
  - Upload do arquivo HTML
  - CRUD de bookmarks
  - CRUD de categorias
  - Organização e categorização
  - Busca e filtros

### 5. Frontend
- [ ] Desenvolver interfaces para:
  - Upload do arquivo
  - Listagem de favoritos
  - Edição em lote
  - Categorização drag-and-drop
  - Busca e filtros
  - Visualização por categorias

### 6. Funcionalidades Adicionais
- [ ] Implementar recursos extras:
  - Verificação de links quebrados
  - Extração de thumbnails/favicons
  - Exportação dos favoritos organizados
  - Backup automático
  - Sincronização (opcional)

### 7. Testes
- [ ] Desenvolver testes para:
  - Parser HTML
  - Controllers
  - Contextos
  - Modelos
  - Integração

### 8. Documentação
- [ ] Criar documentação:
  - Guia de instalação
  - Manual do usuário
  - Documentação da API
  - Exemplos de uso

### 9. Deploy
- [ ] Preparar para produção:
  - Configuração de ambiente
  - Scripts de release
  - Monitoramento
  - Backup

## Stack Tecnológica

- Elixir/Phoenix para o framework web
- PostgreSQL para banco de dados
- Floki para parsing HTML
- LiveView para interatividade em tempo real
- TailwindCSS para estilização
- Alpine.js para interações JavaScript leves

## Como Contribuir

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/amazing-feature`)
3. Commit suas mudanças (`git commit -m 'Add some amazing feature'`)
4. Push para a branch (`git push origin feature/amazing-feature`)
5. Abra um Pull Request

## Licença

Este projeto está licenciado sob a MIT License - veja o arquivo LICENSE.md para detalhes.
