## File for starting dvc pipeline - must use dvc init in project first

## Must specify inputs and outputs to each step for DAG to work correctly- 
## The below DVC template will cover must cases but, Each additional stage in the pipeline must be added to the below template format. 


config_id=$1
echo $config_id 

dvc run -n make_dataset \
        -d ##Add Input Files \
        -o ##Add Output Files \
        "python ./make_dataset.py --config_id ${config_id}"

dvc run -n create_features \
        -d ##Add Input Files \
        -o ##Add Output Files \
        "python ./create_features.py --config_id ${config_id}"

dvc run -n train_model \
        -d ##Add Input Files \
        -o ##Add Output Files \
        "python ./train_model.py --config_id ${config_id}"

dvc run -n model_serving \
        -d ##Add Input Files \
        -m ##Add Output Metrics File which dvc will track\
        "python ./model_serving.py --config_id ${config_id}"
