script_location=$(pwd)


cp ${script_location}/files/Mongodb.repo /etc/yum.repos.d/mongo.repo

yum install mongodb-org -y

systemctl enable mongod
systemctl start mongod