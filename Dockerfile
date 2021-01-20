FROM postgres:latest
# Set some default environment variables
ENV POSTGRES_PASSWORD=password
ENV POSTGRES_DB=dbt_training

# Store password for DB to environment variable for command line users
ENV PGPASSWORD=${POSTGRES_PASSWORD}

# install additional software

#update catalog and install necessary packages, then clean up
RUN apt-get update && apt-get install -y \
curl \
python3 \
python3-pip \
python3.7-dev \
postgresql-server-dev-10 \
gcc \
python3-dev \
musl-dev \
&& rm -rf /var/lib/apt/lists/*

# Install DBT
RUN pip3 install dbt==0.18.0

# Create scratch file location to download test data
RUN mkdir /home/datafiles
# download training files from DBT
# note:  resolv.conf isn't persisted, so DNS can't resolve these URLs at compile time.  Echoing a known DNS IP in the same command keeps it memory-resident enough for downloads to work.
RUN echo nameserver 1.1.1.1 > /etc/resolv.conf && curl http://dbt-tutorial-public.s3-us-west-2.amazonaws.com/jaffle_shop_orders.csv --output /home/datafiles/jaffle_shop_orders.csv
RUN curl http://dbt-tutorial-public.s3-us-west-2.amazonaws.com/jaffle_shop_customers.csv --output /home/datafiles/jaffle_shop_customers.csv
RUN curl http://dbt-tutorial-public.s3-us-west-2.amazonaws.com/stripe_payments.csv --output /home/datafiles/stripe_payments.csv

#reassign ownership of directory
RUN chown -R postgres /home/datafiles

# switch to postgres admin user
USER postgres

# expose Postgres port
EXPOSE 5432



# bind mount Postgres volumes for persistent data
# note:  these need to exist but users generally don't need to access them directly, so volume-mounting via dockerfile is appropriate here
VOLUME ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql","/home/datafiles"]





# copy sql script into the initialization directory to load data into image

COPY ./load_test_data.sql /docker-entrypoint-initdb.d/init.sql

RUN ls /home/datafiles/
# start postgres server
#RUN pg_ctl start -l logfile

# run database when image is started
#RUN psql -a -d ${POSTGRES_DB} -f /home/datafiles/load_test_data.sql 

# stop the server (it will start again when the container is booted up)
#RUN pg_ctl stop