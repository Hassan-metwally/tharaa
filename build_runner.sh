
##########################################
# Make it executable:
# chmod +x build_runner.sh

# Run it from the terminal:
# ./build_runner.sh
##########################################

echo "[BUILD RUNNER SCRIPT] ::: START :::"

flutter pub run build_runner build --delete-conflicting-outputs

# dart run build_runner build

echo "[BUILD RUNNER SCRIPT] ::: END :::"






