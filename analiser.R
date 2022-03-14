# install.packages("tidyverse")
# install.packages("unzip")
# install.packages("lubridate")
library(tidyverse)
library(unzip)
library(lubridate)
library(readr)

# Local aonde o projeto esta baixado
# Como estou utilizando windows esse e o path
project_path = 'C://Users//joaov//Documents//Programming//R//challange-r-concepts'

# Nome do arquivo que esta dentro do .zip
file_name = 'Ukraine_Subreddit_Top_Comments.csv'

# Diretorio completo do arquivo
file_full_path = paste(project_path, '//data//', file_name, sep = "")

# Diretorio do arquivo zip
file_zip_path = paste(project_path, '//data.zip', sep = "")

# Diretorio dos dados
file_data_path = paste(project_path, "//data/", sep = "")

# Criando pasta para o arquivo
dir.create(file_data_path, showWarnings = FALSE)

# Descompactando arquivo
unzip(
  file_zip_path, 
  overwrite = TRUE,
  exdir = paste(project_path, "//data", sep = ""))

# Extraindo dados do CSV e tratando
csv_data <- read_csv(file_full_path, 
                col_types = 
                  cols(
                    title = col_character(),
                    score = col_number(),
                    id = col_character(),
                    url = col_character(),
                    comms_num = col_number(),
                    created = col_number(),
                    body = col_character(),
                    timestamp = col_datetime(format = "%Y-%m-%d %H:%M:%S")
                    )
                )

# Apenas selecionando colunas que vamos utilizar
csv_clean <- csv_data %>% 
  select(title, body)

# Posts que tem algum body
body_data <- subset(csv_clean,body!='')
body_data <- subset(body_data,title!='Comment')

# Quantidade de post que tem algum body
nrow(body_data)

# Posts sem body
body_data <- subset(csv_clean,is.na(body))
body_data <- subset(body_data,title!='Comment')

# Quantidade de post que nao tem body
nrow(body_data)



# Comentarios que tem algum valor
comment_data <- subset(csv_clean,title=='Comment')
comment_data <- subset(comment_data,body!='')

# Quantidade total de comentarios com corpo
nrow(comment_data)


# Comentarios que nao tem valor
comment_data <- subset(csv_clean,title=='Comment')
comment_data <- subset(comment_data,body=='')

# Quantidade total de comentarios sem corpo
nrow(comment_data)


## Analises ##


# Titulos que mencionam Russia
ru_posts <- csv_clean %>%
  filter(str_detect(title, "Russia"))

# Titulos que mencionam Ucrania
uk_posts <- csv_clean %>%
  filter(str_detect(title, "Ukrain"))

# Comentarios que mencionam Russia
ru_comments <- csv_clean %>%
  filter(str_detect(body, "Russia"))

# Comentarios que mencionam Ucrania
uk_comments <- csv_clean %>%
  filter(str_detect(body, "Ukrain"))


