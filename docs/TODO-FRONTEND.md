# TODO - Frontend (Flutter)

## 📋 Estrutura Base
- [x] Criar projeto Flutter
- [x] Configurar tema escuro
- [x] Criar estrutura de pastas
- [x] Implementar navegação (sidebar/drawer)
- [ ] Adicionar Firebase Auth SDK
- [ ] Adicionar Cloud Firestore SDK (para chat)
- [ ] Configurar HTTP client (dio ou http)
- [ ] Criar serviço de API (ApiService)
- [ ] Implementar interceptor para adicionar token JWT
- [ ] Setup state management (provider/riverpod)
- [ ] Configurar variáveis de ambiente (backend URL)
- [ ] Configurar Firestore Security Rules (chat)

---

## 🔐 Autenticação
- [ ] Criar tela de Login
- [ ] Criar tela de Registro
- [ ] Integrar Firebase Auth (email/senha)
- [ ] Obter token JWT após login
- [ ] Persistir token localmente (flutter_secure_storage)
- [ ] Implementar logout (limpar token)
- [ ] Auto-login (verificar token salvo)
- [ ] Tela de recuperação de senha

---

## 🏠 Home
- [ ] Criar feed de clubes (GET `/clubs`)
- [ ] Mostrar progresso de mídias
- [ ] Filtrar por amigos
- [ ] Pull-to-refresh
- [ ] Loading states
- [ ] Empty states (sem clubes)
- [ ] Error handling

---

## 👤 Perfil
- [ ] Tela de perfil próprio (GET `/users/me`)
- [ ] Tela de perfil de outros (GET `/users/{id}`)
- [ ] Edição de perfil (PUT `/users/me`)
- [ ] Upload de foto (POST `/users/me/photo`)
- [ ] Lista de clubes participados
- [ ] Histórico de mídias finalizadas
- [ ] Mostrar contagem de amigos

---

## 🎮 Clubes
- [ ] Tela de criação de clube (POST `/clubs`)
  - [ ] Escolher visibilidade (público/amigos/privado)
  - [ ] Selecionar mídia
  - [ ] Definir datas (opcional)
- [ ] Entrar em clube (POST `/clubs/{id}/join`)
  - [ ] Verificar permissão (público, amigo, ou convidado)
- [ ] Convidar para clube privado (POST `/clubs/{id}/invite`)
- [ ] Sair de clube (DELETE `/clubs/{id}/leave`)
- [ ] Ver detalhes do clube (GET `/clubs/{id}`)
  - [ ] Mostrar membros
  - [ ] Mostrar posts do clube
- [ ] Atualizar progresso (PUT `/clubs/{id}/progress`)
  - [ ] Barra de progresso visual
- [ ] Filtrar clubes por tipo de mídia

---

## 👥 Social
- [ ] Buscar usuários (GET `/users/search`)
  - [ ] Campo de busca
  - [ ] Lista de resultados
- [ ] Adicionar amigo (POST `/friends/{id}`)
  - [ ] Confirmação visual
- [ ] Remover amigo (DELETE `/friends/{id}`)
  - [ ] Dialog de confirmação
- [ ] Listar amigos (GET `/friends`)
- [ ] Feed de posts (GET `/posts`)
  - [ ] Infinite scroll
- [ ] Criar post (POST `/posts`)
  - [ ] Editor de texto
  - [ ] Selecionar clube relacionado
- [ ] Curtir/comentar (POST `/posts/{id}/like`)
  - [ ] Mostrar contagem de likes
  - [ ] Lista de comentários

---

## 💬 Chat (Firestore Direto)
- [ ] Criar modelo Conversation (Freezed)
- [ ] Criar modelo Message (Freezed)
- [ ] Criar conversa no Firestore
  - [ ] Validar amizade (local ou via backend)
- [ ] Lista de conversas
  - [ ] Firestore listener (tempo real)
  - [ ] Mostrar última mensagem
  - [ ] Ordenar por data
  - [ ] Badge de não lidas
- [ ] Tela de chat
  - [ ] Firestore listener para mensagens
  - [ ] Input de mensagem
  - [ ] Scroll automático para nova mensagem
- [ ] Enviar mensagem (Firestore write)
  - [ ] Atualizar lastMessage da conversa
- [ ] Marcar mensagem como lida
- [ ] Paginação de mensagens (últimas 20)
  - [ ] Load more ao scrollar pra cima
- [ ] Notificações de mensagem (Firebase Cloud Messaging)
  - [ ] Configurar FCM
  - [ ] Salvar device token

---

## ⚙️ Configurações
- [ ] Tela de configurações
- [ ] Toggle tema (escuro/claro)
- [ ] Configurações de notificações
- [ ] Configurações de privacidade
- [ ] Sobre / versão do app
- [ ] Logout

---

## 🎨 UI/UX
- [ ] Loading skeletons
- [ ] Animações de transição
- [ ] Feedback visual (snackbars, toasts)
- [ ] Error states
- [ ] Empty states
- [ ] Pull-to-refresh em listas
- [ ] Infinite scroll
- [ ] Imagens com placeholder/cache

---

## 📦 Packages Necessários
```yaml
dependencies:
  firebase_auth: ^5.3.3
  cloud_firestore: ^5.5.0
  dio: ^5.7.0  # ou http
  provider: ^6.1.2  # ou riverpod
  go_router: ^14.6.2
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  flutter_secure_storage: ^9.2.2
  firebase_messaging: ^15.1.5  # FCM
  cached_network_image: ^3.4.1
  image_picker: ^1.1.2

dev_dependencies:
  freezed: ^2.5.7
  json_serializable: ^6.8.0
  build_runner: ^2.4.13
```

---

## 🧪 Testes (Opcional)
- [ ] Testes unitários (models, services)
- [ ] Testes de widgets
- [ ] Testes de integração
- [ ] Mock do Firestore para testes

---

## 🚀 Deploy
- [ ] Build para Android (APK/AAB)
- [ ] Build para iOS (IPA)
- [ ] Build para Web
- [ ] Deploy web (Firebase Hosting)
- [ ] Publicar na Play Store
- [ ] Publicar na App Store

---

## 📝 Notas
- **State Management**: Decidir entre Provider ou Riverpod
- **Navegação**: go_router para deep linking
- **Firestore Chat**: Implementar listeners corretamente para evitar vazamento de memória
- **Security Rules**: Testar regras localmente antes de deploy
- **Token JWT**: Sempre incluir no header `Authorization: Bearer <token>` para REST
- **Offline**: Firestore já tem cache offline, mas considerar estado offline para REST API
