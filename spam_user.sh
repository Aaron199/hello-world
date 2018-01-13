#!/usr/bin/env bash
# @Time    : 2017/10/27 12:01
# @Author  : Aaron_wang
# @Site    : ${SITE}
# @File    : ${NAME}.sh
# @Software: PyCharm
base_dir=$(cd $(dirname $0); pwd)
log_dir="${base_dir}/logs"
if [ ! -e "${log_dir}" ]; then
    mkdir -v ${log_dir}
fi

ch=`date -d '1 hour ago' +%H`
spam_user_file=${log_dir}/spamuser.list
> ${spam_user_file}

mysql="/home/coremail/mysql/bin/mysql"
datasources_file="/home/coremail/conf/datasources.cf"
domain=$(${mysql}\
-u$(head ${datasources_file} |awk -F'"' '/User/{print $2}') \
-p$(head ${datasources_file} |awk -F'"' '/Password/{print $2}') \
-h$(head ${datasources_file} |awk -F'"' '/Server/{print $2}') \
-P$(head ${datasources_file} |awk -F'"' '/Port/{print $2}') \
-D$(head ${datasources_file} |awk -F'"' '/Database/{print $2}') \
-N -s -e "select domain_name from td_domain;"|awk 'BEGIN{ORS=" "}{print $0}'\
)

for c in ${domain}
    do
        awk -F'[(:]' '$3=="'${ch}'"{print $0}' \
        /home/coremail/logs/deliveragent.log \
        |grep "from=<.*@$c>,to=<.*>,channel=remote" \
        |grep -E '(state=bounced|state=defer)'\
        |grep -v rcpttype=auto\
        |awk -F':|,' '{print $7}'|sort |uniq -c \
        | sed -e 's/from=</(state=bounced\/defer) /g;s/>//g' \
        | sort -nr \
        | awk '{if($1 >= 50) print $0}' >> ${spam_user_file}
    done

scan_log=${log_dir}/scan.log
if [  -s "${spam_user_file}" ]; then
    echo -e "`date +%F" "%T`\tHour:${ch}  \t$(cat ${spam_user_file}) Send junk mail." >> ${scan_log}
else
    echo -e "`date +%F" "%T`\tHour:${ch} No User Send junk mail." >> ${scan_log}
    exit 0
fi
spam_user_list=$(awk '{print $3}' ${spam_user_file})
white_user_file=${log_dir}/white_list.txt
if [ ! -e "${white_user_file}" ]; then
    touch ${white_user_file}
    white_user_list=""
else
    if $(egrep -q -v "^\w+@\w+\.\w+$") ${white_user_file}; then
        echo "Error: Please Check white user file: ${white_user_file};"
        exit 1
    else
        white_user_list=$(cat ${white_user_file})
    fi
fi

for white_user in ${white_user_list}
    do
        spam_user_list_valid=$(echo ${spam_user_list}//${white_user}/})
    done

mail_to_spam_user(){
    mail_name=$1
    name=$(echo ${mail_name/@*/})
    msg="Dear ${name}:\n\tYour mailbox is abnormal and has been locked.
     Please contact your email administrator"
    subject="Notice,Your Email has been locked. "
    echo "${msg}" | mail -s "${subject}"  ${mail_name}
}

lock_log=${log_dir}/lock.log
for spam_user in ${spam_user_list_valid}
    do
        status=`/home/coremail/bin/userutil --get-user-attr ${spam_user} 'user_status' \
        | awk -F = '{print $NF}'`
        if [ "${status}" == "0" ]; then
            echo -n -e "`date +%F" "%T`\t" >> ${lock_log}
            mail_to_spam_user ${spam_user}
            wait
            /home/coremail/bin/userutil --set-user-attr ${spam_user} user_status=1 >> ${lock_log}
            echo "/home/coremail/bin/userutil --set-user-attr ${spam_user} user_status=4" | at now + 60min
            echo "${spam_user} will unlock at `date -d@$(expr $(date +%s) + 3600) +%T`" >> ${lock_log}
        fi
    done

cat "$spam_user" | mail -s "Spam_user list" support@sinopharm.com