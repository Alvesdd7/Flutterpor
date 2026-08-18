# Portfólio — João Pedro Alves Santos

Portfólio pessoal em **Flutter Web**, sem seção de projetos.

## O que este projeto inclui

- Página inicial responsiva
- Seção "Sobre mim"
- Habilidades e tecnologias
- Seção transparente explicando que o portfólio foi desenvolvido juntamente com IA
- Botão para iniciar conversa no WhatsApp: **+55 17 99165-6885**
- Animações feitas com recursos nativos do Flutter
- Configuração pronta para deploy na Vercel

## Rodar localmente

```bash
flutter pub get
flutter run -d chrome
```

## Gerar build web

```bash
flutter build web --release
```

## Deploy na Vercel

O projeto já inclui `vercel.json` e `vercel_build.sh`.

Ao importar o repositório na Vercel:
- Framework Preset: Other
- Root Directory: deixe vazio
- Build Command: pode deixar a configuração do `vercel.json`
- Output Directory: `build/web`

## Observação sobre IA

Este portfólio foi desenvolvido juntamente com inteligência artificial, usada como ferramenta de apoio em planejamento, código, design, revisão e aprendizado.
