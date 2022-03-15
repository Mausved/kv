### about
It's simple NoSQL kv-storage based on tarantool

### usability
`docker-compose up -dV`

### net using
`http://89.208.198.186/kv/1`
`http://some-kv-storage.ru/kv/1`

### api (postman)
https://www.postman.com/universal-desert-400924/workspace/tarantool/overview

### task

Высылаю тестовое: 
1) скачать/собрать тарантул
2) реализовать на нем kv-хранилище доступное по http
3) выложить на гитхаб 
4) задеплоить где-нибудь в публичном облаке, чтобы мы смогли проверить работоспособность (или любым другим способом)


API:
 - POST /kv body: {key: "test", "value": {SOME ARBITRARY JSON}} 
 - PUT kv/{id} body: {"value": {SOME ARBITRARY JSON}}
 - GET kv/{id} 
 - DELETE kv/{id}


 - POST  возвращает 409 если ключ уже существует, 
 - POST, PUT возвращают 400 если боди некорректное
 - PUT, GET, DELETE возвращает 404 если такого ключа нет
 - все операции логируются
