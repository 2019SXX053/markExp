# markExp

# RUN

1. 创建网络

```bash
docker network create velcom-network
```

2. 启动数据库

打开一个新的 Terminal

```bash
cd database
./build_and_run.sh
```

3. 启动中间件

打开一个新的 Terminal

```bash
cd midware
./build_and_run.sh
```

4. 访问web

在 remote-explorer 里用浏览器打开 5000 端口
