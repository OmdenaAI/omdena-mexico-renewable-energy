##Consumption
require(tidyverse)


###Load avg_consumption data###
avg_consumption <- read_csv("avg_consumption.csv",col_types =
                              list(`Cve Inegi` = col_character(),
                                   `Cve Mun` = col_character(),
                                   `Entidad Federativa` = col_character(),
                                   Municipio = col_character(),
                                   Tarifa = col_character(),
                                   mean_consum = col_double()))


###Build a unique key for every Municipio##
avg_consumption$Mun_key<-paste(avg_consumption$`Cve Inegi`,avg_consumption$`Cve Mun`)


#erase a whitespace betweeen digits
require(stringr)
avg_consumption$Mun_key<-str_replace_all(avg_consumption$Mun_key,fixed(" "), "")


###Estimate the average consumption for each municipio###
avg_consumption2<-avg_consumption%>%
  group_by(Municipio) %>% 
  summarise(Mun_key=unique(Mun_key),
            `Entidad Federativa`=unique(`Entidad Federativa`),
            `Cve Inegi`=unique(`Cve Inegi`),
            mean_consum_kwh=mean(mean_consum)) %>% 
  arrange(by=`Cve Inegi`,Mun_key)

#Save the csv file
write_csv(avg_consumption2,"mean_consumption_2017.csv")
