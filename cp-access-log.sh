#extract log data using wget
#download the access log file
wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz" 

#unzip the file to extract .txt file
gunzip -f /home/project/web-server-access-log.txt.gz

#extract phase

echo "Extracting data"

#Extract the columns timestamp, latitude, longitude and visitorid
cut -d"#" -f1-4 web-server-access-log.txt > extracted_data.txt #-d refers to delimiter, > redirects output

#transform phase
#convert # to , and save raw data to csv file

echo "Transforming data"

tr '#', ',' < extracted_data.txt > transformed-data.csv

#loading phase
#connect to psql 'template1' db
#copy the content of transformed-data.csv file to access table
echo "\c template1;\COPY access_log FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost



