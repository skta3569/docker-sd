# https://huggingface.co/CompVis/stable-diffusion-v1-4

import sys

import torch
from torch import autocast
from diffusers import StableDiffusionPipeline

print("generate.py args", sys.argv)

model_id = "CompVis/stable-diffusion-v1-4"
device = "cuda"

pipe = StableDiffusionPipeline.from_pretrained(model_id, torch_dtype=torch.float16, revision="fp16", use_auth_token=sys.argv[2])
pipe = pipe.to(device)

prompt = sys.argv[1]
with autocast("cuda"):
    image = pipe(prompt, guidance_scale=7.5)["sample"][0]  
    
image.save("/output/image.png")
