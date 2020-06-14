# datoji

A FREE RESTful HTTP based JSON API. It lets you create, read, update, delete and search JSON data over HTTP APIs. Ideal for small hobbies projects, MVP or just for fun, where you don't need to create your personal data storage.


## Schema

All API access is over HTTPS, and accessed from https://datoji.dev. All data is sent and received as JSON.

Blank fields are included as null instead of being omitted.

All timestamps return in ISO 8601 format:

``` ruby
YYYY-MM-DDTHH:MM:SSZ
```

All responses follow the [JSON:API](https://jsonapi.org/format/) guidelines:

JSON:API is a specification for how a client should request that resources be fetched or modified, and how a server should respond to those requests.

JSON:API is designed to minimize both the number of requests and the amount of data transmitted between clients and servers. This efficiency is achieved without compromising readability, flexibility, or discoverability.

```
{
  "data": {
    "type": "entry",
    "id": "1",
    "attributes": {
      // ... this entry's attributes
    },
    "relationships": {
      // ... this entry's relationships
    }
  }
}
```

## Pagination

Requests that return multiple items will be paginated to 20 items by default. You can specify further pages with the ```?page``` parameter. Pagination information is available inside **headers**. Example:

```
Current-Page: 1
Per-Page: 20
Link:<https://datoji.dev/packs/{PACK_ID}/entries?page=1>; rel="first", <https://datoji.dev/packs/{PACK_ID}/entries?page=24>; rel="last"
Total: 464
```

## Documentation

**Authentication**

API uses OAuth 2.0 token for user authorization and API authentication. Applications must be authorized and authenticated before they can fetch data.

    
```sh

curl -X POST 'https://datoji.dev/tokens' -H 'content-type: application/json'

```


```json

{
  "data": {
    "id": "b14e1665-5ab3-4b71-a669-b6280d64147e",
    "type": "token",
    "attributes": {
      "key": "uBrcpRP3QVgEJeuffuENPeSc2ObAaGoO",
      "created_at": "2020-06-12T12:51:18.971Z"
    }
  }
}

```

**Note**

You must use `Authorization: Token 80-Pk8MtTMLXT_ThBaCDuDtF1eTyVmQj` header for ALL requests.

## CRUD PACKS

**Create**

A Pack is a container of all the entries. Before you can create the entries you must create the container to get the **ID** with which you can make the calls.

```sh

curl -X POST 'https://datoji.dev/packs' -H 'content-type: application/json' -H 'Authorization: Token {KEY}'
    
```

```json

{
  "data": {
    "id": "918f6a68-89f7-4f0c-aa6d-73b447d92819",
    "type": "pack",
    "attributes": {
      "entries_count": 0,
      "active": true,
      "created_at": "2020-06-11T14:22:12.354Z",
      "updated_at": "2020-06-11T14:22:12.354Z"
    }
  }
}

```

**Clear**

With the clear method you can clean the pack from all entries.

```sh

curl -X POST 'https://datoji.dev/packs/{PACK_ID}/clear' -H 'content-type: application/json' -H 'Authorization: Token {KEY}'
    
```

**Delete**

With the clear method you can clean the pack from all entries.

```sh

curl -X DELETE 'https://datoji.dev/packs/{PACK_ID}' -H 'content-type: application/json' -H 'Authorization: Token {KEY}'
    
```

## CRUD ENTRY

**Create**

```sh

curl -X POST 'https://datoji.dev/{PACK_ID}/entries' \
    -H 'content-type: application/json' \
    -H 'Authorization: Token {KEY}' \
    -d '{ "entry": { "repo": "davidesantangelo/datoji", "private": false, "stargazers_count": 0 } }'
    
```

```json

{
  "data": {
    "id": "04b7992a-40de-496b-a994-a661a9893df7",
    "type": "entry",
    "attributes": {
      "data": {
        "repo": "davidesantangelo/datoji",
        "private": "false",
        "stargazers_count": 0
      },
      "created_at": "2020-06-11T14:37:34.857Z",
      "updated_at": "2020-06-11T14:37:34.857Z"
    },
    "relationships": {
      "pack": {
        "data": {
          "id": "918f6a68-89f7-4f0c-aa6d-73b447d92819",
          "type": "pack"
        }
      }
    }
  }
}

```

**Read**

Use HTTP GET to read all the records or a single record.

```sh

curl -X GET 'https://datoji.dev/packs/{PACK_ID}/entries' -H 'Authorization: Token {KEY}'

```

```json

{
  "data": [
    {
      "id": "beb31992-0268-48b4-b5bc-b2cad0add5c7",
      "type": "entry",
      "attributes": {
        "data": {
          "repo": "davidesantangelo/datoji",
          "private": "false",
          "stargazers_count": 0
        },
        "created_at": "2020-06-11T14:59:00.581Z",
        "updated_at": "2020-06-11T14:59:00.581Z"
      },
      "relationships": {
        "pack": {
          "data": {
            "id": "918f6a68-89f7-4f0c-aa6d-73b447d92819",
            "type": "pack"
          }
        }
      }
    },
    {
      "id": "b858bf82-1abf-4cb0-a9e0-2a59f1b7f30d",
      "type": "entry",
      "attributes": {
        "data": {
          "repo": "davidesantangelo/feedirss-api",
          "private": "false",
          "stargazers_count": 326
        },
        "created_at": "2020-06-11T14:37:08.293Z",
        "updated_at": "2020-06-11T14:37:08.293Z"
      },
      "relationships": {
        "pack": {
          "data": {
            "id": "918f6a68-89f7-4f0c-aa6d-73b447d92819",
            "type": "pack"
          }
        }
      }
    }
  ]
}


```

```sh

curl -X GET 'https://datoji.dev/packs/{PACK_ID}/entries/{ENTRY_ID}' -H 'Authorization: Token {KEY}'

```

```json

{
  "data": {
    "id": "04b7992a-40de-496b-a994-a661a9893df7",
    "type": "entry",
    "attributes": {
      "data": {
        "repo": "davidesantangelo/feedirss-api",
        "private": "false",
        "stargazers_count": 326
       },
      "created_at": "2020-06-11T14:37:34.857Z",
      "updated_at": "2020-06-11T14:37:34.857Z"
    },
    "relationships": {
      "pack": {
        "data": {
          "id": "918f6a68-89f7-4f0c-aa6d-73b447d92819",
          "type": "pack"
        }
      }
    }
  }
}

```

**Update**

Use HTTP PUT to update record one by one. Please note that this will not patch the record, it is full update. 

``` sh

curl -X PUT 'https://datoji.dev/packs/{PACK_ID}/entries/{ENTRY_ID}' \
    -H 'content-type: application/json' \
    -H 'Authorization: Token {KEY}' \
    -d '{ "entry": { "repo": "davidesantangelo/datoji", "private": true, "stargazers_count": 10 } }'
    
```

```json

{
  "data": {
    "id": "04b7992a-40de-496b-a994-a661a9893df7",
    "type": "entry",
    "attributes": {
      "data": {
        "entry": {
          "repo": "davidesantangelo/datoji",
          "private": true,
          "stargazers_count": 10
        }
      },
      "created_at": "2020-06-11T14:37:34.857Z",
      "updated_at": "2020-06-11T14:43:45.153Z"
    },
    "relationships": {
      "pack": {
        "data": {
          "id": "918f6a68-89f7-4f0c-aa6d-73b447d92819",
          "type": "pack"
        }
      }
    }
  }
}

```

**Delete**

To delete a specific record use HTTP DELETE, you will receive in case of success a *204 No Content* code.

```sh

curl -X DELETE 'https://datoji.dev/packs/{PACK_ID}/entries/{ENTRY_ID}' -H 'Authorization: Token {KEY}'

```
## Search

You can perform searches within the dataset.

Supporting:

- unquoted text: text not inside quote marks will be converted to terms separated by & operators, as if processed by plainto_tsquery.

- "quoted text": text inside quote marks will be converted to terms separated by <-> operators, as if processed by phraseto_tsquery.

- OR: logical or will be converted to the | operator.

- -: the logical not operator, converted to the the ! operator.


```sh

curl -X GET 'https://datoji.dev/packs/{PACK_ID}/search?q=datoji' -H 'Authorization: Token {KEY}'

```

```json

{
  "data": [
    {
      "id": "b858bf82-1abf-4cb0-a9e0-2a59f1b7f30d",
      "type": "entry",
      "attributes": {
        "data": {
          "repo": "davidesantangelo/datoji",
          "private": true,
          "stargazers_count": 10
        }
        "created_at": "2020-06-11T14:37:08.293Z",
        "updated_at": "2020-06-11T14:37:08.293Z"
      },
      "relationships": {
        "pack": {
          "data": {
            "id": "918f6a68-89f7-4f0c-aa6d-73b447d92819",
            "type": "pack"
          }
        }
      }
    }
  ]
}

```

## Limitations
* Requests are rate-limited to **400** per 5 minutes per IP address.
* There is no limit imposed on the number of entries or packs records, but please **don't abuse** it since it's a service i offer free of charge. 

## Built With

- [Ruby on Rails](https://github.com/rails/rails) &mdash; Our back end API is a Rails app. It responds to requests RESTfully in JSON.
- [PostgreSQL](https://www.postgresql.org/) &mdash; Our main data store is in Postgres.
- [Redis](https://redis.io/) &mdash; We use Redis as a cache and for transient data.
- [FastJSONAPI](https://github.com/Netflix/fast_jsonapi) &mdash; A lightning fast JSON:API serializer for Ruby Objects.
- [Textacular](https://github.com/textacular/textacular) &mdash; Textacular exposes full text search capabilities from PostgreSQL.
- [Rack::Attack](https://github.com/kickstarter/rack-attack) &mdash; Rack middleware for blocking & throttling abusive requests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davidesantangelo/datoji. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
