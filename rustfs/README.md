# 部署
官方文档
https://docs.rustfs.com.cn/installation/linux/multiple-node-multiple-disk.html

rustfs部署方式与minio完全相同，两个基本上是同一产品
1. 创建 RustFS 集群必须要使用 相同的、具备连续性 的主机名。可以通过绑定hosts的方式实现
192.168.1.1 rustfs1
192.168.1.2 rustfs2
192.168.1.3 rustfs3
192.168.1.7 rustfs7

2. 最少需要 4台服务器，最低每台服务器需要 1 块磁盘，才可以安全的启动分布式对象存储集群。

官方建议最小四台服务器，每台服务器4块硬盘，以默认 12 + 4 的模式。 一个数据块默认会切分成 12 个数据块 + 4 个校验块，分别存到不同服务器的不同磁盘上。
任何 1 台服务器损坏或者维护都不会影响到数据安全。
任何 4 块磁盘以内的数据损坏都不会影响数据安全。


3. 磁盘格式，官方建议直接将磁盘交给rustfs，可以不用lvs


sudo mkfs.xfs  -i size=512 -n ftype=1 -L RUSTFS0 /dev/sdb
我们可以在格式化时加入一些推荐选项来优化性能:
-L <label>: 为文件系统设置一个标签（label），方便后续识别和挂载。
-i size=512: RustFS官方推荐将inode大小设置为512字节，这对于存储大量小对象（元数据）的场景有性能优势。
-n ftype=1: 开启ftype功能。这允许文件系统在目录结构中记录文件类型，可以提高类似readdir和unlink操作的性能，对RustFS非常有利。

vim /etc/fstab
LABEL=RUSTFS0 /data/rustfs0   xfs   defaults,noatime,nodiratime   0   0

sudo mount -a


4. 更改挂载点路径所有者
rustfs如果采用 docker方式部署需要将目录所有者更改为userid 1000  的用户
如果是二进制部署，需要更改为对应的用户




5.  启动
创建文件夹并更改所有者
 mkdir  -p data/rustfs{1..4}  logs
 chown  1000:1000  -R data logs
必须以正整数，官方中以0开始，0是非负整数，不是正整数, 官方给出的是两个点，必须是三个点,但是使用mkdir创建文件夹的时候要用两个点，容器启动后会有一个文件夹rustfs{1...4}，这是正常现象




