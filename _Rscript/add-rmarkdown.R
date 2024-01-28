#!/usr/bin/R

# Installing dependencies. This code snippet is form link below
# https://dev.classmethod.jp/articles/r-package-install-ifnotexist/
dependencies <- c('knitr', 'stringr')
notInstalled <- dependencies[!(dependencies %in% installed.packages()[,"Package"])]
if(length(notInstalled)) install.packages(notInstalled, repos = "http://cran.us.r-project.org")
for(package in dependencies) library(package, character.only = T)

library(stringr) # str_detect

# usage function
usage <- function() {
	write("Usage: Rscript ./add-markdown.R targetFile.Rmd hexoBaseDir", stderr())
	write("\ttargetFile.Rmd: RMarkdown File. It must end with '.Rmd'", stderr())
	write("\thexoBaseDir: Hexo base directory (including _config.yml)", stderr())

	write("Description", stderr())
	write("\tRMarkdownをコンパイルする。", stderr())
	write("\t出力では、Hexoのpost-assets-filesに準拠したようにファイルを配置する。", stderr())

	quit(status=1)
}

# Validate Commandline Arguemnts
arguments <- commandArgs(trailingOnly=TRUE)
if (length(arguments) != 2 || !file.exists(arguments[1]) || !str_detect(arguments[1], "\\.Rmd$")) {
	usage()
}
inputFile <- normalizePath(arguments[1])
inputFilenameNoExt <- gsub("\\.Rmd$", "", basename(inputFile))
hexoBaseDir <- normalizePath(arguments[2])

# Compile Rmd on temporal directory
figureFilePrefix <- paste0(inputFilenameNoExt, "_")
outputPath <- paste0(dirname(inputFile), "/", inputFilenameNoExt, ".md")

setwd(dirname(inputFile))
knitr::opts_chunk$set(fig.path = figureFilePrefix)
knitr::knit(inputFile, output=outputPath)
print(paste0('Compiling ', inputFile))

# Move markdown file to hexoBaseDir/source/_posts/
markdownDestPath <- paste0(hexoBaseDir, "/source/_posts/", inputFilenameNoExt, ".md")
file.rename(outputPath, markdownDestPath)
print(paste0(outputPath, ' -> ', markdownDestPath))

# Move Generated Figure files to hexoBaseDir/source/_posts/inputFilenameNoExt/figure.jpg
figureSrcDir <- "./"
figureDestDir <- paste0(hexoBaseDir, "/source/_posts/", inputFilenameNoExt, "/")
dir.create(figureDestDir, showWarnings=F)
figureFiles <- list.files(path=figureSrcDir, pattern=paste0(figureFilePrefix, ".*"), full.names=T)
for (figFile in figureFiles){
	figureDestPath <- paste0(figureDestDir, basename(figFile))
	file.rename(figFile, figureDestPath)
	
	print(paste0(figFile, ' -> ', figureDestPath))
}

