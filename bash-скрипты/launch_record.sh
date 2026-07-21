echo "==========Входим в виртуальное окружение=========="
source .venv/bin/activate

echo "Готово"

echo "==========Подключаем права на папки==========="


sudo chown -R $USER:$USER /home/$USER/.cache
sudo chown -R $USER:$USER /dev/ttyACM*

echo "Готово"

echo "==========Устанавливаем переменные среды=========="

export ROBOT_PORT=/dev/ttyACM0 # поменяй меня!
export ROBOT_ID=follower
export TELEOP_PORT=/dev/ttyACM1 # поменяй меня!
export TELEOP_ID=leader
export TELEOP_CALIBRATION_DIR=/home/roman/.cache/huggingface/lerobot/calibration/teleoperators/so101_leader
export ROBOT_CALIBRATION_DIR=/home/roman/.cache/huggingface/lerobot/calibration/robots/so101_follower
export CAMERA_GRIPPER=/dev/video2 # поменяй меня!
export CAMERA_EXTERNAL=/dev/video4 # поменяй меня!

echo "Готово"

lerobot-record --dataset.repo_id=sirius-lerobot/bowl_so101_pickup_v2 --dataset.single_task="pick up the red bowl and place it in the white bowl" --dataset.num_episodes=100 --dataset.fps=15 --dataset.reset_time_s=10 --dataset.streaming_encoding=true --dataset.encoder_threads=8 --teleop.type=so101_leader --teleop.calibration_dir=$TELEOP_CALIBRATION_DIR --teleop.port=$TELEOP_PORT --teleop.id=$TELEOP_ID --robot.type=so101_follower --robot.calibration_dir=$ROBOT_CALIBRATION_DIR --robot.port=$ROBOT_PORT --robot.id=$ROBOT_ID  --display_data=false --robot.cameras='{
    "wrist": {
      "backend": "V4L2",
      "fourcc": "MJPG",
      "type": "opencv",
      "index_or_path": '"$CAMERA_GRIPPER"',
      "width": 640,
      "height": 480,
      "fps": 30
    },
    "front": {
      "backend": "V4L2",
      "fourcc": "MJPG",
      "type": "opencv",
      "index_or_path": '"$CAMERA_EXTERNAL"',
      "width": 640,
      "height": 480,
      "fps": 30
    }
  }'






