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
		expand("data/temp/best_hp_results_{model}_1.csv",
			model = config["model"])





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
		results=expand("data/temp/best_hp_results_{model}_1.csv",
			model = config["model"])
		# expand("data/process/combined_sensspec_results_{model}.csv",
		# 	model = config["model"])
	conda:
		"envs/ml.yml"
	shell:
		"Rscript {input.script} --seed {params.seed} --model {params.model} --data  {input.data} --hyperparams {input.hyper} --outcome {params.outcome}"


# Add rule for concatenating results
