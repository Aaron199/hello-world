#!/bin/bash
disk_name="/dev/mmcblk0"
avalid_partition_nu="[2-5]"

check_file_name(){
    path=$1
    files=$(ls $path $path/youku | grep -v $path)
    for file in $files
        do
            flag=$(echo $file | grep '^[[:alnum:].]\+$')xx
            if [ "$flag" == 'xx' ];then
            echo ${file} is bad
            return 1
        fi
    done
    return 0
}

umount_partition(){
    mount_point=$(df | grep $disk_name | awk '{print $NF}')
    for point in $mount_point
        do
            echo "Umount $point"
            umount -l $point
    done
}

report(){
    interface="eth0"
    mac=$(ifconfig $interface | grep HWaddr | awk '{print $NF}')
    wget -s http://18066188881.redxunlei.com:8006/log/index.asp?filename="$mac"
}

del_partition(){
    dd if=/dev/zero of=/dev/$disk_name  bs=512 count=1
}
create_one_partition(){
    fdisk $disk_name << EOF
n
p
1


w
EOF
    mkfs.vfat ${disk_name}p1
}
do_somthing(){
    echo "It's going to umount partition"
    #umount_partition
    echo "It's going to delete partitions"
    #del_partition
    echo "It's going to create on partition"
    #create_one_partition
    echo "It's going to report 8066188881.redxunlei.com"
    #report
    echo "It's going to reboot system.."
    #reboot
}


check_mount_point() {
    avalid_mount_point=$(df | grep $disk_name | grep ${avalid_partition_nu}$ |awk '{print $NF}')
    for point in $avalid_mount_point
        do
            if ls $point; then
                check_file_name $point
                if [ $? == '1' ]; then
                    echo 'find bad file'
                    do_somthing
                    break
                fi
            else
                echo "$point is unreadable"
                do_somthing
            fi
        done
}

check_mount_point