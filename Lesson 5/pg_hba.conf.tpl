local   replication     all     peer
local   all     postgres        peer
local   all     all     peer
host    all     postgresuser    samehost        md5
host    replication     all     127.0.0.1/32    md5
host    replication     all     ::1/128 md5
host    all     all     0.0.0.0/0       md5
host    all     all     ::/0    md5