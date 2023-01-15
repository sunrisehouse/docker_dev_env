# Docker Dev Env

## How to Pull a Docker Image
```
docker pull ajtwlswjddnv/dev
```

## How to Build
```
docker build -t dev .
```

## How to Run
```
docker run -itd --name dev dev
```

## How to Access
```
docker exec -itd dev bash
```

## How to Save
```
docker save dev -o dockerimage_dev_env.tar
```

## How to Load
```
docker load -i dev.tar
```
