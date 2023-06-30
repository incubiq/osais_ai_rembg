
## REMBG local
##
##   Put yourself in the src directory
##   Run with: uvicorn main:app --host 0.0.0.0 --port 5002
##   Test it : http://localhost:5002/
##

## ------------------------------------------------------------------------
#       Use BASE AI 
## ------------------------------------------------------------------------

import sys
sys.path.insert(0, '../osais_ai_base')
from main_fastapi import app

## For debuging VAI locally ...
## from main_fastapi import initializeApp
## initializeApp("env_vai")
