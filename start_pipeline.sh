## File for starting pipeline without dvc (Please use DVC this is only for initial experimentation)
config_id=$1
echo $config_id 

##The above DVC pipeline does not work without specifying the dependencies/outputs. 
## In the case that you would like to experiment before adding DAG inputs and outputs use this shell script as a substitute to start_pipeline_dvc.sh. 
python ./competition_code/make_dataset.py --config_id ${config_id}
python ./competition_code/create_features.py --config_id ${config_id}
python ./competition_code/train_model.py --config_id ${config_id}
python ./competition_code/model_serving.py --config_id ${config_id}