## Simple R code to convert platform IDs into appropriate IDs (ie. Ensembl)
## Author: Masrur Alam
## Author's Email: masruralam.bio@gmail.com
## https://github.com/masrur1/BIFS_Hut.git

#Read libraries
library(plyr)
library(reshape)
library(biomaRt)

#Locate and Assign probe set file
import.data=read.table("/path/to/file.csv", sep = ",", stringsAsFactors = F, header = T)

#Establish data frame
import.data <- as.data.frame(import.data)

#Call appropriate mart and dataset type
ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl")

#Define the Affy_IDs that need to be converted
ID_REF <- import.data[1:22626,1]

#Call BM and assign values to ensembl_ID
ensembl_ID <- as.data.frame(getBM(attributes=c("affy_hg_u133a_2", "ensembl_gene_id",
+ "hgnc_symbol"), filters = "affy_hg_u133a_2", values = ID_REF, mart = ensembl),
+ header=TRUE, row.numbers=FALSE, na.rm=TRUE)

#Add column names accordingly
colnames(ensembl_ID) = c("ID_REF", "ensembl_gene_id", "hgnc_symbol") 

#Join the ensembl_ID into the original data frame
results_df <- join(import.data, ensembl_ID)

#Export the following data frame as .csv
write.csv(results_df, file = "data_results.csv")

##  End  ##
