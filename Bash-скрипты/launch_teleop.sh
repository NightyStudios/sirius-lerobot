echo "==========Входим в виртуальное окружение=========="
source .venv/bin/activate

echo "Готово"

echo "==========Подключаем права на папки==========="


sudo chown -R $USER:$USER /home/$USER/.cache
sudo chown -R $USER:$USER /dev/ttyACM*

echo "Готово"

echo "==========Устанавливаем переменные среды=========="

export ROBOT_PORT=/dev/ttyACM0 # измени меня!
export ROBOT_ID=follower
export TELEOP_PORT=/dev/ttyACM1 # измени меня!
export TELEOP_ID=leader
export TELEOP_CALIBRATION_DIR=/home/$USER/.cache/huggingface/lerobot/calibration/teleoperators/so101_leader
export ROBOT_CALIBRATION_DIR=/home/$USER/.cache/huggingface/lerobot/calibration/robots/so101_follower
export CAMERA_GRIPPER=/dev/video2 # измени меня!
export CAMERA_EXTERNAL=/dev/video4 # измени меня! 

echo "Готово"

lerobot-teleoperate \
  --robot.type=so101_follower \
  --robot.port=$ROBOT_PORT \
  --robot.id=$ROBOT_ID \
  --teleop.type=so101_leader \
  --teleop.port=$TELEOP_PORT \
  --teleop.id=$TELEOP_ID \
  --robot.calibration_dir=$ROBOT_CALIBRATION_DIR \
  --teleop.calibration_dir=$TELEOP_CALIBRATION_DIR \
  --display_data=true \
  --robot.cameras='{
    "wrist": {
      "type": "opencv",
      "index_or_path": '"$CAMERA_GRIPPER"',
      "width": 640,
      "height": 480,
      "fps": 30
    },
    "front": {
      "type": "opencv",
      "index_or_path": '"$CAMERA_EXTERNAL"',
      "width": 640,
      "height": 480,
      "fps": 30
    }
  }'





