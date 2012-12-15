git submodule update --init
find plugins/ -iname ".gitmodules" -exec sed -i.bak "s/git:\/\//https:\/\//" {} \;
git submodule update --init --recursive
