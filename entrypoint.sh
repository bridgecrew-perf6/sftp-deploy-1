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

printf "%s" "mput -R app $6" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "mput -R bootstrap $6" >$TEMP_SFTP_FILE 
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "mput -R config $6" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "mput -R database $6" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "mput -R development_files $6" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "mput -R public $6" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "mput -R resources $6" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "mput -R routes $6" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "mput -R tests $6" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "mput composer.json $6" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "mput composer.lock $6" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "mput docker-compose.yml $6" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "mput Dockerfile $6" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "%s" "mput server.php $6" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

printf "php artisan migrate"


#printf "%s" "put -r $5 $6" >$TEMP_SFTP_FILE
#-o StrictHostKeyChecking=no avoid Host key verification failed.

echo 'deploy success'
exit 0

