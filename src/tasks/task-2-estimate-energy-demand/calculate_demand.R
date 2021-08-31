# Script to calculate demand consumption from consumption data and 
# population for 2020
# Created: 29th July 2021
# Modified in: 29th July 2021

library(tidyverse)
library(magrittr)

# Read mean_ consumption_2017 dataset
data <- read_csv('mean_consumption_2017.csv')
head(data)
dim(data)

# Read 2020 population dataset
pop <- read_csv('population data/population_by_municipio_2020.csv')
head(pop)
dim(pop)

# Merge datasets
cons_pop <- merge(data, pop, by.x  = 'Mun_key', by.y = 'key')
cons_pop %<>% 
  select(-c('Municipio', 'Entidad Federativa', 'Cve Inegi')) %>%
  rename('key' = 'Mun_key', 'population' = 'poblacion')

# Calculate demand
cons_pop %<>%
  mutate(demand = mean_consum_kwh/population)

# Reorder columns
col_order <- c('key', 'entidad_federativa', 'municipio', 'mean_consum_kwh',
               'population', 'demand')
cons_pop <- cons_pop[col_order]

# Output
write.csv(cons_pop, 'demand.csv')
