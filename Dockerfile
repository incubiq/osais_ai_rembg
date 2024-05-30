##
##      To build the AI_REMBG docker image
##

FROM yeepeekoo/public:ai_rembg_


###### update latest OSAIS config (not an absolute requirement) ######

# push again the base files
COPY ./_static/* ./_static
COPY ./_templates/* ./_templates
COPY ./_osais/* .

# copy warmup files
COPY ./_input/warmup.jpg ./_input/warmup.jpg


###### specific AI config (must do) ######

# keep ai in its directory
COPY ./ai ./ai

# overload config with those default settings
ENV ENGINE=rembg

# run as a server
CMD ["uvicorn", "main_fastapi:app", "--host", "0.0.0.0", "--port", "5002"]
