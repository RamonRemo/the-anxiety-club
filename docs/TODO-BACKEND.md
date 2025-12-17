# TODO - Backend (Python + FastAPI)

## 📋 Estrutura Base
- [ ] Configurar projeto FastAPI
  - [ ] Criar ambiente virtual (venv)
  - [ ] Estrutura de pastas (app/, models/, routes/, services/, etc)
- [ ] Setup Firebase Admin SDK
  - [ ] Configurar credenciais (service account JSON)
  - [ ] Inicializar Firebase Admin
- [ ] Implementar middleware de autenticação
  - [ ] Validar token JWT do Firebase
  - [ ] Extrair user_id do token
  - [ ] Dependency injection para user autenticado
- [ ] Criar models Pydantic (User, Club, Media, Post)
- [ ] Setup Firestore
  - [ ] Definir coleções (users, clubs, media, posts)
  - [ ] Criar índices necessários
- [ ] Definir regras de segurança Firestore
  - [ ] Rules para chat (conversations, messages)
  - [ ] Proteger acesso direto do frontend

---

## 👤 Endpoints - Usuários

### GET `/users/me`
- [ ] Retornar perfil do usuário logado
- [ ] Incluir friends, clubs

### GET `/users/{id}`
- [ ] Retornar perfil de outro usuário
- [ ] Verificar privacidade (público vs amigos)

### PUT `/users/me`
- [ ] Atualizar perfil (name, etc)
- [ ] Validar dados

### POST `/users/me/photo`
- [ ] Upload de foto para Firebase Storage
- [ ] Atualizar photoUrl no Firestore
- [ ] Retornar nova URL

---

## 🎮 Endpoints - Clubes

### GET `/clubs`
- [ ] Listar clubes
- [ ] Filtrar por visibilidade:
  - Público: todos
  - Amigos: apenas de amigos
  - Privado: apenas onde é membro
- [ ] Ordenar por data de criação
- [ ] Paginação (opcional)

### POST `/clubs`
- [ ] Criar clube
- [ ] Validar visibilidade (público/amigos/privado)
- [ ] Adicionar criador como membro
- [ ] Retornar clube criado

### GET `/clubs/{id}`
- [ ] Retornar detalhes do clube
- [ ] Verificar permissão de visualização
- [ ] Incluir membros, posts relacionados

### POST `/clubs/{id}/join`
- [ ] Entrar no clube
- [ ] Validar permissão:
  - Público: qualquer um
  - Amigos: verificar se é amigo do criador
  - Privado: verificar se está em invitations
- [ ] Adicionar usuário a members

### POST `/clubs/{id}/invite`
- [ ] Convidar usuário para clube privado
- [ ] Verificar se solicitante é criador/admin
- [ ] Adicionar user_id a invitations

### DELETE `/clubs/{id}/leave`
- [ ] Sair do clube
- [ ] Remover de members
- [ ] Não permitir se for criador (ou transferir ownership)

### PUT `/clubs/{id}/progress`
- [ ] Atualizar progresso (%)
- [ ] Validar range 0-100
- [ ] Apenas membros podem atualizar

---

## 👥 Endpoints - Social

### GET `/users/search?q=nome`
- [ ] Buscar usuários por nome
- [ ] Retornar lista de resultados (id, name, photoUrl)
- [ ] Limitar resultados (max 20)

### POST `/friends/{id}`
- [ ] Adicionar amigo
- [ ] Adicionar em ambos os lados (user.friends)
- [ ] Validar que não é self-add

### DELETE `/friends/{id}`
- [ ] Remover amigo
- [ ] Remover em ambos os lados

### GET `/friends`
- [ ] Listar amigos do usuário logado
- [ ] Retornar detalhes básicos (id, name, photoUrl)

---

## 📝 Endpoints - Posts

### GET `/posts`
- [ ] Feed de posts
- [ ] Ordenar por data (mais recente primeiro)
- [ ] Filtrar por amigos (opcional)
- [ ] Paginação (limit/offset)

### POST `/posts`
- [ ] Criar post
- [ ] Validar clubId (se fornecido)
- [ ] Validar que user é membro do clube

### POST `/posts/{id}/like`
- [ ] Curtir post
- [ ] Evitar duplicata (user já curtiu)

### POST `/posts/{id}/comment`
- [ ] Comentar em post
- [ ] Salvar comment (subcoleção ou array)

---

## 💬 Endpoints - Chat (Opcional)

### POST `/conversations`
- [ ] Criar conversa entre 2 usuários
- [ ] Validar que são amigos
- [ ] Verificar se conversa já existe
- [ ] Salvar no Firestore (conversations collection)
- [ ] Retornar conversation_id

---

## 🗄️ Firestore - Estrutura de Dados

