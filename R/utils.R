#!/usr/bin/env Rscript

#Useful Functions

writeTable<-function(t,outfile,colname_boolean,rowname_boolean){write.table(t,outfile,quote=F,row.names=rowname_boolean,col.names=colname_boolean,sep="\t")}

'%!in%' <- function(x,y)!('%in%'(x,y))

# Function to display ANSI colors
display_ansi_colors <- function(start = 0, end = 255) {
  if (start < 0 || end > 255 || start > end) {
    stop("Please provide a valid range between 0 and 255.")
  }
  cat("Setup: \\033[38;5;[color]m\n")
  for (i in start:end) {
    cat(paste0("\033[38;5;", i, "m", "Color ", i, "\033[0m\n"))
  }
}

# Call the function to display all colors
# display_ansi_colors()

# Optionally, call the function with a specific range
# display_ansi_colors(28, 47)  # Shades of green


# Install missing packages
install_if_missing <- function(p) {
  if (!require(p, character.only = TRUE)) {
    install.packages(p)
  }
  library(p, character.only = TRUE)
}

# Helper function to save pheatmap to PDF
save_pheatmap_pdf <- function(x, filename, width = 7, height = 7) {
  stopifnot(!missing(x))
  stopifnot(!missing(filename))
  pdf(filename, width = width, height = height)
  grid::grid.newpage()
  grid::grid.draw(x$gtable)
  dev.off()
}