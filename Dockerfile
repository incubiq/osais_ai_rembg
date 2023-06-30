##
##      To build the AI_PING docker image
##

# base stuff
FROM yeepeekoo/public:ai_base_osais

# install model
RUN mkdir -p /root/.u2net && curl -o /root/.u2net/u2net.onnx -L https://github.com/danielgatis/rembg/releases/download/v0.0.0/u2net.onnx

# install requirements
COPY ./ai/requirements.txt .
RUN pip install -r requirements.txt

# keep ai in its directory
RUN mkdir -p ./ai
RUN chown -R root:root ./ai
COPY ./ai ./ai

# install AI
WORKDIR /src/app/ai
RUN pip install rembg
WORKDIR /src/app

# copy OSAIS -> AI
COPY ./rembg.json .
COPY ./_rembg.py .

# overload config with those default settings
ENV ENGINE=rembg

# run as a server
CMD ["uvicorn", "main_fastapi:app", "--host", "0.0.0.0", "--port", "5002"]
