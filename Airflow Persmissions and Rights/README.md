# Airflow Permissions and Rights docker lab setup
Download the docker container from here
```sh
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/stable/docker-compose.yaml'


# Setting up the environment variable
export AIRFLOW_UID=$(id -u)



docker-compose up airflow-init # This initialize the environment only
docker-compose up
```
