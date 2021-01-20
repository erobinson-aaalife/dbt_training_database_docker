# DBT Training Container
This repository contains build instructions to generate a container suitable to complete DBT training.  **Due to intentionally reduced security, this container should not be used to hold any production data or PII of any sort.**

## Container Details

The docker container includes the following:

- A Postgres database with test data preloaded into the following structure:
```
+--jaffle_shop
|  +--customers (from jaffle_shop_customers.csv)
|  +--orders (from jaffle_shop_orders.csv)
+--stripe
|  +--payment (from stripe_payments.csv)
```
- Python 3.7 with `dbt` package and dependencies installed.
## Prerequisites
### Software
In order to build and run the container, your computer must have the following software installed:

**Windows**
- Docker Desktop must be installed - refer to requirements [here](https://docs.docker.com/docker-for-windows/install/)
- Windows Subsystem for Linux [link](https://docs.microsoft.com/en-us/windows/wsl/install-win10) is preferred.

**Linux**

Docker Engine [link](https://docs.docker.com/engine/install/) must be installed.
### Other
- You will need a basic understanding of Windows and Linux commands
- Basic understanding of how to build and run Docker containers
## How to Build
Create a working directory to hold your files with the following structure:
```
+--[Your working directory's name]
|  +--dbt_files
```
From the command line, navigate to the directory you created. Run the following command to build the target Docker container:

`docker build  https://github.com/erobinson-aaalife/dbt_training.git#main -t dbt-training`

## How to Run
From your working directory run the following command to start the Docker container:
`docker run --name dbt-training -dp 5432:5432 -v [Your working directory's filepath]\dbt_files:/dbt_files dbt-training:latest`

### Accessing the Postgres DB outside the Docker container
The following parameters can be used to connect to the Postgres database instance from the query tool of your choice:
| Parameter          | Value        |
|-------------------|------------|
| Address          | localhost or 127.0.0.1|
|Port|5432|
|username|postgres|
|password|password<sup>1</sup>|

Please note that this database is local, and has no ability to connect externally.

<sup>1</sup> For any non-training exercise, this is a terrible security practice and should never be done.
