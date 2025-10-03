#!/bin/bash

# Danh sach thay doi
DISABLE_FUNCTIONS="system,passthru,shell_exec,escapeshellcmd,dl,show_source,posix_kill,posix_mkfifo,posix_setpgid,posix_setsid,posix_setuid,posix_setgid,posix_seteuid,posix_setegid,posix_uname"
MAX_EXECUTION_TIME=10000
MAX_INPUT_TIME=10000
MAX_INPUT_VARS=3000
MEMORY_LIMIT="512M"
POST_MAX_SIZE="1024M"
UPLOAD_MAX_FILESIZE="1024M"



echo "Dang cap nhat cho CL php"

if [ -f /etc/cl.selector/global_php.ini ]; then
  cp /etc/cl.selector/global_php.ini /etc/cl.selector/global_php.ini.bak
  echo "Sua file /etc/cl.selector/global_php.ini"
  # Xoa dong cu
  sed -i '/^disable_functions/d' /etc/cl.selector/global_php.ini
  sed -i '/^max_execution_time/d' /etc/cl.selector/global_php.ini
  sed -i '/^max_input_time/d' /etc/cl.selector/global_php.ini
  sed -i '/^max_input_vars/d' /etc/cl.selector/global_php.ini
  sed -i '/^memory_limit/d' /etc/cl.selector/global_php.ini
  sed -i '/^post_max_size/d' /etc/cl.selector/global_php.ini
  sed -i '/^upload_max_filesize/d' /etc/cl.selector/global_php.ini

  # Them dong moi
    {
        echo "max_execution_time = $MAX_EXECUTION_TIME"
        echo "max_input_time = $MAX_INPUT_TIME"
        echo "max_input_vars = $MAX_INPUT_VARS"
        echo "memory_limit = $MEMORY_LIMIT"
        echo "post_max_size = $POST_MAX_SIZE"
        echo "upload_max_filesize = $UPLOAD_MAX_FILESIZE"
        echo "disable_functions = $DISABLE_FUNCTIONS"
    } >> /etc/cl.selector/global_php.ini
fi

if [ -f /etc/cl.selector/php.conf ]; then
  cp /etc/cl.selector/php.conf /etc/cl.selector/php.conf.bak
  echo "Sua file /etc/cl.selector/php.conf"

  sed -i "/^Directive = disable_functions/{n;n;s|^Comment.*|Comment  = $DISABLE_FUNCTIONS|}" /etc/cl.selector/php.conf
fi

echo "Đang cap nhat cho tat ca ea php.ini..."

for ini in /opt/cpanel/ea-php*/root/etc/php.ini; do
  echo "Sua file: $ini"

  # Backup
  cp "$ini" "$ini.bak"

  # Xoa dong cu
  sed -i '/^disable_functions/d' "$ini"
  sed -i '/^max_execution_time/d' "$ini"
  sed -i '/^max_input_time/d' "$ini"
  sed -i '/^max_input_vars/d' "$ini"
  sed -i '/^memory_limit/d' "$ini"
  sed -i '/^post_max_size/d' "$ini"
  sed -i '/^upload_max_filesize/d' "$ini"

  # Them dong moi
  {
        echo "disable_functions = $DISABLE_FUNCTIONS"
        echo "max_execution_time = $MAX_EXECUTION_TIME"
        echo "max_input_time = $MAX_INPUT_TIME"
        echo "max_input_vars = $MAX_INPUT_VARS"
        echo "memory_limit = $MEMORY_LIMIT"
        echo "post_max_size = $POST_MAX_SIZE"
        echo "upload_max_filesize = $UPLOAD_MAX_FILESIZE"
  } >> "$ini"

done

echo "Ap dung cho toan he thong..."
/usr/sbin/cagefsctl --setup-cl-selector

echo "Done!"
