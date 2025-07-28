import os
from modelscope import snapshot_download

dist_path = os.path.join(os.path.dirname(__file__), 'models/Qwen/Qwen3-0_6B')
if not os.path.exists(dist_path):
    os.makedirs(dist_path)
model_name = "Qwen/Qwen3-0.6B"

snapshot_download(model_name, local_dir=dist_path)
