from __future__ import absolute_import

import numpy as np
import os

from sagemaker_inference import default_inference_handler, encoder, decoder
from sklearn.externals import joblib

class InferenceHandler(default_inference_handler.DefaultInferenceHandler):

    def default_model_fn(self, model_dir):
        model = joblib.load(os.path.join(model_dir, "model.joblib"))
        return model

    def default_input_fn(self, input_data, content_type):
        np_array = decoder.decode(input_data, content_type)
        return np_array

    def default_predict_fn(self, input_data, model):
        output = model.predict(input_data)
        return np.array(output)

    def default_output_fn(self, prediction, content_type):
        output = encoder.encode(prediction, content_type)
        return output
