# cursor-editor-snap


sudo snap remove cursor-editor && rm -f cursor-editor_*.snap && snapcraft clean && snapcraft --verbosity debug
sudo snap install --dangerous --devmode cursor-editor_*.snap && snap run cursor-editor
