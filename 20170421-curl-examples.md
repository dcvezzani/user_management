~/Dropbox/journal/current/20170421-curl-examples.md
curl examples

curl 'http://localhost:3000/api/users' \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1'

curl 'http://localhost:3000/api/users' \
  -X POST \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1' \
  --data '{"email":"samjones33@email.com","firstname":"Sam","lastname":"Jones","password":"pass"}'

curl 'http://localhost:3000/api/users/58fa82cac9b48acd898564d4' \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1'
  
curl 'http://localhost:3000/api/users/58fa82cac9b48acd898564d4' \
  -X PUT \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1' \
  --data '{"email":"samjones33@email.com","firstname":"Sam","lastname":"Johansen","password":"pass"}'

curl 'http://localhost:3000/api/users/58fa82cac9b48acd898564d4' \
  -X DELETE \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1'

curl 'http://localhost:3000/api/auth/register' \
  -X POST \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1' \
  --data '{"email":"samjones55@email.com","firstname":"Sam","lastname":"Zeta-Jones","password":"pass"}'

curl 'http://localhost:3000/api/dashboard' \
  -H 'Authorization: JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1OGZhOTE4MGQxOGUyM2QwZTZjZjRkMTUiLCJmaXJzdG5hbWUiOiJTYW0iLCJsYXN0bmFtZSI6IlpldGEtSm9uZXMiLCJlbWFpbCI6InNhbWpvbmVzNTVAZW1haWwuY29tIiwicm9sZSI6Ik1lbWJlciIsImlhdCI6MTQ5MjgxNjI1NywiZXhwIjoxNDkyODI2MzM3fQ.DLvqA3CUviB8JTxlg6NQuImJFaXTEfxxPUszbHMkTPs' \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1'

curl 'http://localhost:3000/api/auth/login' \
  -X POST \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1' \
  --data '{"email":"dcvezzani@gmail.com","password":"pass"}'

Response
```
{
  "token": "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1OGZhOGIxNjI1YmNmNmNmZmY3MWVlMmMiLCJmaXJzdG5hbWUiOiJKdXZlbnRhIiwibGFzdG5hbWUiOiJWZXp6YW5pIiwiZW1haWwiOiJqdmV6emFuaUBnbWFpbC5jb20iLCJyb2xlIjoiTWVtYmVyIiwiaWF0IjoxNDkyODE0NjE0LCJleHAiOjE0OTI4MjQ2OTR9.eOT39mqqwVhseCkxjh03NB15gNQwQx_Klgk5zklCpis",
  "user": {
    "_id": "58fa8b1625bcf6cfff71ee2c",
    "firstname": "Juventa",
    "lastname": "Vezzani",
    "email": "jvezzani@gmail.com",
    "role": "Member"
  }
}
```

curl 'http://localhost:3000/api/dashboard' \
  -H 'Authorization: JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1OGZhODE2ZTgwNGNhOGNiYjdkZGNiNmIiLCJmaXJzdG5hbWUiOiJEYXZpZCIsImxhc3RuYW1lIjoiVmV6emFuaSIsImVtYWlsIjoiZGN2ZXp6YW5pQGdtYWlsLmNvbSIsInJvbGUiOiJNZW1iZXIiLCJpYXQiOjE0OTI4MTYzMjMsImV4cCI6MTQ5MjgyNjQwM30.ALowu5bWZ-1zOlMD1GVg8N8cC_onc0_FWiIMkWlKLYg' \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1'

Response
```
It worked! User id is: 58fa816e804ca8cbb7ddcb6b.%
```

