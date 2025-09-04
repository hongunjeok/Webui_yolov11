from ultralytics import YOLO

# 🔹 완전 Scratch Training (Pretrained weights 없이)
# model = YOLO("./last.pt")  # build a new model from YAML (no pretrained weights)]
model = YOLO("yolo11x.yaml")
#model = YOLO("yolo11x.yaml").load("best.pt")

# 🔹 Train from scratch (without pre-trained weights)
results = model.train(
    data="webui_maml.yaml",
    epochs=1,
    batch=6,
    imgsz=1280,
    device=[0, 1],
    copy_paste=1.0,
    copy_paste_mode='paste_in',
    pretrained=False,
    resume=False,
)
