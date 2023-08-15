<p align="center">
<img src="https://github.com/rafael-figueiredo-alves/eFirebase/blob/main/Imagens/Logo_eFirebase.png" width=75% height=75%>  
</p>

<p>
  <a href="#compatibility"><img src="https://img.shields.io/static/v1?label=Delphi&message=Vers%C3%A3o%20xe2%2B&color=silver&style=for-the-badge&logo=delphi&logoColor=white" alt="Delphi XE2+ support" /></a>
  <a href="#compatibility"><img src="https://img.shields.io/static/v1?label=Lazarus&message=Vers%C3%A3o%202.2.6%20(Testada)&color=silver&style=for-the-badge&logo=lazarus&logoColor=white" alt="Lazarus support" /></a>  
  <a href="#compatibility"><img src="https://img.shields.io/static/v1?label=platforms&message=cross-platform&color=silver&style=for-the-badge&logo=delphi&logoColor=white" alt="Cross-platform support" /></a>
  <a href="#compatibility"><img src="https://img.shields.io/static/v1?label=applications&message=console%2C%20fmx%2C%20vcl&color=silver&style=for-the-badge&logo=delphi&logoColor=white" alt="Console, FMX, VCL support" /></a>
</p>

#

## Sobre

eFirebase é uma biblioteca simples construída em Delphi para servir como um SDK para o consumo do [Firebase](https://console.firebase.google.com/) tanto pelo Delphi (a partir da versão XE2 até 11.3) como pelo Lazarus (testei apenas no 2.2.6, mas desde que tenha a biblioteca Indy, creio que deva rodar em outras inferiores, mas superiores a 2.0). Seu maior objetivo é ser simples, prático e oferecer o que outras bibliotecas já oferecem e um pouco a mais de forma muito simplificada.

## Recursos

- Funções relacionadas ao controle de contas de usuário usando o Firebase Auth:
   - Poderá logar;
   - Poderá criar conta;
   - Poderá enviar e-mail de recuperação de senha;
   - Poderá acessar informações da conta;
   - Poderá apagar a conta;
   - Poderá verificar código de verificação de e-mail;
   - Poderá confirmar resetamento de senha com código enviado;
   - Poderá confirmar código de verificação de e-mail;
   - Poderá trocar senha;
   - Poderá alterar informações de conta.

- Funções relacionadas ao controle de arquivos usando o Firebase Storage:
    - Poderá enviar arquivos;
    - Poderá obter links para acessar documentos/arquivos enviados.

- Funções relacionadas ao banco de dados NoSQL do Firebase (Realtime Database):
    - Criação de coleções;
    - Leitura de dados de uma coleção;
    - Filtragem dos dados;
    - CRUD completo.

- A biblioteca oferece suporte as funcionalidades usando chamadas a API Rest do Firebase usando as units nativas do Delphi e/ou Lazarus (NetHTTP e Indy), usando como base o projeto [RestRequest4Delphi](https://github.com/viniciussanchez/RESTRequest4Delphi)

- Mais recursos serão implementados no futuro (e com ajuda de quem quiser colaborar com este projeto)

## Documentação e Demos

Estou disponibilizando um Demo que demonstra a maioria (na verdade praticamente todos) dos recursos implementados. Em breve vou atualizar este Readme com mais informações de como usar esta biblioteca. 

## Instalação

Basta baixar os arquivos e adicionar ao seu projeto ou se desejar utilize o [Boss](https://github.com/HashLoad/boss) para adicionar ao seu projeto.

# Versão

**[eFirebase versão 1.1.0](/../../releases/latest)**
