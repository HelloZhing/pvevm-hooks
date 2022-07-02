# pvevm-hooks

#### 介绍

PVE下KVM虚拟机直通钩子脚本<br>
本项目可以让PVE虚拟机直通的核显、声卡、USB控制器，在虚拟机关闭后返回PVE宿主机<br>
实现效果和详细操作说明请查看：<br>
B站视频：https://www.bilibili.com/video/BV1oT41137CU<br>
博客文章：https://zhing.fun/pve_igpupt/<br>


#### 使用说明

克隆本仓库至/root目录<br>
```
git clone https://gitee.com/hellozhing/pvevm-hooks.git
```
添加可执行权限<br>
```
cd pvevm-hooks
chmod a+x *.sh *.pl
```
脚本是基于我的intel B365主板编写的，需要根据你的硬件实际情况对vm-stop.sh中相关内容进行修改<br>
复制perl脚本至snippets目录<br>
```
mkdir /var/lib/vz/snippets
cp hooks-igpupt.pl /var/lib/vz/snippets/hooks-igpupt.pl
```
将钩子脚本应用至虚拟机<br>
```
qm set <VMID> --hookscript local:snippets/hooks-igpupt.pl
```
<br>
如果PVE安装了图形界面<br>
请取消vm-start.sh中$(dirname $0)/vfio-startup.sh该行注释<br>
取消vm-stop.sh中$(dirname $0)/vfio-teardown.sh该行注释


#### 感谢
@ledisthebest<br>
提供的脚本vfio-startup.sh和vfio-teardown.sh<br>
<br>


