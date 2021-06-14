Depending docker images demo
============================

Reference: https://stackoverflow.com/questions/37933204/building-common-dependencies-with-docker-compose

## Method 1. makefile

- A standard approach for building something step-by-step.
- Not capable of running a container orchestration system.

```shell
$ make

# docker build -t mybase ./baseimage
# Sending build context to Docker daemon  2.048kB
# Step 1/3 : FROM alpine
#  ---> 6dbb9cc54074
# Step 2/3 : ENTRYPOINT ["echo"]
#  ---> Using cache
#  ---> f8bed22e29f8
# Step 3/3 : CMD ["this is baseimage"]
#  ---> Using cache
#  ---> 95d31d3b1c41
# Successfully built 95d31d3b1c41
# Successfully tagged mybase:latest
# docker build -t my_v1 ./v1
# Sending build context to Docker daemon  2.048kB
# Step 1/2 : FROM mybase
#  ---> 95d31d3b1c41
# Step 2/2 : CMD ["This is v1"]
#  ---> Using cache
#  ---> 121a0c04c0f6
# Successfully built 121a0c04c0f6
# Successfully tagged my_v1:latest
# docker build -t my_v2 ./v2
# Sending build context to Docker daemon  2.048kB
# Step 1/2 : FROM mybase
#  ---> 95d31d3b1c41
# Step 2/2 : CMD ["This is v2"]
#  ---> Using cache
#  ---> c25cf7982cdc
# Successfully built c25cf7982cdc
# Successfully tagged my_v2:latest
```


## Method 2. docker-compose with "depends_on" keyword

- Good if containers depend on each other.
- If not, this can be seen as workaround approach to build images in a single command.
```shell
# build and run
$ docker-compose up

# Starting dockercomposetest_base_1 ... done
# Starting dockercomposetest_app_v2_1 ... done
# Starting dockercomposetest_app_v1_1 ... done
# Attaching to dockercomposetest_base_1, dockercomposetest_app_v2_1, dockercomposetest_app_v1_1
# app_v1_1  | This is v1
# app_v2_1  | This is v2
# base_1    | this is baseimage
# dockercomposetest_base_1 exited with code 0
# dockercomposetest_app_v2_1 exited with code 0
# dockercomposetest_app_v1_1 exited with code 0
```

```shell
# just build
$ docker-compose build

# Building base
# Sending build context to Docker daemon  2.048kB
# Step 1/3 : FROM alpine
#  ---> 6dbb9cc54074
# Step 2/3 : ENTRYPOINT ["echo"]
#  ---> Using cache
#  ---> f8bed22e29f8
# Step 3/3 : CMD ["this is baseimage"]
#  ---> Using cache
#  ---> 95d31d3b1c41
# Successfully built 95d31d3b1c41
# Successfully tagged mybase:latest
# Building app_v1
# Sending build context to Docker daemon  2.048kB
# Step 1/2 : FROM mybase
#  ---> 95d31d3b1c41
# Step 2/2 : CMD ["This is v1"]
#  ---> Using cache
#  ---> 121a0c04c0f6
# Successfully built 121a0c04c0f6
# Successfully tagged dockercomposetest_app_v1:latest
# Building app_v2
# Sending build context to Docker daemon  2.048kB
# Step 1/2 : FROM mybase
#  ---> 95d31d3b1c41
# Step 2/2 : CMD ["This is v2"]
#  ---> Using cache
#  ---> c25cf7982cdc
# Successfully built c25cf7982cdc
# Successfully tagged dockercomposetest_app_v2:latest
```