### Coleção: `users`
```python
{
  "id": "user_id",
  "name": "string",
  "email": "string",
  "photoUrl": "string",
  "friends": ["user_id1", "user_id2"],
  "clubs": ["club_id1", "club_id2"],
  "createdAt": "timestamp"
}
```

### Coleção: `clubs`
```python
{
  "id": "club_id",
  "name": "string",
  "mediaType": "livro|jogo|filme|série",
  "mediaId": "string",
  "members": ["user_id1", "user_id2"],
  "startDate": "timestamp",
  "endDate": "timestamp",
  "progress": 0-100,
  "visibility": "público|amigos|privado",
  "createdBy": "user_id",
  "invitations": ["user_id3"],  # para clubes privados
  "createdAt": "timestamp"
}
```

### Coleção: `media`
```python
{
  "id": "media_id",
  "title": "string",
  "type": "livro|jogo|filme|série",
  "coverUrl": "string",
  "description": "string"
}
```

### Coleção: `posts`
```python
{
  "id": "post_id",
  "userId": "user_id",
  "clubId": "club_id",  # opcional
  "content": "string",
  "likes": ["user_id1", "user_id2"],
  "createdAt": "timestamp"
}
```

### Coleção: `conversations` (Gerenciada pelo Frontend)
```python
{
  "id": "conversation_id",
  "members": ["user_id1", "user_id2"],
  "lastMessage": "string",
  "lastMessageAt": "timestamp",
  "createdAt": "timestamp"
}
```

### Coleção: `messages` (Gerenciada pelo Frontend)
```python
{
  "id": "message_id",
  "conversationId": "conversation_id",
  "senderId": "user_id",
  "content": "string",
  "read": false,
  "createdAt": "timestamp"
}
```

---

## 🔒 Firestore Security Rules

### Chat Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Conversations: apenas members podem ler/escrever
    match /conversations/{conversationId} {
      allow read, write: if request.auth != null && 
        request.auth.uid in resource.data.members;
    }
    
    // Messages: apenas members da conversa podem ler/escrever
    match /messages/{messageId} {
      allow read, write: if request.auth != null && 
        request.auth.uid in get(/databases/$(database)/documents/conversations/$(resource.data.conversationId)).data.members;
    }
    
    // Outras coleções: apenas backend pode acessar
    match /{document=**} {
      allow read, write: if false;  // Bloqueia acesso direto
    }
  }
}
```

---

## 📦 Packages Necessários

```txt
fastapi==0.115.6
uvicorn[standard]==0.34.0
firebase-admin==6.6.0
pydantic==2.10.5
python-multipart==0.0.20  # para upload de arquivos
python-dotenv==1.0.1  # variáveis de ambiente
```

---

## 🛠️ Estrutura de Pastas Sugerida

```
backend/
├── app/
│   ├── __init__.py
│   ├── main.py                 # FastAPI app
│   ├── config.py               # Configurações
│   ├── dependencies.py         # Auth middleware
│   ├── models/
│   │   ├── __init__.py
│   │   ├── user.py
│   │   ├── club.py
│   │   ├── post.py
│   │   └── media.py
│   ├── routes/
│   │   ├── __init__.py
│   │   ├── users.py
│   │   ├── clubs.py
│   │   ├── posts.py
│   │   ├── friends.py
│   │   └── conversations.py
│   ├── services/
│   │   ├── __init__.py
│   │   ├── firestore.py        # Firestore helper
│   │   ├── storage.py          # Firebase Storage
│   │   └── auth.py             # Token validation
│   └── utils/
│       ├── __init__.py
│       └── helpers.py
├── tests/
├── .env
├── .gitignore
├── requirements.txt
└── README.md
```

---

## 🧪 Testes (Opcional)
- [ ] Testes unitários (services, validações)
- [ ] Testes de integração (endpoints)
- [ ] Mock do Firestore para testes
- [ ] Coverage report

---

## 🚀 Deploy
- [ ] Configurar variáveis de ambiente
- [ ] Dockerfile (opcional)
- [ ] Deploy no Railway
- [ ] Deploy no Render
- [ ] Deploy no Google Cloud Run
- [ ] Configurar domínio customizado (opcional)
- [ ] Setup CORS (permitir frontend)
- [ ] Rate limiting (opcional)
- [ ] Logs e monitoring

---

## 📝 Notas
- **Auth**: Sempre validar JWT em todos os endpoints protegidos
- **Firestore**: Usar batch writes para operações múltiplas
- **Storage**: Firebase Storage para fotos (upload direto ou via backend)
- **CORS**: Configurar origens permitidas (frontend URL)
- **Environment**: Usar .env para credenciais (nunca commitar)
- **Validation**: Pydantic para validação automática de dados
- **Error Handling**: Retornar status codes corretos (400, 401, 403, 404, 500)
