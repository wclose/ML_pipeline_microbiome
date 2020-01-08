# Snakefile
# William L. Close
# Schloss Lab
# University of Michigan

# Purpose: Snakemake workflow for controlling ML microbiome pipeline

# # Path to config if needed
# configfile: "../../config/config.yaml"

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
		data="test/data/small_input_data.csv",
		hyper="test/data/hyperparams.csv"
	params:
		model="Decision_Tree",
		seed=1,
		outcome="dx"
	output:
		results="test.txt",
	conda:
		"envs/ml.yaml"
	shell:
		"Rscript {input.script} --seed {params.seed} --model {params.model} --data  {input.data} --hyperparams {input.hyper} --outcome {params.outcome}"


