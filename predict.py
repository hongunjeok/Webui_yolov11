from ultralytics import YOLO

# Load a pretrained YOLO11n model
model = YOLO("best.pt")

# Run inference on 'bus.jpg' with arguments
model.predict(source = "/mldisk2/plentynet/relabelling/test/images/", save=True, imgsz=640, conf=0.25, device = 0)