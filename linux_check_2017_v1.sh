#!/bin/bash
echo "��Linuxϵͳ��ȫ���ű���"
echo "��copyright @BCTC www.bctest.com��"
echo "�����ű���Ϊ��ȫ��ƽű���δ�Է��������κ��޸ġ���"
echo ---------------------------------------������ȫ���-----------------------
echo "��ϵͳ�汾��"
uname -a
echo --------------------------------------------------------------------------
echo "��������ip��ַ�ǣ���"
ifconfig | grep --color "\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}"
echo --------------------------------------------------------------------------
echo "��1.Ӧ�Ե�¼����ϵͳ�����ݿ�ϵͳ���û�������ݱ�ʶ�ͼ���"
echo "���鿴�ļ��и��û���״̬����¼����һ��Ϊ�յ��û�������"
echo "��engxz:$1$gSm3LWDj$nhwcJzNceekFLBHVsndmj/:15629:0:99999:7:::��"
echo "�����е�һ��:�͵ڶ���:֮����Ϊ�գ���˵�����ڿտ��"
echo "cat /ect/shadow>>"
cat /etc/shadow
echo --------------------------------------------------------------------------
echo "��2.����ϵͳ�����ݿ�ϵͳ�����û���ݱ�ʶӦ���в��ױ�ð�õ��ص㣬����Ӧ�и��Ӷ�Ҫ�󲢶��ڸ�����"
echo "����/etc/login.defs�鿴������С���Ⱥ���Ч�ڡ�"
echo "��PASS_MAX_DAYS   99999 ���������"
echo "��PASS_MIN_DAYS   0 ���������"
echo "��PASS_MIN_LEN    5 ��С���ȡ�"
echo "��PASS_WARN_AGE   7 ����ʧЧǰ��������ʾ��"
echo "cat /etc/login.defs>>"
more /etc/login.defs | grep -E "PASS_MAX_DAYS"
more /etc/login.defs | grep -E "PASS_MIN_DAYS"
more /etc/login.defs | grep -E "PASS_MIN_LEN"
more /etc/login.defs | grep -E "PASS_WARN_AGE"
echo "�����ӶȲ��Բ鿴����root��Ч����"
echo "���ҵ� password requisite pam_cracklib.so�����£���"
echo "��password  requisite pam_cracklib.so retry=5  difok=3 minlen=10 ucredit=-1 lcredit=-3 dcredit=-3 dictpath=/usr/share/cracklib/pw_dict��"
echo "���������壺���Դ�����5��"
echo "�����ٲ�ͬ�ַ���3��"
echo "����С���볤�ȣ�10��"
echo "�����ٴ�д��ĸ��1��"
echo "������Сд��ĸ��3��"
echo "���������֣�3��"
echo "�������ֵ䣺/usr/share/cracklib/pw_dict��"
echo "more /etc/pam.d/system-auth | grep pam_cracklib.so>>"
more /etc/pam.d/system-auth | grep pam_cracklib.so
echo "more /etc/pam.d/password | grep pam_cracklib.so>>"
more /etc/pam.d/password | grep pam_cracklib.so
echo --------------------------------------------------------------------------
echo "��3.Ӧ���õ�¼ʧ�ܴ����ܣ��ɲ�ȡ�����Ự�����ƷǷ���¼�������Զ��˳��ȴ�ʩ��"
echo "��SSHԶ�̵�¼ʧ�ܴ�������"
echo "cat /etc/pam.d/sshd | grep pam_tally.so>>"
echo "��Ԥ�ڽ������auth���·���auth required pam_tally.so deny=5 unlock_time=600 no_lock_time ��account���·���account required pam_tally.so��"
cat /etc/pam.d/sshd | grep pam_tally.so
echo "�����ص�¼ʧ�ܴ������ƣ���"
echo "������account required /lib/security/pam_tally.so deny=3 no magic_root reset��"
echo "cat /etc/pam.d/system-auth | grep pam_tally.so>>"
cat /etc/pam.d/system-auth | grep pam_tally.so
echo "�����ߴ���auth required pam_env.so��"
echo "��auth required pam_tally2.so even_deny_root deny=3 unlock_time=120ʧ�����κ�����120�롿"
echo "�����У������ڵڶ��С�"
echo "cat /etc/pam.d/system-auth | grep pam_env.so>>"
cat /etc/pam.d/system-auth | grep pam_env.s
echo "���鿴SSH�Ƿ������������ԵĴ�����"
echo "cat /etc/ssh/sshd_config | grep MaxAuthTries>>"
cat /etc/ssh/sshd_config | grep MaxAuthTries
echo --------------------------------------------------------------------------
echo "��4.���Է���������Զ�̹���ʱ��Ӧ��ȡ��Ҫ��ʩ����ֹ������Ϣ�����紫������б�������"
echo "���Ƿ�����SSH����"
echo "service ssh status>>"
service sshd status
echo "���Ƿ�����Telnet����"
echo "service telnet status>>"
service telnet status
echo "���Ƿ����Telnet����:disable yes��"
echo "cat /etc/xinetd.d/telnet>>"
cat /etc/xinetd.d/telnet
echo --------------------------------------------------------------------------
echo "��5.ӦΪ����ϵͳ�����ݿ�ϵͳ�Ĳ�ͬ�û����䲻ͬ���û�����ȷ���û�������Ψһ�ԡ�"
echo "���鿴/etc/passwd���û����������룬�������UID�����ܴ���ͬ����UID��UIDΪ0��ֻ��root����"
cat /etc/passwd
echo --------------------------------------------------------------------------
echo "��7.Ӧ���÷��ʿ��ƹ��ܣ����ݰ�ȫ���Կ����û�����Դ�ķ��ʡ���"
echo "������ԭ���������ļ����ܴ���(644)����ִ���ļ����ܴ���(755)��"
echo "ls -l /etc/passwd>> (644)��"
ls -l /etc/passwd
echo "ls -l /etc/shadow>> (400)��"
ls -l /etc/shadow
echo "ls -l /etc/xinetd.conf>> (600)��"
ls -l /etc/xinetd.conf
echo "ls -l /etc/group>> (644)��"
ls -l /etc/group
echo "ls -l /etc/security>> (600)��"
ls -l /etc/security
echo "���鿴Ȩ�޹�����ļ���"
echo "find / -perm 777��"
find / -perm 777
echo "���鿴����SUID���Ե��ļ���"
echo "find / -perm -4000��"
find / -perm -4000
echo "���鿴����SGID���Ե��ļ���"
echo "find / -perm -2000��"
find / -perm -2000
echo --------------------------------------------------------------------------
echo "��8.Ӧ���ݹ����û��Ľ�ɫ����Ȩ�ޣ�ʵ�ֹ����û���Ȩ�޷��룬����������û��������СȨ�ޡ�"
echo "�������û������ڶ����˻��� �û�Ȩ��ʵ�ֲ����ڶ���Ȩ�ޣ�ֻ��root�û�uidΪ0����"
awk -F":" '{if($2!~/^!|^*/){print "("$1")" " ��һ��δ���������˻��������Ա����Ƿ���Ҫ����������ɾ������"}}' /etc/shadow
echo "���鿴passwd�ļ�������Щ��Ȩ�û���"
awk -F: '$3==0 {print $1}' /etc/passwd
echo "���鿴ϵͳ��root�û����������"
lsof -u root |egrep "ESTABLISHED|SYN_SENT|LISTENING��"
echo "����ֹ��wheel���û��л���root��"
echo "��auth required /lib/security/$ISA/pam_wheel.so use_uid �ҵ����в�ȥ�����׵�#��"
echo "cat /etc/pam.d/su | grep wheel>>"
cat /etc/pam.d/su | grep wheel
echo "cat /etc/login.defs | grep SU_WHEEL_ONLY>>"
cat /etc/login.defs | grep SU_WHEEL_ONLY
echo "���鿴�Ƿ��ֹrootֱ�ӵ�¼��"
echo "cat /etc/ssh/sshd_config | grep PermitRootLogin>>"
cat /etc/ssh/sshd_config | grep PermitRootLogin
echo --------------------------------------------------------------------------
echo "��14.��Ʒ�ΧӦ���ǵ��������ϵ�ÿ������ϵͳ�û������ݿ��û���"
echo "���鿴syslog��audit��־�����Ƿ�����"
echo "��Ԥ�ڽ����syslogd (pid 3451) ��������...��"
echo "��rsyslogd(pid 1699) ��������...��"
echo "��auditd (pid 3427) ��������...��"
echo "service syslog status>>"
service syslog status
echo "service rsyslog status>>"
service rsyslog status
echo "service auditd status>>"
service auditd status
echo "���鿴��ȫ����ػ������Ƿ�������"
echo "ps �Cef | grep auditd>>"
ps �Cef | grep auditd
echo "ps �Cef | grep syslogd>>"
ps �Cef | grep syslogd
echo --------------------------------------------------------------------------
echo "��15.�������Ӧ������Ҫ�û���Ϊ��ϵͳ��Դ���쳣ʹ�ú���Ҫϵͳ�����ʹ�õ�ϵͳ����Ҫ�İ�ȫ����¼���"
echo "��16.��Ƽ�¼Ӧ�����¼������ڡ�ʱ�䡢���͡������ʶ�������ʶ�ͽ���ȡ�"
echo "cat /etc/audit/audit.conf>>"
cat /etc/audit/audit.conf
echo "cat /etc/rsyslog.conf>>"
cat /etc/rsyslog.conf
echo "cat /etc/syslog.conf>>"
cat /etc/syslog.conf
echo --------------------------------------------------------------------------
echo "��22.Ӧ�ܹ���⵽����Ҫ�������������ֵ���Ϊ���ܹ���¼���ֵ�ԴIP�����������͡�������Ŀ�ġ� ������ʱ�䣬���ڷ������������¼�ʱ�ṩ������"
echo "���鿴�Ƿ�����iptable����ǽ�������������Ʋ�������ȷ������ǽ����ʹ��ȱʡ���á�"
echo "service iptables status>>"
service iptables status
echo "iptables --list>>"
iptables --list
echo --------------------------------------------------------------------------
echo "��24.����ϵͳӦ��ѭ��С��װ��ԭ�򣬽���װ��Ҫ�������Ӧ�ó��򣬲�ͨ�����������������ȷ�ʽ�� ��ϵͳ������ʱ�õ����¡�"
echo "���鿴�������еķ���"
echo "service --status-all | grep -E "running|start|+">>"
echo "���鿴�Ƿ����Σ�յķ���,��echo��shell��login��finger��r��,���߷Ǳ�Ҫ�ķ�����talk��ntalk��pop-2��sendmail��imapd��ftp��pop3�ȡ�"
service --status-all | grep -E "running|start|+"
echo "���鿴�Ƿ�����������ļ���"
echo "find / -nouser>>"
find / -nouser
echo --------------------------------------------------------------------------
echo "��28.Ӧͨ���趨�ն˽��뷽ʽ�������ַ��Χ�����������ն˵�¼��"
echo "���鿴 /etc/hosts.deny�洢���н�ֹ���ʱ�����IP��"
echo "���鿴 /etc/hosts.allow�洢����������ʱ�����IP��"
echo "����һ��:�Ƿ����ǰ��û��#��ALL:ALL��"
echo "���ڶ���:�Ƿ��������ip���������ȡ�"
echo "����:sshd: 192.168.1.10/255.255.255.0��"
echo "cat /etc/hosts.deny>>"
cat /etc/hosts.deny
echo "cat /etc/hosts.allow>>"
cat /etc/hosts.allow
echo --------------------------------------------------------------------------
echo "��29.Ӧ���ݰ�ȫ�������õ�¼�ն˵Ĳ�����ʱ������"
echo "���鿴/etc/profile�Ƿ�����:TIMEOUT = 600 �롿"
echo "cat /etc/profile | grep -E "TMOUT">>"
cat /etc/profile | grep -E "TMOUT"
echo --------------------------------------------------------------------------
echo "��30.Ӧ����Ҫ���������м��ӣ��������ӷ�������CPU��Ӳ�̡��ڴ桢�������Դ��ʹ�������"
echo "���˽�ϵͳ�˻�����Դ����������鿴������������ռ���������"
echo "df �Ck>>"
df -k
echo --------------------------------------------------------------------------
echo "��31.Ӧ���Ƶ����û���ϵͳ��Դ��������Сʹ���޶ȡ�"
echo "���鿴/etc/security/limits.conf �еĲ���nproc����������������"
echo "��soft    nproc   2047 ���̵������Ŀ��"
echo "��hard    nproc   16384��"
echo "��soft    nofile  1024 ���ļ��������Ŀ��"
echo "��hard    nofile  65536��"
echo "���鿴�Ƿ���@student �C maxlogins 1�������ã����ִ�����û���ͬʱ��¼�ĸ�����"
echo "cat /etc/security/limits.conf>>"
cat /etc/security/limits.conf
echo --------------------------------------------------------------------------