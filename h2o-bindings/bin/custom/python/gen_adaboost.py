def update_param(name, param):
    if name == 'weak_learner_params':
        param['type'] = 'KeyValue'
        param['default_value'] = None
        return param
    return None  # param untouched

options = dict(
)

doc = dict(
    __class__="""
Builds an AdaBoost model
"""
)
