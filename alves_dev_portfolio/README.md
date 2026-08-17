# Alves Dev — Portfólio Flutter Web

Portfólio pessoal responsivo feito em Flutter, com:

- Hero animada
- Navbar glass fixa
- Terminal animado
- Seção Sobre mim
- Projetos com hover
- Timeline de trajetória
- Tecnologias
- Contato com links externos
- Animações ao rolar
- Layout responsivo para desktop e celular
- Configuração pronta para GitHub e Vercel

## 1. Requisitos locais

Tenha o Flutter instalado e atualizado.

```bash
flutter doctor
```

## 2. Rodar o projeto

Na raiz do projeto:

```bash
flutter pub get
flutter run -d chrome
```

Se estiver no Linux e preferir abrir como app desktop:

```bash
flutter run -d linux
```

## 3. Alterar seus links

Abra `lib/main.dart` e procure:

```dart
class AppLinks
```

Troque os links que ainda possuem `SEU_USUARIO` pelo seu usuário real do GitHub.

Também é ali que ficam Instagram, WhatsApp e links de cada projeto.

## 4. Adicionar screenshots aos projetos

Coloque as imagens em:

```text
assets/images/
```

Depois descomente no `pubspec.yaml`:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

No `ProjectCard`, informe por exemplo:

```dart
imageAsset: 'assets/images/jarvis.png',
```

Se nenhuma imagem for informada, o card usa o preview em gradiente automaticamente.

## 5. Testar a versão web de produção

```bash
flutter build web --release
```

O resultado ficará em:

```text
build/web/
```

Para testar localmente:

```bash
cd build/web
python3 -m http.server 8000
```

Abra `http://localhost:8000`.

## 6. Subir para o GitHub

Crie um repositório vazio no GitHub e, dentro desta pasta, execute:

```bash
git init
git add .
git commit -m "feat: portfolio flutter"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/portfolio-flutter.git
git push -u origin main
```

## 7. Publicar na Vercel pelo GitHub

Este repositório já inclui:

- `vercel.json`
- `scripts/vercel_build.sh`

O script baixa o Flutter stable no ambiente de build da Vercel, executa `flutter pub get` e depois `flutter build web --release`.

Na Vercel:

1. Clique em **Add New > Project**.
2. Importe seu repositório do GitHub.
3. Mantenha a raiz do projeto como `./`.
4. O `vercel.json` já define o Build Command e o Output Directory.
5. Clique em **Deploy**.

> O primeiro build pode demorar mais porque o Flutter SDK precisa ser baixado no ambiente de build.

## 8. Alternativa de deploy estático

Se preferir não instalar Flutter durante o build da Vercel, gere localmente:

```bash
flutter build web --release
```

E publique o conteúdo de `build/web` como site estático.

## Estrutura

```text
alves_dev_portfolio/
├── assets/
│   └── images/
├── lib/
│   └── main.dart
├── scripts/
│   └── vercel_build.sh
├── web/
│   ├── icons/
│   ├── favicon.png
│   ├── index.html
│   └── manifest.json
├── .gitignore
├── analysis_options.yaml
├── pubspec.yaml
├── README.md
└── vercel.json
```
