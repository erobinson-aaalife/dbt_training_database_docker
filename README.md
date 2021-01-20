# dbt_training
This repository contains build instructions to generate a container suitable to complete DBT training.

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
In order to build and run the container, your computer must have the following software installed:

**Windows**
- Docker Desktop must be installed - refer to requirements [here](https://docs.docker.com/docker-for-windows/install/)
- Windows Subsystem for Linux [link](https://docs.microsoft.com/en-us/windows/wsl/install-win10) is preferred.

**Linux**

Docker Engine [link](https://docs.docker.com/engine/install/) must be installed.

## How to Build
