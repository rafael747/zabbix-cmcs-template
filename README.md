# zabbix-cmcs-template

Zabbix template for DVB monitoring using cmcs client

## Instalation ##
 
 - Make sure you have **cmcs** client installed and available in PATH
 - Copy/link **cmcstats.sh** to **/usr/local/bin/cmcstats**
 - Fill **IP** and **PW** info in **/usr/local/bin/cmcstats**
 - Copy **cmcstats.conf** to **/etc/zabbix/zabbix_agentd.conf.d/**
 - Restart zabbix-client service

* You can test the script before adding the template to your host

```
   cmcstats SIGS   #to print Signal Strength
   cmcstats SIGL   #to print Signal Lock Status
   cmcstats        #to print all information
```

 ### On Zabbix server
 
 - Import **zbx_cmcs_template.xml** in Zabbix server and add it to your host

