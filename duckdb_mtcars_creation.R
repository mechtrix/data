library(duckdb)
library(dbplyr)
library(dplyr)

data("mtcars")

duckdb_con <- dbConnect(duckdb())

con <- dbConnect(duckdb(), dbdir = "raw_data/mtcars.duckdb", read_only = FALSE)

dbWriteTable(duckdb_con, "mtcars_table", mtcars)

out <- tbl(duckdb_con,"mtcars_table") |> collect()

dbDisconnect(duckdb_con)
