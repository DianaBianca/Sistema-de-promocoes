## SHOW

Mostra algumas informações importantes a respeito do cupom pesquisado, como: **código** do cupom, **status** atual, **id da promoção** pertencente a esse cupom, **valor do desconto**, **data de expiração**

Parâmetros:

| nome      | descrição               |
| --------- | ------------------------|
| code      | código do cupom         |

Rota:
```
/api/v1/coupons/code
```

Exemplo quando o cupom existe(no navegador, rodando o servidor localmente):
```
  http://localhost:3000/api/v1/coupons/Nerds-0002
```

Resposta:
```
{
  "code":"Nerds-0002",
  "actual_status":"active",
  "promotion_id":4,"coupon_info":{
    "promotion_id":4,
    "discount_rate":"50.0",
    "expiration_date":"02/12/2023"
  }
}
```

Exemplo quando o cupom não existe(no navegador, rodando o servidor localmente):
```
  http://localhost:3000/api/v1/coupons/Nerds-0
```

Resposta:
```
{
  "message":"Este cupom não existe",
  "coupon":"Nerds-0",
  "actual_status":null
}
```