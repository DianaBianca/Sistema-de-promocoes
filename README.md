## README
# Sistema de Promoções

O **Sistema de Promoções**, é um sistema que trabalha com criação de **promoções** e geração de **cupons** de desconto.
Também é fornecido uma API de cupons(Application Programming Interface) para que seja possível utilizá-los em outras aplicações

# Configurando seu ambiente :

Para executar esse projeto você deve ter um computador, preferencialmente com **Linux**, com a linguagem de programação **Ruby** na **versão 2.7.2** e framework **rails** na **versão 7.0.2.3**

Primeiramente instale o **Ruby 2.7.2** (você pode usar o RVM ou asdf):

* [RVM](https://rvm.io/)
* [asdf](https://github.com/asdf-vm/asdf)

Após isso, intale o Rails com o seguinte comando em seu **terminal**:
 ```
gem install rails --version 7.0.2.3
 ```

## Como executar o projeto :

Dentro do diretório do projeto, você deve instalar as dependências definidas no arquivo *Gemfile* com o seguinte comando em seu **terminal**:

 ```
 bundle install
```

Execute as **migrations** executando o seguinte comando em seu **terminal**:

 ```
 rails db:migrate
 ```

Popule seu **banco de dados** com o seguinte comando em seu **terminal**:

```
rails db:seed
```

Com **todas** dependências instaladas, execute o seguinte comando em seu **terminal**:

 ```
 rails server
 ```
E em seu navegador, acesse :
 ```
  localhost:3000
 ```


# Sobre a API

Este projeto possui uma **documentação para cada rota fornecida pela API** e você poderá encontrá-la no seguinte diretório:
  ```
  app/docs/v1
  ```
Nessa documentação você irá encontrar:
 * O que a rota faz
 * Quais os parametros necessários na rota
 * Tabela com nome e descrição do parâmetro
 * O endpoint da rota
 * Um exemplo de como acessar a rota pelo navegador(com o servidor rodando)
 * Um exemplo da resposta que você terá quando enviar os parametros corretos para a rota da API
 * Um exemplo da resposta que você terá quando enviar um parâmetro incorreto para a API

# Sobre o Projeto
## Para logar no sistema :
```
login: admin@luizalabs.com.br
senha: 123456
```
## Para realizar o cadastro de um novo usuário :
```
seu dominio deve ser: @luizalabs.com.br
```
## Para encontrar a promoção que um cupom está relacionado:
```
digitar o código + " - " + "valor de 4 digitos(ex:0001")
```


# GEMS NECESSÁRIAS :
Para realizar a autenticação do usuário:
* gem 'devise'

Para testar aplicações web:
* gem 'capybara'

tradução pelos arquivos de configuração (yml):
* gem 'i18n'

Para a estilização do Front-End:
* gem 'bootstrap', '~> 5.1.3'

Para verificar e analisar erros de sintaxe, boas práticas da comunidade e linguagem :
* gem 'rubocop'
* gem 'rubocop-rails'


# ATUALIZAÇOES FUTURAS
* Resolver os testes pendentes
* Adicionar Docker
* Melhorar a refatoração
* Passar restante dos textos hard coded para I18n
* Realizar o restante dos testes unitários e testes funcionais com Selenium IDE
* Desenvolver uma Aplicação que consome a API de cupons fornecida neste projeto
* Resolver os bugs com alerts-text
