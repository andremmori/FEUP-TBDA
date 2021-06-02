# README

Requirements and instructions to execute the Python script to add data to the MongoDB database.

## Requirements

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

## Instructions

To run the script, open a terminal tab at the [script/](../script) folder and execute the following command:

```shell
python populate.py
```

It will open the MongoDB database with the group/password and server provided in the [.env](.env) file and add the collections created using the data exported from the SQL Developer server, found in the [data/](./data) folder.