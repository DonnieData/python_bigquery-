# python_bigquery-
Using python with Google Cloud Big Query 

#Overview
- create schemas
 - create service account & credentials 
 - update credentials and projectid for python
 - logger
 
 
# 

create datasets in BQ using cloud shell
![image](https://user-images.githubusercontent.com/55963911/228695912-6f823ce9-a5ec-4f6e-9443-aaacd35bfadb.png)


create credential access key for service account and downlaod in json format 

![image](https://user-images.githubusercontent.com/55963911/228696149-2edddd48-ee78-4cd4-8c4f-7da373c830e5.png)

[explanation and preview of key]



connecting python to Google BQ

![image](https://user-images.githubusercontent.com/55963911/228696280-0be8f371-25e8-405c-bf84-377196be0343.png)



GCP Log explorer shows inserjob completed with no errors 
- shows method:pandas nad how data is loaded
![image](https://user-images.githubusercontent.com/55963911/229265673-bab51d35-a30d-46af-bb45-b083cb6d82be.png)

python data 
- retreival 
- main table, downstream tables.metrics 

load into BQ with python 


- ddl/ json for bq table 
- load job for data 
  - cloud storage -> BQ 
- python script to transform data
- google studio visualization 


# Data 
City of Dallas 311 Service Requests: https://www.dallasopendata.com/Services/311-Service-Requests-October-1-2020-to-Present/d7e7-envw


#Dash
https://lookerstudio.google.com/u/2/reporting/25820fbc-2b87-4bad-91bb-1b75f1d7404a/page/nXDGB

