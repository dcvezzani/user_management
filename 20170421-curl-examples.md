## Without authentication

CRUD examples
```
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
```

Register
```
curl 'http://localhost:3000/api/auth/register' \
  -X POST \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1' \
  --data '{"email":"dcvezzani@gmail.com","firstname":"Dave","lastname":"Vezzani","password":"pass"}'
  --data '{"email":"samjones55@email.com","firstname":"Sam","lastname":"Zeta-Jones","password":"pass"}'
```

Login
```
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
```

---

Whether registering or logging in, a token is returned if the username/password is successful

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

## With authentication

CRUD examples
```
curl 'http://localhost:3000/api/users' \
  -H 'Authorization: JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1OGZiODZkZGMwMWFmYTJlZjQwODMwN2IiLCJmaXJzdG5hbWUiOiJEYXZlIiwibGFzdG5hbWUiOiJWZXp6YW5pIiwiZW1haWwiOiJkY3ZlenphbmlAZ21haWwuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNDkyODc5MTk2LCJleHAiOjE0OTI4ODkyNzZ9.As5Ro-keS5WXTEGr-vr8pdniVcJ4_FbBrv8h9gzaxs4' \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1'

curl 'http://localhost:3000/api/users' \
  -X POST \
  -H 'Authorization: JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1OGZiODZkZGMwMWFmYTJlZjQwODMwN2IiLCJmaXJzdG5hbWUiOiJEYXZlIiwibGFzdG5hbWUiOiJWZXp6YW5pIiwiZW1haWwiOiJkY3ZlenphbmlAZ21haWwuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNDkyODc5MTk2LCJleHAiOjE0OTI4ODkyNzZ9.As5Ro-keS5WXTEGr-vr8pdniVcJ4_FbBrv8h9gzaxs4' \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1' \
  --data '{"email":"samjones68@email.com","firstname":"Sam","lastname":"Jones","password":"pass"}'

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

curl 'http://localhost:3000/api/users/58faa53691c029d7bab24e5e' \
  -X DELETE \
  -H 'Authorization: JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1OGZhODE2ZTgwNGNhOGNiYjdkZGNiNmIiLCJmaXJzdG5hbWUiOiJEYXZpZCIsImxhc3RuYW1lIjoiVmV6emFuaSIsImVtYWlsIjoiZGN2ZXp6YW5pQGdtYWlsLmNvbSIsInJvbGUiOiJNZW1iZXIiLCJpYXQiOjE0OTI4MjA0NjYsImV4cCI6MTQ5MjgzMDU0Nn0.V_NICDhZBnlAVsI4Wz2XlPyAoCQPx1qggfeI7uNtfbE' \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1'
```

### Testing out role-based authorization

Set user role to 'Member'
```
me = db.users.find({_id: ObjectId('58fa816e804ca8cbb7ddcb6b')})[0];
```

Set user role to 'Member'
```
mongo user_management
db.users.update(
   { "_id": ObjectId('58fb86ddc01afa2ef408307b') },
   {
     $set: { role: "Member" }
   },
   { upsert: true }   
)
```

Set user role to 'Admin'
```
mongo user_management
db.users.update(
   { "_id": ObjectId('58fb86ddc01afa2ef408307b') },
   {
     $set: { role: "Admin" }
   },
   { upsert: true }   
)
```

