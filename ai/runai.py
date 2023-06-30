
##
##      REMBG AI
##

import os
import sys
import argparse

sys.path.insert(0, './ai/rembg')
sys.path.insert(0, './ai')

## rembg specifics
from rembg.bg import remove
from rembg.session_factory import new_session
from rembg.sessions import sessions_names
session=new_session("u2net")

def fnRun(_args): 
    vq_parser = argparse.ArgumentParser()

    # OSAIS arguments
    vq_parser.add_argument("-odir", "--outdir", type=str, help="Output directory", default="./_output/", dest='outdir')
    vq_parser.add_argument("-idir", "--indir", type=str, help="input directory", default="./_input/", dest='indir')

    # Add the PING arguments
    vq_parser.add_argument("-filename","--init_image", type=str, help="Initial image", default="clown.jpg", dest='init_image')
    vq_parser.add_argument("-o",    "--output", type=str, help="Output filename", default="output.png", dest='output')

    try:
        args = vq_parser.parse_args(_args)
        print(args)

    except Exception as err:
        print("\r\nCRITICAL ERROR!!!")
        raise err
    
    _pathFileIn=os.path.join(args.indir, args.init_image)
    f = open(_pathFileIn, "rb")
    _fInput=f.read()

    rembg_image=remove(_fInput, session)
    f.close()

    ## include cycle in output name
    basename = args.output.split(".")
    fileOut=basename[0]
    fileExt=basename[1]

    _pathFileOut=os.path.join(args.outdir, fileOut+"_0."+fileExt)
    with open(_pathFileOut, 'wb') as f:
        f.write(rembg_image)

    sys.stdout.flush()

