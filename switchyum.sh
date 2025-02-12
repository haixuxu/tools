#!/bin/bash

# 备份原有的repo配置文件
backup_repos() {
    echo "备份现有的YUM源配置..."
    sudo cp -r /etc/yum.repos.d /etc/yum.repos.d.backup
}

# 启用指定源并禁用其他源
enable_repo() {
    local repo_name=$1
    echo "启用 $repo_name 镜像源..."

    # 遍历所有源，禁用其他源并启用选定的源
    for repo_file in /etc/yum.repos.d/*.repo; do
        sudo sed -i "s/^enabled=1/enabled=0/" "$repo_file"
    done

    # 启用选定的源
    sudo sed -i "s/^enabled=0/enabled=1/" "/etc/yum.repos.d/$repo_name.repo"
}

# 显示可选的镜像源
show_repos() {
    echo "请选择镜像源："
    echo "1. 官方源"
    echo "2. 阿里云镜像"
    echo "3. 清华大学镜像"
    echo "4. 网易镜像"
    echo "5. 退出"
}

# 配置镜像源
setup_repos() {
    echo "配置镜像源..."
    
    # 创建并配置官方源
    sudo bash -c 'cat > /etc/yum.repos.d/fedora.repo <<EOF
# 官方源
[fedora]
name=Fedora \$releasever - \$basearch
baseurl=https://download.fedoraproject.org/pub/fedora/linux/releases/\$releasever/Everything/\$basearch/os/
enabled=0
gpgcheck=1
gpgkey=https://download.fedoraproject.org/pub/fedora/linux/releases/\$releasever/Everything/\$basearch/os/RPM-GPG-KEY-fedora-\$releasever-\$basearch

[updates]
name=Fedora \$releasever - \$basearch - Updates
baseurl=https://download.fedoraproject.org/pub/fedora/linux/updates/\$releasever/Everything/\$basearch/
enabled=0
gpgcheck=1
gpgkey=https://download.fedoraproject.org/pub/fedora/linux/updates/\$releasever/Everything/\$basearch/RPM-GPG-KEY-fedora-\$releasever-\$basearch
EOF'

    # 创建并配置阿里云源
    sudo bash -c 'cat > /etc/yum.repos.d/fedora-aliyun.repo <<EOF
# 阿里云镜像
[fedora-aliyun]
name=Fedora \$releasever - \$basearch - Aliyun
baseurl=https://mirrors.aliyun.com/fedora/releases/\$releasever/Everything/\$basearch/os/
enabled=0
gpgcheck=1
gpgkey=https://mirrors.aliyun.com/fedora/releases/\$releasever/Everything/\$basearch/os/RPM-GPG-KEY-fedora-\$releasever-\$basearch

[updates-aliyun]
name=Fedora \$releasever - \$basearch - Updates - Aliyun
baseurl=https://mirrors.aliyun.com/fedora/updates/\$releasever/Everything/\$basearch/
enabled=0
gpgcheck=1
gpgkey=https://mirrors.aliyun.com/fedora/updates/\$releasever/Everything/\$basearch/RPM-GPG-KEY-fedora-\$releasever-\$basearch
EOF'

    # 创建并配置清华大学源
    sudo bash -c 'cat > /etc/yum.repos.d/fedora-tsinghua.repo <<EOF
# 清华大学镜像
[fedora-tsinghua]
name=Fedora \$releasever - \$basearch - Tsinghua University
baseurl=https://mirrors.tuna.tsinghua.edu.cn/fedora/releases/\$releasever/Everything/\$basearch/os/
enabled=0
gpgcheck=1
gpgkey=https://mirrors.tuna.tsinghua.edu.cn/fedora/releases/\$releasever/Everything/\$basearch/os/RPM-GPG-KEY-fedora-\$releasever-\$basearch

[updates-tsinghua]
name=Fedora \$releasever - \$basearch - Updates - Tsinghua University
baseurl=https://mirrors.tuna.tsinghua.edu.cn/fedora/updates/\$releasever/Everything/\$basearch/
enabled=0
gpgcheck=1
gpgkey=https://mirrors.tuna.tsinghua.edu.cn/fedora/updates/\$releasever/Everything/\$basearch/RPM-GPG-KEY-fedora-\$releasever-\$basearch
EOF'

    # 创建并配置网易源
    sudo bash -c 'cat > /etc/yum.repos.d/fedora-netease.repo <<EOF
# 网易镜像
[fedora-netease]
name=Fedora \$releasever - \$basearch - NetEase
baseurl=https://mirrors.163.com/fedora/releases/\$releasever/Everything/\$basearch/os/
enabled=0
gpgcheck=1
gpgkey=https://mirrors.163.com/fedora/releases/\$releasever/Everything/\$basearch/os/RPM-GPG-KEY-fedora-\$releasever-\$basearch

[updates-netease]
name=Fedora \$releasever - \$basearch - Updates - NetEase
baseurl=https://mirrors.163.com/fedora/updates/\$releasever/Everything/\$basearch/
enabled=0
gpgcheck=1
gpgkey=https://mirrors.163.com/fedora/updates/\$releasever/Everything/\$basearch/RPM-GPG-KEY-fedora-\$releasever-\$basearch
EOF'
}

# 清理并刷新缓存
clean_and_refresh_cache() {
    echo "清理dnf缓存..."
    sudo dnf clean all

    echo "刷新YUM源..."
    sudo dnf makecache
}

# 主菜单
main_menu() {
    while true; do
        show_repos
        read -p "请输入选项 (1-5): " choice

        case $choice in
            1)
                enable_repo "fedora"
                ;;
            2)
                enable_repo "fedora-aliyun"
                ;;
            3)
                enable_repo "fedora-tsinghua"
                ;;
            4)
                enable_repo "fedora-netease"
                ;;
            5)
                echo "退出程序"
                break
                ;;
            *)
                echo "无效的选项，请重新选择"
                ;;
        esac

        # 清理并刷新缓存
        clean_and_refresh_cache
    done
}

# 显示可选的镜像源
show_repos() {
    echo "请选择镜像源："
    echo "1. 官方源"
    echo "2. 阿里云镜像"
    echo "3. 清华大学镜像"
    echo "4. 网易镜像"
    echo "5. 退出"
}

# 脚本开始
backup_repos
setup_repos
main_menu

