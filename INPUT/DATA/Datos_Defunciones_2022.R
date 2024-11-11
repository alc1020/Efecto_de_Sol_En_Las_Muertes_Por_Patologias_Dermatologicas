library(readr)
Defunciones_2022 <- read_delim(file = "INPUT/DATA/defunciones_2022 csv.csv",
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)