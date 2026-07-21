echo "==========Входим в виртуальное окружение=========="
source .venv/bin/activate

echo "Готово"

echo "==========Подключаем права на папки==========="


sudo chown -R $USER:$USER /home/$USER/.cache
sudo chown -R $USER:$USER /dev/ttyACM*

echo "Готово"

echo "==========Устанавливаем переменные среды=========="

export ROBOT_PORT=/dev/ttyACM0 # измени меня!!
export ROBOT_ID=follower
export ROBOT_CALIBRATION_DIR=/home/$USER/.cache/huggingface/lerobot/calibration/robots/so101_follower
export CAMERA_GRIPPER=/dev/video2 # измени меня!
export CAMERA_EXTERNAL=/dev/video4 # измени меня!

echo "Готово"

echo "===========Запускаем инференс чекпоинта=========="
lerobot-rollout --strategy.type=base --policy.path=sirius-lerobot/act_so101_ball_v1 --robot.type=so101_follower --robot.calibration_dir=$ROBOT_CALIBRATION_DIR --robot.port=$ROBOT_PORT --robot.id=$ROBOT_ID --display_data=false --play_sounds=false --fps=15 --task="pick up the ball and place it in the bowl"   --robot.cameras='{
    "wrist": {
      "backend": "V4L2",
      "fourcc": "MJPG",
      "type": "opencv",
      "index_or_path": '"$CAMERA_EXTERNAL"',
      "width": 640,
      "height": 480,
      "fps": 30
    },
    "front": {
      "backend": "V4L2",
      "fourcc": "MJPG",
      "type": "opencv",
      "index_or_path": '"$CAMERA_GRIPPER"',
      "width": 640,
      "height": 480,
      "fps": 30
    }
  }'


