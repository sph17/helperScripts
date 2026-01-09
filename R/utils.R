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
  if (!requireNamespace(p, quietly = TRUE)) {
    if (p %in% rownames(available.packages())) {
      install.packages(p)
    } else {
      if (!requireNamespace("BiocManager", quietly = TRUE)) {
        install.packages("BiocManager")
      }
      message(paste("Installing", p, "from Bioconductor..."))
      BiocManager::install(p)
    }
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


# Pretty KableExtra
pretty_kable <- function(
    x,
    caption = NULL,
    col.names = NULL,
    align = NULL,
    scroll = FALSE,
    height = "300px"
) {
  if (!requireNamespace("knitr", quietly = TRUE) ||
      !requireNamespace("kableExtra", quietly = TRUE)) {
    stop("Packages 'knitr' and 'kableExtra' are required.")
  }
  kb <- knitr::kable(
    x,
    caption = caption,
    col.names = col.names,
    align = align,
    booktabs = TRUE
  ) |>
    kableExtra::kable_styling(
      full_width = FALSE,
      bootstrap_options = c("striped", "hover", "condensed")
    )
  
  if (scroll) {
    kb <- kb |> kableExtra::scroll_box(height = height)
  }
  
  kb
}

pretty_kable_summary <- function(x, scroll = TRUE, height = "300px", align = NULL,) {
  
  # derive caption from column names
  caption <- paste(colnames(x), collapse = ", ")
  
  pretty_kable(
    x,
    caption = caption,
    scroll = scroll,
    height = height,
    align = align
  )
}

