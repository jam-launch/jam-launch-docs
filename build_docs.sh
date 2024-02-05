#!/bin/sh

PDIR=$(dirname $(realpath -s $0))
cd $PDIR

if ! [ -f ./godot ]; then
    (wget https://github.com/godotengine/godot/releases/download/4.2.1-stable/Godot_v4.2.1-stable_linux.x86_64.zip \
    && unzip Godot_v4.2.1-stable_linux.x86_64.zip \
    && mv Godot_v4.2.1-stable_linux.x86_64 godot \
    && rm -rf Godot_v4.2.1-stable_linux* ) || (exit 1)
fi

mkdir -p ./docs/gdscript
./godot --doctool ./docs/gdscript
./godot --doctool ./docs/gdscript/jam_launch --gdscript-docs res://.

python ./tools/make_rst.py -o ./docs/source/classes ./docs/gdscript/doc/classes ./docs/gdscript/doc/platform ./docs/gdscript/modules ./docs/gdscript/jam_launch

for classfile in ./docs/source/classes/*.rst; do sed -i '/:github_url: hide/d' $classfile; done

sed -i '/class_jam/d' ./docs/source/classes/index.rst
sed -i '/class_"addons/d' ./docs/source/classes/index.rst

mv ./docs/source/classes/class_jam* ./docs/source/jam-classes/

sphinx-build ./docs/source ./docs/build
