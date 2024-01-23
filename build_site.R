#Set our working directory. 
#This helps avoid confusion if our working directory is 
#not our site because of other projects we were 
#working on at the time. 
## setwd("~/Documents/UNH/classes/TAing/GEN711/GEN711_S21/")
#setwd("/Users/jeffreymiller/Documents/teaching/Gen711/GEN711_S21/")
## setwd("/Users/jeffreymiller/Documents/teaching/Gen711_811/GEN711_S21")
setwd("/Users/jeffreymiller/Documents/teaching/Genomics&Bioinformatics/GEN711_S21/")
#render your sweet site. 
rmarkdown::render_site()

### Miller Notes
## Directory must contain either an "index.Rmd" or "index.md" file.
## Directory must contain a site configuration file ("_site.yml").s