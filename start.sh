#!/bin/sh
#ɾ��������
sed -i '/freenom/d' /var/spool/cron/crontabs/root
#��������
echo "$CRON cd /freenom/ && php run > freenom_crontab.log 2>&1">>/var/spool/cron/crontabs/root
# ������������ļ������ڣ��ӱ����и���һ�������ݾ���
if [ ! -f /conf/config.php ]; then
	cp /confbak/config.php /conf/config.php
fi
if [ ! -f /conf/.env ]; then
	cp /confbak/.env /conf/.env
fi
# �����������ӣ�Դ-Ŀ�꣬���ʵ��û����ô����������
if [ ! -f /freenom/config.php ]; then
	ln -s /conf/config.php /freenom/config.php
fi
if [ ! -f /freenom/.env ]; then
	ln -s /conf/.env /freenom/.env
fi
cd /freenom/
php run
crond -f
#��ֹshִ�����Զ��˳���������crond -f ǰ̨���н��
#php -a