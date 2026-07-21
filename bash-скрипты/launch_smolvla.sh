
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
export TELEOP_CALIBRATION_DIR=/home/$USER/.cache/huggingface/lerobot/calibration/teleoperators/so101_leader
export ROBOT_CALIBRATION_DIR=/home/$USER/.cache/huggingface/lerobot/calibration/robots/so101_follower
export CAMERA_GRIPPER=/dev/video2 # поменяй меня!
export CAMERA_EXTERNAL=/dev/video4 # поменяй меня!

echo "Готово"

lerobot-rollout --strategy.type=base --robot.type=so101_follower --robot.port=$ROBOT_PORT --robot.id=$ROBOT_ID --robot.calibration_dir=$ROBOT_CALIBRATION_DIR --policy.path=sirius-lerobot/smolvla_bowl_pickup_v2 --task="pick up the red bowl and place it in the white bowl" --fps=10 --inference.type=rtc --inference.rtc.execution_horizon=12 --inference.rtc.max_guidance_weight=10.0 --inference.rtc.prefix_attention_schedule=LINEAR --inference.queue_threshold=40 --interpolation_multiplier=3 --display_data=false --duration=0 --display_data=false --play_sounds=false  --robot.cameras='{
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





