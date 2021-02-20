# Competition Template

A competition template repository which makes it easy to kick start a new repository for competition. 

```bash
├── competition_code
│   ├── train_model.py
│   ├── model_serving.py
│   ├── make_dataset.py
│   ├── create_features.py
│   └── __init__.py
├── data
│   ├── validation
│   ├── submissions
│   ├── raw
│   ├── processed
│   ├── mappings
│   └── interim
├── logs_metadata
├── models
├── notebooks
├── .gitignore
├── config.yml
├── docker-compose.yml
├── Dockerfile
├── environment.yml
├── LICENSE
├── README.md

```

# Competition Setup Guide

## Development Env
 1. Create conda environment `competition` with `environment.yml` file.
    ```bash
    conda env create -f environment.yml
    ```
 2. Activate `competition` conda env
    ```bash
    conda activate competition
    ```

To update environment. 
 ```bash
 conda env create --file environment.yml
 ```

## DVC 
 1. To start dvc run the following at the beginning of project. 
      ```bash
    dvc init
    ```
 2. Anytime you train a model be sure to use the start_pipeline.sh script and specify correct inputs and outputs. 

### Docker Setup - For running pipeline 
 1. Build Docker environment from conda  
     
    ```bash
    docker-compose build 
    ```
 2. Run docker container- should start up jupyter automatically
      
    ```bash
    docker-compose up 
    ```
 3. To utilize jupyter environment click the link in the log to be taken to jupyter environment with conda pre-loaded. 
 4. To utilize training pipeline run the following command. 
    
    ```bash
    docker exec -it competition_pipeline /bin/bash 
    ```
 5. To begin an end to end training ensure all data is in data/raw and run the following. - maybe need to allow for loading data from old files in future.
    
    ```bash
    sh start_pipeline.sh 
    ```
### Data Setup 
 1. Add CSV files to data/raw.


