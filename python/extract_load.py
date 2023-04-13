#import dependencies
import pandas as pd
import os
import numpy as np 
import requests
from datetime import datetime
from datetime import date
from google.cloud import bigquery
import project_args

#connect to BigQuery
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = "credentials.json"
client = bigquery.Client()


def main(project_id, endpoint):
    
    data = requests.get(url=endpoint)
    
    l1_df = pd.DataFrame(data.json())
    print(len(l1_df))

    l1_df.to_gbq(f'{project_id}.l1_tables.311_data', if_exists='replace')
    
    
if __name__ == "__main__":
    main(project_args.args["gcp_project_id"], project_args.args["api_endpoint"] )
    