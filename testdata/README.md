<h1 align="center">FileDES</h1>

本代码是用于评估论文 **FileDES: A Secure, Scalable, and Succinct Decentralized Encrypted Storage Network (INFOCOM 2024)** 的测试代码。FileDES 旨在支持多版本文件的去中心化加密存储，并通过聚合证明技术防止隐私泄露并实现高效的安全验证。FileDES 是基于 Filecoin (lotus) 开发的。了解更多有关 Filecoin 的细节，请查阅[Filecoin Spec](https://spec.filecoin.io)。

## 基础构建说明 

### 系统要求

FileDES 系统具有特定的运行环境要求，以确保其稳定和高效地运行：
#### 硬件要求
- **CPU:** 2 核或更高
- **内存:** 4GB 或更高
- **存储:** 支持 8MiB 扇区大小的存储空间
- **网络:** 稳定的网络连接
#### 软件环境
- **操作系统:** Ubuntu 22.04 (开发与测试环境)
- **Go 版本:** `1.18.1` (建议保持版本一致，更新的版本可能导致编译错误)
- **Java 环境:** JDK 17 及以上 

### 系统软件依赖 

构建 FileDES 及底层依赖库需要安装一系列系统软件包。请在 Ubuntu/Debian 终端中执行以下命令来安装所有依赖（包含底层依赖与 jsnark 所需库）：

```bash
# 安装基础编译依赖、OpenCL 以及 JDK17
sudo apt update && sudo apt install openjdk-17-jdk openjdk-17-jre mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang build-essential hwloc libhwloc-dev wget -y

# 安装 jsnark 编译所需依赖
sudo apt install cmake libgmp3-dev libprocps-dev python3-markdown libboost-all-dev libssl-dev junit4 -y && sudo apt upgrade -y
```

### Go语言安装 

为了正确编译 FileDES，你需要通过以下命令安装Go 1.18.1：

```bash
wget -c https://golang.org/dl/go1.18.1.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
```

在安装完成后，你需要将 `/usr/local/go/bin` 加入到环境变量中。你可以通过以下命令完成：

```bash
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc && source ~/.bashrc
```

### jsnark安装与配置 

FileDES 依赖于 jsnark 生成聚合证明。由于官方源的 README 主要针对较旧的 Ubuntu 系统，我们针对 Ubuntu 22.04 对编译命令进行了修正。请按以下步骤安装：

```bash
git clone --recursive https://github.com/akosba/jsnark.git
cd jsnark/libsnark
git submodule init && git submodule update
mkdir build && cd build
cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DUSE_ASM=OFF \
  -DCMAKE_C_FLAGS="-O2 -fno-strict-aliasing -fwrapv" \
  -DCMAKE_CXX_FLAGS="-O2 -fno-strict-aliasing -fwrapv"
make -j"$(nproc)"
```
命令执行完成后，当前目录为 `jsnark/libsnark/build`。请找到位于 `libsnark/jsnark_interface` 目录下的可执行文件 `run_ppzksnark`，并将其**复制到 FileDES 目录的 `runtime` 目录下**。

### 编译和安装 FileDES 

在安装完所有软件依赖、Go 语言及 jsnark 之后，即可通过下面的命令对 FileDES 进行编译：

```bash
make debug
```
该命令将构建 FileDES 的所有组件，由于系统基于 Filecoin 开发，组件均以 lotus 开头命名（`lotus`, `lotus-fountain`, `lotus-gateway`, `lotus-miner`, `lotus-seed`, `lotus-shed`, `lotus-stats`, `lotus-wallet` 和 `lotus-worker`）。

---

## 运行与测试 FileDES 

我们在 `scripts_FileDES` 文件夹中提供了几个实用的脚本，以方便快速启动和测试 FileDES。

在部署前，请检查并确认机器的 `9999`、`10000` 和 `10001` 端口处于放通状态且未被占用，FileDES 测试网的搭建依赖这三个端口。

### 测试网部署

部署 FileDES 多节点测试网包含创世节点启动、参数复制、其他节点启动与连接等步骤：

**1. 创世节点启动**

在主节点上运行以下脚本：
```bash
bash scripts_FileDES/genesis_node_start.sh
```
该脚本不仅会启动作为聚合节点的监听任务，还会在目录中生成 `devgen.car` 文件，并在终端输出创世节点的 daemon 和 miner 地址（格式类似于 `/ip4/...`），以及相关的 Miner 状态信息（创世节点 miner ID 固定为 `t01000`）。

**2. 参数复制**
创世节点启动后，需要手动完成以下操作：
- 将生成的 `devgen.car` 文件复制到其他测试机器的 FileDES 目录下。
- 记录创世节点的 daemon 地址和 miner 地址（后续简称 `$gd_address` 和 `$gm_address`）。
- 记录创世节点的 IP 地址（后续简称 `$gIP`）。

**3. 其他节点启动**

将参数复制到其他机器后，运行以下脚本启动节点：
```bash
bash scripts_FileDES/node_start.sh $gd_address $gm_address $gIP
```
该节点将连接至创世节点并自动获取测试代币。终端会输出当前节点的 miner 地址（后续简称 `$nm_address`）及相关信息。

**4. 连接矿工**

在作为 client 的机器上，需手动执行命令连接其他非创世节点的矿工：
```bash
./lotus net connect $nm_address
```
*注：client 本地的 miner 节点在启动时已自动连接。*

### 多版本文件聚合证明测试

当测试网搭建完成后，可按以下流程评估聚合证明的验证时间：

**Step 1: 生成增量文件**

推荐使用 `bsdiff` 命令生成多版本文件的增量补丁。请将生成的增量补丁及初始版本文件统一放置在 `testdata` 目录下。

**Step 2: 文件上传**

通过运行以下脚本将文件分散存储到对应的矿工节点：
```bash
bash scripts_FileDES/file_upload.sh $miner_id_1 $miner_id_2 $miner_id_3
```
*注：`$miner_id` 可通过运行 `./lotus-miner info` 查看。在运行过程中，可以通过 `./lotus-miner sectors list` 监控 FileDES 服务器处理文件的状态。*

**Step 3: 发送聚合证明生成请求**

客户端可通过以下脚本向测试网发送请求：
```bash
bash scripts_FileDES/client_send_aggregate.sh $gIP $agg_range $client_IP
```
参数说明：
- `$gIP`: 创世节点的 IP 地址（本测试固定创世节点为聚合节点）。
- `$agg_range`: 指定聚合的文件版本范围（如输入 `10` 代表对 v1-v10 进行聚合）。
- `$client_IP`: 客户端自身的 IP 地址。

聚合验证的耗时结果最终将记录于 client 所在机器 FileDES 代码目录下，以 `Verify_agg` 开头的文件中。

### 停止运行

测试结束后，可通过以下指令安全停止 FileDES 的运行：
```bash
./lotus-miner stop
./lotus daemon stop
```
停止进程后，还需手动清理/杀死正在监听 `9999`、`10000` 和 `10001` 端口的相关后台脚本。
