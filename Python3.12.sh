#!/bin/bash
# by Linke 2023 临客
#-----可变参数-start-----
# 要编译的python版本
# python的大版本号
py_version=3.12
# python的具体版本号
version=$py_version.0
# 要安装的路径
install_path=/usr/local/python3

#-----可变参数-end-----
 
echo -e ”即将安装python$version”
echo -e ”安装路径为$install_path”
 
# 安装依赖以及升级索引
yum -y install wget xz tar gcc make tk-devel    sqlite-devel zlib-devel readline-devel openssl-devel curl-devel tk-devel gdbm-devel  xz-devel  bzip2-devel libffi-devel
yum groupinstall -y "Development Tools"
yum update -y
 
# 创建安装目录文件夹
sudo mkdir -p $install_path
 
# 下载python
echo -e '正在下载'
# 使用官方网址下载--速度可能比较慢 1
wget https://www.python.org/ftp/python/$version/Python-${version}b4.tar.xz
# 使用国内华为镜像源下载python
# wget https://mirrors.huaweicloud.com/python/$version/Python-$version.tgz
echo -e "正在解压"
# 静默解压
tar -xvJf Python-${version}b4.tar.xz
# 删除压缩包
echo -e "解压完成，删除压缩包"
rm -rf Python-${version}b4.tar.xz
 
echo -e "正在安装"
cd Python-${version}b4
./configure --prefix=$install_path --enable-optimizations
	make j$(nproc) && make j$(nproc) install
 
echo -e "配置软连接"
rm -rf /usr/bin/python$py_version /usr/bin/pip$py_version
ln -sf /usr/local/python3/bin/python3.12 /usr/bin/python3
ln -sf /usr/local/python3/bin/pip3 /usr/bin/pip3

echo -e "安装Python-${version}已完成"
