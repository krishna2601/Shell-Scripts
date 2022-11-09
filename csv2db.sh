#Extracts data from /etc/passwd file into a CSV file.
#extract phase
echo "Extracting data"

cut -d":" -f1,3,6 /etc/passwd > extracted_data.txt

#Transform phase
tr ":" "," < extracted_data.txt > transformed_data.csv

#Load Phase
echo "Loading data"

#Connect with postgres database table and copy the file to the table 'users' through command pipeline
echo "\c template1;\COPY users FROM '/home/project/transformed_data.csv' DELIMITERS ',' CSV;" | psql --username=postgres --host=localhost

