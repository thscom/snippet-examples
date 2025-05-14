import os
from ultralytics import YOLO

if __name__ == '__main__':
    all_files = os.listdir(os.path.join(os.path.dirname(__file__), 'weights'))
    onnx_files = [i for i in all_files if i.endswith('.onnx')]
    pt_files = [i for i in all_files if i.endswith('.pt')]

    for f in onnx_files:
        os.remove(os.path.join(os.path.dirname(__file__), 'weights', f))

    for f in pt_files:
        model_path = os.path.join(os.path.dirname(
            __file__), 'weights', f)
        model = YOLO(model_path)
        ok = model.export(format='onnx', dynamic=True, simplify=True)
        print(f"{f}: {ok}")
