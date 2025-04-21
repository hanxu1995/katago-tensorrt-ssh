# 简介
带TensorRT的Katago，同时配好了SSH的Docker容器，极大简化本地跑狗流程并支持远程跑狗！另带有小白友好版本，快速上手无需复杂配置。\
Docker: https://hub.docker.com/r/hanxu1995/katago-tensorrt-ssh \
Github: https://github.com/hanxu1995/katago-tensorrt-ssh \
Gitee: https://gitee.com/han_xu/katago-tensorrt-ssh \
Docker镜像: hanxu1995/katago-tensorrt-ssh \
阿里云镜像: crpi-kngdtz5svxs0nq25.cn-hangzhou.personal.cr.aliyuncs.com/hanxu1995/katago-tensorrt-ssh

效果图
![效果图](./screenshots/result%20cn.png)

# 使用条件
* 支持TensorRT的英伟达显卡

# 小白友好版本（包含所有配置以及图形界面，无需大量额外操作）
此版本包含了各种配置以及图形界面，可快速上手，如用此版本请忽略以下其它步骤。见[Releases页面](https://github.com/hanxu1995/katago-tensorrt-ssh/releases)以及[B站视频链接](https://www.bilibili.com/video/BV16uAgetEYZ/?vd_source=d974fd7333ff32e4a55f0178902b3cd9)。如果想自己动手做个性化配置以及自己下载神经网络请继续阅读以下说明。

# 使用说明

## 准备工作
* 从[神经网络下载链接](https://katagotraining.org/networks)下载合适的神经网络，例如kata1-b28c512nbt-s8032072448-d4548958859.bin.gz。
* （可选、推荐）安装图形界面，例如Lizzieyzy（Github链接：https://github.com/yzyray/lizzieyzy）。
* （可选）配置自己的cfg文件。

## 运行
### 更新WSL并安装Docker
打开Powershell执行以下命令：
```bash
wsl --update
```
![更新wsl](./screenshots/wsl%20update.png)

安装Docker。可以选择安装[Docker Desktop](https://docs.docker.com/desktop/setup/install/windows-install/)（较为简单），也可以在WSL中安装Docker Desktop或者[Docker Engine](https://docs.docker.com/engine)。

### 拉取项目
将本项目下载到本地。

### 导入神经网络以及配置文件
将下载好的神经网络文件以及自己的cfg文件（如有）放入assets文件夹中。

### 启动Docker容器
之后直接用提供的yml文件启动Docker容器即可。打开Powershell，cd到katago文件夹下，执行以下命令：
```bash
docker compose up -d
```

默认配置下，SSH的用户名为root，密码为123，端口为2222。如需修改可以编辑Dockerfile。

## 图形界面（以Lizzieyzy为例）
启动Lizzieyzy（[Lizzieyzy链接](https://github.com/yzyray/lizzieyzy)）后，设置引擎时勾选“远程引擎”，IP根据Docker容器运行情况填写（例如运行Docker Desktop时可能IP应为localhost），密码填123，端口填2222。

引擎设置中的命令行中填写以下内容，可根据自身情况替换其中的文件名。
```bash
/app/katago gtp -model /app/assets/kata1-b28c512nbt-s8032072448-d4548958859.bin.gz -config /app/assets/default_gtp.cfg
```

感谢支持！

# 常见问题
## 无法连接Docker Hub下载镜像
可以尝试科学上网解决，也可以使用我在阿里云上传的源。编辑docker-compose.yml文件，将image: hanxu1995/katago-tensorrt-ssh替换为image: crpi-kngdtz5svxs0nq25.cn-hangzhou.personal.cr.aliyuncs.com/hanxu1995/katago-tensorrt-ssh即可。

# 致谢

灵感来自于[Darkness4/katago-docker](https://github.com/Darkness4/katago-docker)。

# 协议
MIT

# Introduction
A Docker container that runs Katago with TensorRT and has SSH set up. Great for both local and remote katago engine! Also includes an all in one version which is very easy to use. No need to go through a lot of configs. \
Docker: https://hub.docker.com/r/hanxu1995/katago-tensorrt-ssh \
Github: https://github.com/hanxu1995/katago-tensorrt-ssh \
Gitee: https://gitee.com/han_xu/katago-tensorrt-ssh \
Docker image: hanxu1995/katago-tensorrt-ssh \
Aliyun image: crpi-kngdtz5svxs0nq25.cn-hangzhou.personal.cr.aliyuncs.com/hanxu1995/katago-tensorrt-ssh

Screenshot
![screenshot](./screenshots/result%20en.png)

# Prerequisites
* Nvidia GPU that supports TensorRT

# All in one version（Contains all configs and GUI, needs minimal extra efforts）
This version includes all configurations and has GUI included. Use this if you wish to set up everything quick and easily. See [Releases](https://github.com/hanxu1995/katago-tensorrt-ssh/releases) and a [Bilibili video](https://www.bilibili.com/video/BV16uAgetEYZ/?vd_source=d974fd7333ff32e4a55f0178902b3cd9). Continue reading if you wish to customize your configurations and network used.

# Usage

## Preparation
* Download a suitable network file from [this link](https://katagotraining.org/networks). For example kata1-b28c512nbt-s8032072448-d4548958859.bin.gz.
* (Optional, Recommended) Have a GUI set up. I recommend Lizzieyzy (Github: https://github.com/yzyray/lizzieyzy).
* (Optional) Set up your own cfg file.

## Run
### Update WSL and install Docker
In Powershell run the following command:
```bash
wsl --update
```
![update wsl](./screenshots/wsl%20update.png)

Install Docker. You may choose to install [Docker Desktop](https://docs.docker.com/desktop/setup/install/windows-install/) (easiest), or install Docker Desktop or [Docker Engine](https://docs.docker.com/engine) under WSL.

### Pull Repo
Pull this repo to your local file system.

### Import network and cfg file
Copy the network file and your cfg files (if there is one) to the assets folder.

### Start the Docker container
Use the provided yml file to start the Docker container. In Powershell, cd to the katago directory and run the following command:
```bash
docker compose up -d
```

Under default configurations, the ssh username is root, password is 123 and port is 2222. You may edit the Dockerfile if you want to change these.

## GUI (Taking Lizzieyzy as example)
In Lizzieyzy ([Lizzieyzy link](https://github.com/yzyray/lizzieyzy)), navigate to Settings-Engines, check the "Remote" box, fill in the IP field according to the Docker container environment (For example, it might be localhost if running Docker Desktop), put 123 as password and 2222 as port.

In the "Command" box in the engines settings, put the following. Change the filenames accordingly.
```bash
/app/katago gtp -model /app/assets/kata1-b28c512nbt-s8032072448-d4548958859.bin.gz -config /app/assets/default_gtp.cfg
```

Thank you for your support!

# Troubleshooting
## Cannot pull from Docker Hub
This may happen if pulling from China mainland. Try using a VPN service, or alternatively, use the image I uploaded to Aliyun. Edit the docker-compose.yml file, replace "image: hanxu1995/katago-tensorrt-ssh" with "image: crpi-kngdtz5svxs0nq25.cn-hangzhou.personal.cr.aliyuncs.com/hanxu1995/katago-tensorrt-ssh".

# Acknowledgments

Inspired by [Darkness4/katago-docker](https://github.com/Darkness4/katago-docker).

# License
MIT
