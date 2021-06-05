# Database Instructions

Requirements and instructions to create and populate the databases.

## MongoDB

### Requirements

The script has the following requirements:

1. Python - [Download Link](https://www.python.org/downloads/)
2. PyMongo library - install via terminal
   ```shell
    python -m pip install pymongo
    ```
3. Python Dotenv library - install via terminal
    ```shell
    python -m pip install python-dotenv
    ```

### Instructions

To run the script, open a terminal tab at the [model/mongodb/](model/mongodb/) folder and execute the following command:

```shell
python populate.py
```

It will open the MongoDB database with the group/password and server provided in the [model/mongodb/.env](model/mongodb/.env) file and add the collections created using the data exported from the SQL Developer server, found in the [model/mongodb/data/](model/mongodb/data) folder.

## Neo4j

### Instructions

Create a new Local DBMS on Neo4j and add the files located at [model/neo4j/data/](model/neo4j/data/) to the DBMS import folder. After that, open it with Neo4j Browser and run the script [create.cypher](model/neo4j/create.cypher) to create and populate the database with the data files.

## SQL

### Instructions

Execute the [create.sql](model/sql/create.sql) script on Oracle SQLDeveloper to create and populate the tables.
