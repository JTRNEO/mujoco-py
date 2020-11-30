# --- Install required libraries ---
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libgl1-mesa-dev \
    libgl1-mesa-glx \
    libglew-dev \
    libosmesa6-dev \
    libxml2-dev \
    libxslt-dev \
    unzip \
    wget

# --- Installing MuJoCo ---
cd /opt
wget https://www.roboti.us/download/mujoco200_linux.zip -O $1/mujoco.zip
unzip $1/mujoco.zip -d $1
rm $1/mujoco.zip

mv $1/mujoco200_linux $1/mujoco200
cp $1/mujoco200/bin/*.so /usr/local/lib/

# --- Installing PatchELF ---
cp $1/mujoco-py/vendor/patchelf_0.9_amd64.elf /usr/local/bin/patchelf
chmod +x /usr/local/bin/patchelf

# --- Installing mujoco-py ---
cp $1/mujoco-py/vendor/Xdummy /usr/local/bin/Xdummy
chmod +x /usr/local/bin/Xdummy

mkdir -p /usr/share/glvnd/egl_vendor.d/
cp $1/mujoco-py/vendor/10_nvidia.json /usr/share/glvnd/egl_vendor.d/10_nvidia.json

cd $1/mujoco-py && python3 -m pip install --no-cache-dir -r requirements.txt
cd $1/mujoco-py && python3 -m  pip install --no-cache-dir -r requirements.dev.txt
cd $1/mujoco-py && python3 setup.py build install

rm $1/mjkey.txt  # Don't need the key anymore.