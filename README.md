# katago-tensorrt-ssh

带TensorRT的Katago，同时配好了SSH的Docker容器，极大简化跑狗流程并支持远程跑狗！

[项目Docker链接](https://hub.docker.com/r/hanxu1995/katago-tensorrt-ssh)

## 使用说明

### 准备工作

* 支持TensorRT的英伟达显卡
* 安装Docker
* 从[神经网络下载链接](https://katagotraining.org/networks)下载合适的神经网络，例如kata1-b28c512nbt-s8032072448-d4548958859.bin.gz
* （可选、推荐）安装图形界面，例如Lizzieyzy
* （可选）配置自己的cfg文件

### 运行

首先将下载好的神经网络文件以及自己的cfg文件（如有）放入assets文件夹中。

之后直接用提供的yml文件启动Docker容器即可。默认配置下，SSH的用户名为root，密码为123，端口为2222。如需修改可以编辑Dockerfile。

```bash
docker compose up -d
```

### 图形界面（以Lizzieyzy为例）

启动Lizzieyzy（[Lizzieyzy链接](https://github.com/yzyray/lizzieyzy)）后，设置引擎时勾选“远程引擎”，IP根据Docker容器运行情况填写（例如运行Docker Desktop时可能IP应为localhost），密码填123，端口填2222。

命令行中填写以下内容，可根据自身情况替换其中的文件名。
```bash
/app/katago gtp -model /app/assets/kata1-b28c512nbt-s8032072448-d4548958859.bin.gz -config /app/assets/default_gtp.cfg
```

## 致谢

灵感来自于[Darkness4/katago-docker](https://github.com/Darkness4/katago-docker)。

## 协议
MIT

# katago-tensorrt-ssh

A Docker container that runs Katago with TensorRT, has SSH set up. Great for remote engine!

[Project Docker Link](https://hub.docker.com/r/hanxu1995/katago-tensorrt-ssh)

## Usage

### Prerequisites

* Nvidia GPU that supports TensorRT
* Docker installed
* Download a network from [Network download link](https://katagotraining.org/networks), such as kata1-b28c512nbt-s8032072448-d4548958859.bin.gz
* (Optional, recommended) Set up a GUI such as Lizzieyzy
* (Optional) Set up a custom cfg file

### Run

First, put the network file and custom cfg files (if there is one) into the "assets" folder.

Then run the following command to start the Docker container. By default, the SSH username is root, password is 123, port is 2222. If changes are desired, one may edit the Dockerfile.

```bash
docker compose up -d
```

### GUI (Taking Lizzieyzy as example)

In Lizzieyzy ([Lizzieyzy link](https://github.com/yzyray/lizzieyzy)), navigate to Settings-Engines, check the "Remote" box, fill in the IP field according to the Docker container environment (For example, it might be localhost if running Docker Desktop), put 123 as password and 2222 as port.

In the "Command" box, put the following. Change the filenames accordingly.
```bash
/app/katago gtp -model /app/assets/kata1-b28c512nbt-s8032072448-d4548958859.bin.gz -config /app/assets/default_gtp.cfg
```

## Acknowledgments

Inspired by [Darkness4/katago-docker](https://github.com/Darkness4/katago-docker).

## License
MIT
