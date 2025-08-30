from pyspark.sql import SparkSession

# Inicializar a SparkSession
spark = SparkSession.builder \
    .appName("CinemaTicketCleaner") \
    .getOrCreate()

# Ler o CSV com separador vírgula
df = spark.read.option("header", True).option("sep", ",").csv("cinemaTicket_Ref.csv")

# Remover linhas com valores nulos
df_clean = df.dropna()

# Remover duplicatas
df_clean = df_clean.dropDuplicates()

# Escrever em formato Parquet com compressão Snappy
df_clean.write.mode("overwrite").parquet("clean_cinema.parquet", compression="snappy")