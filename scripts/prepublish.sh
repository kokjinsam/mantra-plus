echo "> Start transpiling ES2015"
echo ""
rm -rf ./lib
./node_modules/.bin/babel --plugins "transform-runtime" src --ignore __tests__ --out-dir ./lib
echo ""
echo "> Complete transpiling ES2015"
