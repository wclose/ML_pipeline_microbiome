# Snakefile
# William L. Close
# Schloss Lab
# University of Michigan

# Purpose: Snakemake workflow for controlling ML microbiome pipeline

# Path to configfile
configfile: "config/config.yaml"

# Master rule for controlling workflow.
rule all:
	input:
		"test.txt"





##################################################################
#
# Running the Model
#
##################################################################

# Trimming adapters and removing low quality sequences.
rule runModel:
	input:
		script="code/R/main.R",
		data=config["data"],
		hyper=config["hyper"]
	params:
		model=config["model"],
		seed=config["seed"],
		outcome=config["outcome"]
	output:
		results="test.txt",
	conda:
		"envs/ml.yml"
	shell:
		"Rscript {input.script} --seed {params.seed} --model {params.model} --data  {input.data} --hyperparams {input.hyper} --outcome {params.outcome}"


