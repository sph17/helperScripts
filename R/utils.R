#!/usr/bin/env Rscript

#Useful Functions

writeTable<-function(t,outfile,colname_boolean,rowname_boolean){write.table(t,outfile,quote=F,row.names=rowname_boolean,col.names=colname_boolean,sep="\t")}

'%!in%' <- function(x,y)!('%in%'(x,y))

# Function to display ANSI colors
display_ansi_colors <- function(start = 0, end = 255) {
  if (start < 0 || end > 255 || start > end) {
    stop("Please provide a valid range between 0 and 255.")
  }
  
  for (i in start:end) {
    cat(paste0("\033[38;5;", i, "m", "Color ", i, "\033[0m\n"))
  }
}

# Call the function to display all colors
display_ansi_colors()

# Optionally, call the function with a specific range
# display_ansi_colors(28, 47)  # Shades of green
