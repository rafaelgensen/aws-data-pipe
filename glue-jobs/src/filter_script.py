import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.transforms import Filter


## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# Data Source: Reading from S3 
datasource0 = glueContext.create_dynamic_frame.from_catalog(database = "cinema-catalog", table_name = "staging_cinema_data_663354324751", transformation_ctx = "datasource0")

# Transformation: filter specific ticket values
transformed_data = Filter.apply(
    frame=datasource0,
    f=lambda row: row["total_sales"] > 3000000
)

# Data sink: writing data back to s3
datasink0 = glueContext.write_dynamic_frame.from_options(frame = transformed_data, connection_type = "s3", connection_options = {"path": "s3://silver-cinema-data-663354324751/cleaned_data/"}, format = "parquet", transformation_ctx = "datasink0")

job.commit()