# sirius-lerobot

Этот репозиторий был составлен командой студентов НТУ "Сириус" как точка входа для начинающих изучать физический ИИ. Как говорится enjoy :)

## Установка оборудования

Конкретно этот репозиторий предназначен для работы с SO-101. Инструкция по сборке вашего робота находится в замечательной документации lerobot, которая находится [здесь](https://huggingface.co/docs/lerobot/so101)

Для работы вам понадобится **4** USB-порта: два для роботов (ведущего, leader и ведомого, follower) и два для камеры. Первая камера должна быть установлена сверху сцены, вторая спереди-сверху (см. фото или видео).

После сборки вашего робота и настройки USB-подключений необходимо определить *через какие порты* модель и скрипты будут взаимодействовать с роботами и камерами.

> [!NOTE] 
> Все следующие скрипты проверялись на *NIX-подобных системах (MacOS Tahoe и Ubuntu 24.04 LTS), однако на Windows всё тоже должно запуститься :)

Для начала работы необходимо создать виртуальное окружение и склонировать исходники:

```bash
mkdir my-lerobot-test && cd my-lerobot-test
git clone https://github.com/NightyStudios/sirius-lerobot
curl -LsSf https://astral.sh/uv/install.sh | sh 
# uv - это менеджер виртуальных окружений, у них есть своя документация: https://docs.astral.sh/uv/getting-started/installation!
uv venv --python 3.12
```

После этого выполним установку необходимых библиотек:

```bash
source .venv/bin/activate
uv pip install "lerobot[core_scripts,feetech,smolvla]"
```

## Установка софта

Затем давайте определим на каких портах находятся наши роботы и камеры:

```bash
lerobot-find-ports 
# программа попросит вас отключить кабель для одного из роботов и вернет адрес вида /tty/ACM*, запомните для какого робота вы узнаете порт!
lerobot-find-cameras opencv 
# программа сохранит картинки с доступных камер в outputs/, запомните пути к камерам!
```

Вытащим из склонированного репозитория файлы конфигурации:

```bash
mkdir -p ~/.cache/huggingface/lerobot/calibration/robots/so101_follower
mkdir -p ~/.cache/huggingface/lerobot/calibration/teleoperators/so101_leader

cp sirius-lerobot/Файлы\ калибровки/follower.json ~/.cache/huggingface/lerobot/calibration/robots/so101_follower
cp sirius-lerobot/Файлы\ калибровки/leader.json ~/.cache/huggingface/lerobot/calibration/teleoperators/so101_leader
```

После этого подставьте ваши пути для камер в bash-скрипты. В этих же скриптах вы можете указать модели для запуска или использовать наши, которые вы можете найти [тут](https://huggingface.co/sirius-lerobot) :)

```bash
cd bash-скрипты
./launch_teleop.sh # для запуска телеоперации
./launch_record.sh # для записи датасета
./launch_smolvla.sh # для запуска smolvla
./launch_act.sh # для запуска ACT
```

> [!NOTE]
> Ваш пользователь должен быть добавлен в группу `sudo`

**Приятного пользования!**
