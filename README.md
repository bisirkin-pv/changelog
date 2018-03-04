# changelog
Журнализация изменений проекта

## URL для вызова API

* авторизация пользователя
post /api/login
parameters:
username - имя пользователя
password - пароль
Результат Json {code, msg}

В работе:
* работа с пользователями
** получение списка всех пользоваетелей
get /api/users

** получение конкретного пользователя
get /api/users/\d

** добавление новго пользователя
post /api/users
parameters:
username
password
email