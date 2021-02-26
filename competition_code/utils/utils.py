import yaml


def load_config(config_id):
    with open("config.yml", "r") as f:
        doc = yaml.load(f, yaml.Loader)

    config = doc[config_id]
    return config
