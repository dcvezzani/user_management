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
  --data '{"username":"samjones32","firstname":"Sam","lastname":"Jones"}'

curl 'http://localhost:3000/api/users/58fa612a1e010524f00204ea' \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1'
  
curl 'http://localhost:3000/api/users/58fa612a1e010524f00204ea' \
  -X PUT \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1' \
  --data '{"username":"samjones48","firstname":"Sam","lastname":"Jones"}'

curl 'http://localhost:3000/api/users/58fa612a1e010524f00204ea' \
  -X DELETE \
  -H 'Host: localhost:3000' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1'

