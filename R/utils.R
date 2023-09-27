#!/usr/bin/env Rscript

#Useful Functions

writeTable<-function(t,outfile,colname_boolean,rowname_boolean){write.table(t,outfile,quote=F,row.names=rowname_boolean,col.names=colname_boolean,sep="\t")}

'%!in%' <- function(x,y)!('%in%'(x,y))