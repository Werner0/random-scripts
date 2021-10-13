# Examples of how to make taxonomic queries to:

# (1) the World Register of Marine Species (WoRMS) for extant species and 
# (2) the Global Biodiversity Information Facility (GBIF) for extinct species

library(taxize)

######################
### EXTANT species ###
######################

#Get taxonomic id
tid <- get_uid("Birgus latro")

#Get all sub-taxons, stopping at the Class taxon
dws <- downstream("Arthropoda", downto = "Class", db = "worms")

#Get taxonomic hierarchy
cls <- classification("Birgus latro", db = "worms")

#######################
### EXTINCT species ###
#######################

#Get taxonomic id
etid <- get_gbifid("Kainops invius")

#Get all sub-taxons, stopping at the Order taxon
edws <- downstream("Trilobita", downto = "Order", db = "gbif")

#Get taxonomic hierarchy
ecls <- classification("Kainops invius", db = "gbif")