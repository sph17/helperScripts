#!/bin/zsh
# Load conda in a non-interactive shell
eval "$(/opt/homebrew/Caskroom/miniconda/base/bin/conda shell.zsh hook)"
conda activate py312
cd ~/Desktop
jupyter lab
