

# =========================================
#     build and push docker image
# =========================================

cp ./Dockerfile_rembg ./Dockerfile
docker build -t yeepeekoo/public:ai_rembg .  
