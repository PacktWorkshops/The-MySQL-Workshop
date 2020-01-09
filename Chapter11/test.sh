#!/bin/bash
# https://dev.mysql.com/doc/dev/mysql-server/latest/PAGE_MYSQL_TEST_RUN.html
# Fedora: dnf install mysql-community-test mysql-shell
connect_options="-S /tmp/mysql_sandbox8018.sock -u msandbox -pmsandbox"
mysqlx_uri="root:msandbox@127.0.0.1:18018"

shopt -s nullglob

for f in ch*.sql
do
  echo "=== $f ==="
  if [ ! -e ${f:0:-3}result ]
  then
    opts="-r"
  else
    opts=""
  fi
  mysqltest ${connect_options} --test-file=$f --result-file=${f:0:-3}result ${opts} $*
done

for f in ch*.js
do
  echo "=== $f ==="
  if [ ! -e ${f:0:-2}result ]
  then
    mysqlsh ${mysqlx_uri}  --interactive --result-format=json/raw -f $f 2> /dev/null | egrep '^{' | sed -E 's/[0-9a-f]{28}/<generated_id>/g' > ${f:0:-2}result
  else
    tmp=$(mktemp)
    mysqlsh ${mysqlx_uri}  --interactive --result-format=json/raw -f $f 2> /dev/null | egrep '^{' | sed -E 's/[0-9a-f]{28}/<generated_id>/g' > $tmp
    diff ${f:0:-2}result $tmp && echo ok
  fi
done
