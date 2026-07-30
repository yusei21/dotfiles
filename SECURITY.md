# Segurança

Este repositório contém configurações pessoais e scripts que modificam o sistema. Revise os arquivos antes de executar qualquer instalador.

## Segredos

Não envie para o repositório:

- arquivos `.env`;
- chaves SSH ou certificados privados;
- tokens de API;
- senhas, cookies ou credenciais de serviços;
- arquivos `credentials.json`, `service-account*.json`, `*.pem` ou `*.key`.

Use variáveis de ambiente e mantenha os valores reais fora do Git.

## Instaladores

O script `scripts/install-visual-hyde.sh`:

- usa `sudo`;
- instala e remove pacotes;
- altera configurações do usuário;
- desativa alguns serviços;
- cria backup antes de modificar arquivos.

Leia o script completo antes de executá-lo.

## Relato de vulnerabilidade

Não abra uma issue pública contendo credenciais ou dados pessoais. Revogue imediatamente qualquer segredo exposto e depois remova-o do histórico Git.
