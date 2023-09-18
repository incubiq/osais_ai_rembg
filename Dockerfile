##
##      To build the AI_REMBG docker image
##

FROM yeepeekoo/public:ai_rembg_

# keep ai in its directory
RUN mkdir -p ./ai
RUN chown -R root:root ./ai
COPY ./ai/rembg ./ai/rembg
COPY ./ai/rembg.py ./ai/rembg.py

# install AI
WORKDIR /src/app/ai
RUN pip install rembg
WORKDIR /src/app

# push again the base files
COPY ./_temp/static/* ./static
COPY ./_temp/templates/* ./templates
COPY ./_temp/osais.json .
COPY ./_temp/main_fastapi.py .
COPY ./_temp/main_flask.py .
COPY ./_temp/main_common.py .

COPY ./_temp/osais_auth.py .
COPY ./_temp/osais_config.py .
COPY ./_temp/osais_inference.py .
COPY ./_temp/osais_main.py .
COPY ./_temp/osais_pricing.py .
COPY ./_temp/osais_s3.py .
COPY ./_temp/osais_training.py .
COPY ./_temp/osais_utils.py .

# copy OSAIS -> AI
COPY ./ai/runai.py ./ai/runai.py
COPY ./_input/warmup.jpg ./_input/warmup.jpg
COPY ./rembg.json .

# overload config with those default settings
ENV ENGINE=rembg

# run as a server
CMD ["uvicorn", "main_fastapi:app", "--host", "0.0.0.0", "--port", "5002"]
