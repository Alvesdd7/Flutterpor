# Alves Dev — Portfólio sem seção de projetos

Versão corrigida do portfólio de João Pedro Alves Santos, mantendo o visual anterior com:

- `<Alves Dev />`
- terminal animado
- comandos `flutter run`, `whoami` e `focus`
- fundo escuro com gradientes azul/roxo
- cards com efeito glass
- seção Sobre
- Trajetória
- Skills
- seção transparente explicando o uso de IA
- contato pelo WhatsApp `+55 17 99165-6885`
- GitHub e Instagram
- responsividade para celular

## O que foi removido

A seção **Projetos** foi removida completamente, inclusive da navegação.

## WhatsApp

Todos os botões de contato abrem:

`https://wa.me/5517991656885`

com uma mensagem inicial pronta.

## IA

O site deixa claro que este portfólio foi desenvolvido **juntamente com inteligência artificial**, usada como ferramenta de apoio para planejamento, código, design, revisão e aprendizado.

## Vercel — importante

Esta versão é estática e NÃO usa `vercel_build.sh`.

Isso evita o erro:

`Command "bash vercel_build.sh" exited with 1`

Suba os arquivos do ZIP diretamente na raiz do seu repositório:

- `index.html`
- `style.css`
- `script.js`
- `vercel.json`
- `README.md`

Na Vercel:

- Framework Preset: **Other**
- Root Directory: **vazio**
- Build Command: **não sobrescrever / vazio**
- Output Directory: **não sobrescrever / vazio**

Depois faça um novo deploy.
