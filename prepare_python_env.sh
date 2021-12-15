ENV_DIR="$HOME/runrapidenv"
RUNRAPID_DIR="$HOME/runrapid"

echo $ENV_DIR

if [ -d "$ENV_DIR" ] ; then
    echo "Directory $ENV_DIR already exists. Skipping python virtualenv creation."
    exit
fi

(virtualenv "$ENV_DIR" --python /usr/bin/python3
source "$ENV_DIR"/bin/activate
pip install -U pip
pip install -r requirements.txt
git clone https://gerrit.opnfv.org/gerrit/samplevnf /tmp/samplevnf
cd /tmp/samplevnf/VNFs/DPPD-PROX/helper-scripts/rapid
sed -i "s|$OLD_FORMAT_FILE|$NEW_FORMAT_FILE|g" rapid_test.py
cp helper.lua $RUNRAPID_DIR
cp format.yaml $RUNRAPID_DIR
python setup.py build
python setup.py install
rm -rf /tmp/samplevnf)
