script_location=$(pwd)

LOG=/tmp/roboshop.log
echo -e "\e[35m install nginx\e[0m"
yum install nginx -y &>>${LOG}
if [$? -eq 0 ]; then
  echo SUCESS
else
  echo FAILURE
fi

echo -e "\e[35m remove nginx old content\e[0m"


rm -rf /usr/share/nginx/html/* &>>${LOG}
if [$? -eq 0 ]; then
  echo SUCESS
else
  echo FAILURE
fi

echo -e "\e[35m download frontend content\e[0m"

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
if [$? -eq 0 ]; then
  echo SUCESS
else
  echo FAILURE
fi


cd /usr/share/nginx/html &>>${LOG}

echo -e "\e[35m extract frontend content\e[0m"

unzip /tmp/frontend.zip &>>${LOG}
if [$? -eq 0 ]; then
  echo SUCESS
else
  echo FAILURE
fi

echo -e "\e[35m copy roboshop nginx cofig file\e[0m"


cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
if [$? -eq 0 ]; then
  echo SUCESS
else
  echo FAILURE
fi

echo -e "\e[35m restart nginx\e[0m"

#systemctl restart nginx &>>${LOG}
#echo $?

systemctl enable nginx &>>${LOG}
if [$? -eq 0 ]; then
  echo SUCESS
else
  echo FAILURE
fi
systemctl start nginx &>>${LOG}
if [$? -eq 0 ]; then
  echo SUCESS
else
  echo FAILURE
fi

#echo frontend.sh
