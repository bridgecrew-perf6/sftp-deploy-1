#!/bin/sh -l

#set -e at the top of your script will make the script exit with an error whenever an error occurs (and is not explicitly handled)
set -eu


TEMP_SSH_PRIVATE_KEY_FILE='../private_key.pem'
TEMP_SFTP_FILE='../sftp'

# keep string format
printf "%s" "$4" >$TEMP_SSH_PRIVATE_KEY_FILE
# avoid Permissions too open
chmod 600 $TEMP_SSH_PRIVATE_KEY_FILE

if test $7 = "true"; then
  echo "Connection via sftp protocol only, skip the command to create a directory"
else
  echo 'ssh start'

  ssh -o StrictHostKeyChecking=no -p $3 -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2 mkdir -p $6
fi

echo 'sftp start'
# create a temporary file containing sftp commands

printf "%s" "put ./app/* /var/www/api/app/" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "put ./bootstrap/* /var/www/api/bootstrap/" >$TEMP_SFTP_FILE 
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "put ./config/* /var/www/api/config/" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "put ./database/* /var/www/api/database/" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "put ./development_files/* /var/www/api/development_files/" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "put ./public/* /var/www/api/public/" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "put ./resources/* /var/www/api/resources/" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "put ./routes/* /var/www/api/routes/" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "put ./tests/* /var/www/api/tests/" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "put composer.json /var/www/api/composer.json" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "put composer.lock /var/www/api/composer.lock" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "put docker-compose.yml /var/www/api/docker-compose.yml" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "put Dockerfile /var/www/api/Dockerfile" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "put server.php /var/www/api/server.php" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

php artisan migrate


#printf "%s" "put -r $5 $6" >$TEMP_SFTP_FILE
#-o StrictHostKeyChecking=no avoid Host key verification failed.

echo 'deploy success'
exit 0

