# GUI 객체탐지를 위한 메타학습 시 효율적인 초기 가중치 업데이트 방법
## About this codebase
This implementation is built on ultralytics(https://www.ultralytics.com/events/yolovision)
## Datasets used
- WebUI (J. Wu, S. Wang, S. Shen, Y.-H. Peng, J. Nichols, and J. P. Bigham, “WebUI: A Dataset for Enhancing Visual UI Understanding with Web Semantcs,” HCI Institute, arxiv.org/abs/2301.13280, Pittsburgh, USA, 2023.)
- Self made Webscreenshot datasets(not published)
## How to use
### 컨테이너 시작
 - docker-compose.yml 파일 수정
```
git clone https://github.com/hongunjeok/Webui_yolov11.git
    volumes: # 본인의 local 경로로 수정
      - "/home/mmlab/hdd/grad/sscd/sscd/:/user"
      - "/home/mmlab/hdd/dataset:/dataset"
    ports:   # 알맞은 포트 번호로 변경
      - "31400:8000"
      - "31402:22"
```
 - 도커 시작
```
docker-compose up -d
docker attach YOLOv11_new
```
### Library 설치
```
pip install -r reqirements.txt
```
### Methods
It is the efficient learning method of YOLOv11 especially based on WebUI dataset.
*********************************************************************************
1. train
   1) change the cfg/datasets/*.yaml
   2) if you want to train my method, change the trainer(engine/trainer.py) to "maml_trainer.py"
   3) and then type the words 'python train.py' on your command line
   4) if your command line shows the below status, you succeed.(you should see the "Meta-loss" status)
      
    ***************************************************************************************
                Epoch    GPU_mem   box_loss   cls_loss   dfl_loss  Instances       Size
    Epoch 1/1 | Meta-loss: 29.4408:  12%|█▏        | 65/541 [00:31<03:39,  2.17it/s]
    ***************************************************************************************
   5) after that, only 1 epoch will be continued(it contains validation procedures, but you don't need to worry about the score. this step is only used to obtain the pretrained parameters.)
   6) check the pretrained parameters, and let's finetune!(it is demonstrated in https://docs.ultralytics.com/ko/modes/train/)
2. predict
   1) check the "predict.py" and modify some codes.(like datasets, confidence, etc.)
   2) and then type the words 'python predict.py' on your command line.
