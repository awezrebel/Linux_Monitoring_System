pr_id="$(ps aux | grep 'Linux_User_Monitoring.war' | awk 'NR==1{print $2}')"

echo $pr_id

sudo kill -9 $pr_id

sleep 5

java -jar /home/shaik/webapp-runner-9.0.80.0/webapp-runner/target/webapp-runner.jar /home/shaik/Monitor_Linux/Linux_User_Monitoring.war > application.log &
