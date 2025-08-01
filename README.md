## tools

### 包文件查看

```bash
apt-cache policy libc6 #查看当前安装的包版本及可用的包版本
yum install -y yum-utils
repoquery -l packagename  # 查看包文件列表，不需要安装
rpm -ql packagename # 查看包文件列表，需要安装

#To see all the files the package installed onto your system, do this:
dpkg-query -L <package_name>
#To see the files a .deb file will install
dpkg-deb -c <package_name.deb>
#To see the files contained in a package NOT installed, do this once (if you haven't installed apt-file already:
sudo apt-get install apt-file
sudo apt-file update
#then
apt-file list <package_name>
```

### 硬件信息

```bash
lsblk  # Check the blockdevices and the file systems that are assigned to those block device
lshw #list hardware
```

### 批量重命名

```
# rename "fdafdaff-2123123.mp3" ==> "fdafdaff.mp3"
ls|sed -e 'p;s/\-[0-9]\+//' |xargs -n2 echo

ls|grep "少司命"|sed -e 'p;s/^/\.\.\/少司命\//'|xargs -n2 mv

find ./ -name '*.module.scss' -print | rename 's/\.module\.scss/.scss/'

find ./ -name "*.js" |sed -e 'p;s/\.js/.tjs/' | xargs -n2 mv
```

### 批量删除

```
find ./ -name="*.php" -exec rm -v {}\;
```

### 显示 rpm 包列表从大小

```
rpm -qa --queryformat '%10{size} - %-25{name} \t %{version} \t %{os} \n' | sort -rh | head -25 | awk '{print $1/1024/1024, $2, $3, $4}'
```

### 批量文件内容查找－正则替换

[sed](https://unix.stackexchange.com/questions/78625/using-sed-to-find-and-replace-complex-string-preferrably-with-regex)

[参考](https://linuxize.com/post/how-to-use-sed-to-find-and-replace-string-in-files/)

[perl](https://stackoverflow.com/questions/102083/whats-the-best-tool-to-find-and-replace-regular-expressions-over-multiple-files)

[dos2unix](https://en.wikipedia.org/wiki/Unix2dos)

```
sed -i 's/\b[0-9]\{3\}\b/{&}/g' file.txt
perl -pi -e "s/foo/bar/g" file1 file2 file3
```

```
sed -i 's/\b[0-9]\{3\}\b/{&}/g' file.txt
find . -type f -exec sed -i 's/foo/bar/g' {} +
find . -type f -print0 | xargs -0 sed -i 's/foo/bar/g'
find . -type f -not -path '*/\.*' -print0 | xargs -0 sed -i 's/foo/bar/g'
find . -type f -name "*.md" -print0 | xargs -0 sed -i 's/foo/bar/g'
grep -rlZ 'foo' . | xargs -0 sed -i.bak 's/foo/bar/g'
grep -rl "a/assbc" ./ | xargs sed -i 's#a/assbc#vx.csii.com.cn#g'

find /path/to/files -type f -exec sed -i 's/oldstring/new string/g' {} \;
```
