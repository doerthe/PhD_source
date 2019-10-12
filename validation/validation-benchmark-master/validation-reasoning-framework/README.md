# Benchmark Scripts for Validation Reasoning Framework

These scripts will run n3unit using `parallel` to support parallelization of multiple instance of the [validation reasoning framework](https://github.com/IDLabResearch/validation-reasoning-framework) (which is single-threaded).

## Requirements
- `parallel`
- `docker`
- build docker image for the [validation reasoning framework](https://github.com/IDLabResearch/validation-reasoning-framework)
- update update `cache1` folder if outdated

## Usage
Execute `./parallel-run.sh` with the following 3 arguments.
1. number of cores to be used
2. CSV file with information about the different datasets that need to be validated (example ++++)
3. path to file where to save the bechmark results
