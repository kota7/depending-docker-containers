all: base app_v1 app_v2

base:
	docker build -t mybase ./baseimage

app_v1:
	docker build -t my_v1 ./v1

app_v2:
	docker build -t my_v2 ./v2
