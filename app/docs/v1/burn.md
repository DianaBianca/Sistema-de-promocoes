## Burn

Valida se o cupom está está disponivel para uso verificando se ainda está dentro da validade, se está ativo e se já foi utilizado.

Caso esteja tudo certo, você poderá "queimar" o cupom e seu **status** mudará de **active** para **burn**

Parâmetros:

| nome      | descrição               |
| --------- | ------------------------|
| code      | código do cupom         |

Rota:
```
  /api/v1/coupons/code/burn
```

Exemplo quando o cupom ativo é queimado **(no em uma outra aba do terminal , rodando o servidor localmente):**

Este exemplo em específico a requisição é feita de maneira diferente pois quando feita a requisição pela URL do navegador, ele considera a requisição como um GET, e nesse caso, a rota é de POST.

Essa requisição pode ser feita pelo [Postman](https://www.postman.com/) ou via cURL, neste exemplo usaremos o cURL.

```
  curl -d  -X POST http://localhost:3000/api/v1/coupons/Nerds-0001/burn
```

Resposta:
```
  {
    "message":"Cupom utilizado com sucesso",
    "coupon":"Nerds-0001",
    "actual_status":"burn"
  }
```

Exemplo com um cupom já queimado **(no em uma outra aba do terminal , rodando o servidor localmente):**

Resposta:
```
  {
    "message":"Cupom não pode ser queimado",
    "coupon":"Nerds-0001",
    "actual_status":"burn"
  }
```

Exemplo de resposta quando esse cupom recém queimado é exibido na rota de **show** **(no navegador, rodando o servidor localmente):**

```
  http://localhost:3000/api/v1/coupons/Nerds-0001
```

Resposta:
```
  {
    "code":"Nerds-0001",
    "actual_status":"burn",
    "coupon_info":{
      "promotion_id":4,
      "discount_rate":"50.0",
      "expiration_date":"02/12/2023"
    }
  }
```

