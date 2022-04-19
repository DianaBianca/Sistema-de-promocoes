## Validates

Valida se o cupom está está disponível para uso a partir de seu parametro **status**.

Parâmetros:

| nome      | descrição               |
| --------- | ------------------------|
| code      | código do cupom         |

Rota:
```
  /api/v1/coupons/code/validates
```

Exemplo quando o cupom existe **(no navegador, rodando o servidor localmente)**:
```
  http://localhost:3000/api/v1/coupons/Nerds-0002/validates
```

Resposta:
```
  {
    "message":"Este cupom é válido",
    "coupon":"Nerds-0002",
    "actual_status":"active"
  }
```
Exemplo quando o cupom existe e já foi queimado **(no navegador, rodando o servidor localmente)**:
```
  http://localhost:3000/api/v1/coupons/Nerds-0001/validates
```
Resposta:
```
  {
    "message":"Este cupom é inválido",
    "coupon":"Nerds-0001",
    "actual_status":"burn"
  }

```

Exemplo quando o cupom não existe **(no navegador, rodando o servidor localmente)**:
```
  http://localhost:3000/api/v1/coupons/asdf12/validates
```

Resposta:
```
  {
    "message":"Este cupom não existe",
    "coupon":"NATAL10-0001",
    "actual_status":null
  }
```