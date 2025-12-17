# The Anxiety Club - Clube da Mídia

## 📖 Visão Geral
App/Site para clubes de mídia (livros, jogos, filmes, séries) onde você acompanha o que você e seus amigos estão consumindo.

---

## 🎨 Design
- **Estilo**: Minimalista, preto e branco
- **Temas**: Modo escuro e claro
- **Princípios**: Interface simples e limpa

---

## 🔐 Autenticação
- **Login**: Email
- **Backend**: Firebase Authentication
- **Funcionalidades**:
  - Registro de usuário
  - Login/Logout
  - Recuperação de senha

---

## 📱 Telas/Páginas

### Home
- Lista de mídias que você e amigos estão participando
- Informações visíveis:
  - Data de início e fim
  - Barra de progresso (opcional)
- Ações:
  - Ir para perfil
  - Logout

### Perfil (Próprio)
- Foto de perfil
- Nome
- Posts
- Clubes que participa
- Mídias finalizadas
- Ações:
  - Editar perfil
  - Ver histórico

### Perfil (Amigo)
- Foto, nome, posts, clubes
- Ação: Desfazer amizade

### Perfil (Desconhecido)
- Foto, nome, posts, clubes
- Ação: Adicionar amigo

### Chat
- Conversas entre amigos
- Notificações de mensagens

### Configurações
- Tema (escuro/claro)
- Notificações
- Privacidade
- Sobre

---

## 🔒 Tipos de Visibilidade dos Clubes

### Público
- Qualquer usuário pode ver e entrar
- Aparece em buscas públicas

### Amigos
- Apenas amigos do criador podem ver e entrar
- Aparece em feed de amigos

### Privado
- Apenas pessoas convidadas podem ver e entrar
- Criador envia convites manualmente
- Não aparece em buscas ou feeds públicos

---

## 🗂️ Entidades/Modelos

### User (Usuário)
- id
- name
- email
- photoUrl
- friends (lista de IDs)
- clubs (lista de IDs)

### Club (Clube)
- id
- name
- mediaType (livro/jogo/filme/série)
- mediaId
- members (lista de IDs)
- startDate
- endDate
- progress (%)
- visibility (público/amigos/privado)
- createdBy (ID do criador)
- invitations (lista de IDs convidados - para clubes privados)

### Media (Mídia)
- id
- title
- type (livro/jogo/filme/série)
- coverUrl
- description

### Post
- id
- userId
- clubId
- content
- createdAt

### Conversation (Chat)
- id
- members (lista de IDs - sempre 2 usuários)
- lastMessage
- lastMessageAt
- createdAt

### Message (Chat)
- id
- conversationId
- senderId
- content
- createdAt
- read (boolean)

---

## 🏗️ Arquitetura

### Fluxo de Dados

**REST API (Clubes, Posts, Perfis)**
```
Flutter App → Firebase Auth (login/token)
     ↓
  Token JWT
     ↓
Backend Python (FastAPI) → valida token → acessa Firestore
     ↓
   Retorna dados (REST JSON)
```

**Chat em Tempo Real**
```
Flutter App → Firebase Auth
     ↓
Firestore (direto) → Listeners tempo real
     ↓
   Mensagens sincronizadas
```

### Responsabilidades

**Frontend (Flutter)**
- Autenticação com Firebase Auth
- UI/UX e navegação
- Enviar token JWT em todas as requisições REST
- Consumir API REST do backend
- **Chat**: Acesso direto ao Firestore com listeners tempo real

**Backend (Python + FastAPI)**
- Validar tokens Firebase
- CRUD no Firestore (clubes, posts, perfis, social)
- Regras de negócio
- Endpoints REST
- Validação de dados
- **Chat**: Apenas validação de amizade para criar conversa (opcional)

**Firebase**
- **Authentication**: Login/registro (frontend)
- **Firestore**: 
  - Backend: Clubes, posts, perfis, social
  - Frontend: Chat (conversations, messages) com Security Rules

---

## 🛠️ Stack Tecnológica

### Frontend
- **Framework**: Flutter (Web + Mobile)
- **Linguagem**: Dart
- **Packages**:
  - `firebase_auth` - autenticação
  - `cloud_firestore` - chat em tempo real
  - `dio` ou `http` - requisições HTTP
  - `provider` ou `riverpod` - state management
  - `go_router` - navegação
  - `freezed` - models imutáveis
  - `json_serializable` - serialização JSON
  - `flutter_secure_storage` - armazenar token

### Backend
- **Framework**: Python + FastAPI
- **Packages**:
  - `firebase-admin` - validar tokens e acessar Firestore
  - `pydantic` - validação de dados
  - `uvicorn` - servidor ASGI
- **Banco de Dados**: Firestore (gerenciado via Firebase Admin SDK)

### Infraestrutura
- **Auth**: Firebase Authentication
- **Database**: Cloud Firestore
- **Storage**: Firebase Storage (para fotos)
- **Hosting**: 
  - Frontend: Firebase Hosting (web) / App Stores (mobile)
  - Backend: Railway, Render, ou Google Cloud Run

---

## 📝 Notas
- **Arquitetura Híbrida**:
  - Backend gerencia: Clubes, posts, perfis, social (REST)
  - Frontend gerencia: Chat (Firestore direto com listeners)
- **Firestore Security Rules**: Proteger conversas (apenas members podem ler/escrever)
- **Token**: Frontend envia JWT em header `Authorization: Bearer <token>` (REST)
- **Chat**: Firestore listeners para tempo real, sem passar pelo backend
- **MVP**: Login + Home + Perfil básico
- **Plano Firebase Spark (Gratuito)**:
  - 50k leituras/dia, 20k escritas/dia
  - Suficiente para chat moderado (centenas de usuários)
- **Prioridade**: Core features primeiro, extras depois





    





