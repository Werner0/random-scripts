# Script to parse codon code file (gc.prt) from NCBI taxonomy dump 
# Available at https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/new_taxdump/ [30 November 2021]

library(stringr) # toString()
library(data.table) # as.data.table()

# Load codon code file 
gc_text <- scan("taxdump/gc.prt", what = character())

# Remove data from lines prior to EBNF notation
gc_text <- toString(gc_text[which(gc_text == "::="):length(gc_text)][-1])

# Split character string into vector containing a list for each codon usage class
gc_text <- strsplit(str_extract_all(gc_text, "\\{[^{}]+\\}")[[1]], ",")

# Remove leading white spaces
gc_text <- lapply(gc_text, function(x) gsub("^[[:space:]]", "", x))

#Remove newline artifact
gc_text <- lapply(gc_text, function(x) gsub("\\n", "", x))

# Remove empty strings, EBNF notation label ("name") and inconsistent identifiers ("SGCs")
gc_text <- lapply(gc_text, function(x) x[!x == "" & !x == "name" & !x %like% "SGC"])

# Fix incorrect split on comma
gc_text <- lapply(gc_text, function(x) if (x[3]!="id") {
  c(x[1], paste(x[2],x[3], sep = ", "), x[4:length(x)])}
  else x)

# Convert vector of lists to data table
gc_table <- as.data.table(gc_text)

# Assign NCBI identifier as column name
colnames(gc_table) <- paste0("ncbi_codon_code_",as.character(gc_table[4,]))

# Drop remaining redundant data
gc_table <- gc_table[c(2,6,8,11,14,17, 4),]

# Write table to file
#fwrite(gc_table, "parsed_gc.prt.txt", sep = "\t")
