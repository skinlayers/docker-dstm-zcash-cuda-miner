# Dockerized dstm's ZCash Cuda miner 
https://bitcointalk.org/index.php?topic=2021765.0

## Requirements
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

## Donations
If you find this useful, feel free to toss some coin my way.

ETH: 0x75F4363b09166FDf8702F41502E90D21A3F2Afb9
ZEN: znY2eiUwdx9Pj4EzRkktZqRWHfEfX7o9gkW
FTC: 6nDBmQE65gy7BbcUYbYPttc9EYA7eNKN3g
ZCL: t1cSvJsEBWCipA4CY9K7oi9sKRQgb3EG76T
VIVO: VVmjio2zqGgfnvmkEU9bZcxXmFpNswusig
TZC: Tn6K9mw6bKc8R447CrpeEMazFcve8vEg1a
LBC: bXp34GVRLnQgTTid9x6nMorHYjq1GzFwz7
GBX: GTeMA2kehXf2E7DqPGEGVSsb1gQWxpg5Lx
BTC: 196h6xSrcjEPMf7jRQZbNBQcAB3twDMHE6
