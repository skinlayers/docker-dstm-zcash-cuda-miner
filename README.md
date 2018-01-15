# Dockerized dstm's ZCash Cuda miner 
https://bitcointalk.org/index.php?topic=2021765.0

## Requirements
- [Docker 17.05+](https://www.docker.com/community-edition#/download)
- [Docker Engine Utility for NVIDIA GPUs](https://github.com/NVIDIA/nvidia-docker)

## Building
```
docker build -t dstm-zcash-cuda-miner:0.5.8 .
```

## Examples
### ZenCash with zhash.pro mining pool
#### Launch container
```
docker run \
    -td \
    --init \
    --name zen_zhashpro_miner \
    --runtime=nvidia \
    --restart on-failure \
    dstm-zcash-cuda-miner:0.5.8 \
    --server zhash.pro \
    --port 3057 \
    --user ZEN_ADDRESS.WORKER_NAME \
    --pass x
```

#### Stop container
```
docker stop zen_zhashpro_miner
```

#### Start existing container
```
docker start zen_zhashpro_miner
```

### ZClassic with minez.zone mining pool
#### Launch container
```
docker run \
    -td \
    --init \
    --name zcl_minezzone_miner \
    --runtime=nvidia \
    --restart on-failure \
    dstm-zcash-cuda-miner:0.5.8 \
    --server ny1.minez.zone \
    --port 3044 \
    --user ZCL_ADDRESS.WORKER_NAME \
    --pass x
```

#### Stop container
```
docker stop zcl_minezzone_miner
```

#### Start existing container
```
docker start zcl_minezzone_miner
```
