FROM 683313688378.dkr.ecr.us-east-1.amazonaws.com/sagemaker-scikit-learn:0.20.0-cpu-py3

ENV LANG C.UTF-8
ENV LD_LIBRARY_PATH /opt/conda/lib/:$LD_LIBRARY_PATH
ENV PATH /opt/conda/bin:$PATH
ENV SAGEMAKER_SERVING_MODULE /opt/ml/code/serving:main
ENV TEMP /home/model-server/tmp
ENV PYTHONPATH /opt/ml/code/

RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-8-jdk-headless

RUN pip install multi-model-server sagemaker-inference

RUN mkdir -p /opt/ml/code \
    && mkdir -p /opt/ml/output/ \
    && mkdir -p /opt/ml/input/ \
    && mkdir -p /opt/ml/model/

RUN useradd -m model-server \
    && mkdir -p /home/model-server/tmp \
    && chown -R model-server /home/model-server

COPY mms-entrypoint.py /opt/ml/code/dockerd-entrypoint.py
COPY inference_handler.py /opt/ml/code/
COPY handler_service.py /opt/ml/code/
COPY serving.py /opt/ml/code/
COPY __init__.py /opt/ml/code/

COPY config.properties /home/model-server
RUN chmod +x /opt/ml/code/dockerd-entrypoint.py

EXPOSE 8080 8081
WORKDIR /opt/ml/code
ENTRYPOINT ["python", "dockerd-entrypoint.py"]
CMD ["serve"]
