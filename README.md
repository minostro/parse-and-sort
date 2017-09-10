# parse-and-sort
Parse and Sort People Information. The two entry points are:

1. console.rb (runs `CommandLineApp`), and
2. config.ru via bundle exec rackup (runs `RestApp`)

## Command Line App
`console.rb` file is in charge of receiving input from the user and running the command line app. Run the following to familiarized yourself with the options:

```bash
./console.rb -h

Usage: console.rb [options]
    -f, --filepath filepath          Filepath
    -d, --delimiter delimiter        Delimiter
    -h, --help                       Displays Help
```

Run the following command to get some results from the command line app:

```bash
./console.rb -f test-data -d \|

Output 1:
==================================================
Inostroza|Milton2|Female|Black|8/4/1985
Inostroza|Milton|Male|Blue|8/4/1983
==================================================
Output 2:
==================================================
Inostroza|Milton|Male|Blue|8/4/1983
Inostroza|Milton2|Female|Black|8/4/1985
==================================================
Output 3:
==================================================
Inostroza|Milton|Male|Blue|8/4/1983
Inostroza|Milton2|Female|Black|8/4/1985
==================================================
```

## Rest App

Spin up the server:

```bash
bundle exec rackup
```

Create a record in the server by running the following command:

```bash
curl -H "Content-Type: application/json" -X POST -d '{"data": "Inostroza|Milton|Female|Black|04/08/1983", "delimiter": "|" }' http://localhost:9292/records

{"records":1}
```
Get the records from the server:

```bash
curl http://localhost:9292/records/name
[{"last_name":"Inostroza","first_name":"Milton","gender":"Female","favorite_color":"Black","date_of_birth":"8/4/1983"}]

curl http://localhost:9292/records/birthdate
[{"last_name":"Inostroza","first_name":"Milton","gender":"Female","favorite_color":"Black","date_of_birth":"8/4/1983"}]

curl http://localhost:9292/records/gender
[{"last_name":"Inostroza","first_name":"Milton","gender":"Female","favorite_color":"Black","date_of_birth":"8/4/1983"}]
```
