FROM postgres:latest
# Set some default environment variables
ENV POSTGRES_PASSWORD=password
ENV POSTGRES_DB=dbt_training

# Store password for DB to environment variable for command line users
ENV PGPASSWORD=${POSTGRES_PASSWORD}

# Create scratch file location to download test data
RUN mkdir /home/datafiles

#reassign ownership of directory
RUN chown -R postgres /home/datafiles

# switch to postgres admin user
USER postgres

# expose Postgres port
EXPOSE 5432



# bind mount Postgres volumes for persistent data
# note:  these need to exist but users generally don't need to access them directly, so volume-mounting via dockerfile is appropriate here
VOLUME ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql","/home/datafiles"]

# Copy files into dockerfile
COPY ./jaffle_shop_customers.csv /home/datafiles/jaffle_shop_customers.csv
COPY ./jaffle_shop_orders.csv /home/datafiles/jaffle_shop_orders.csv
COPY ./stripe_payments.csv /home/datafiles/stripe_payments.csv



# copy sql script into the initialization directory to load data into image

COPY ./load_test_data.sql /docker-entrypoint-initdb.d/init.sql


RUN ls /home/datafiles/
