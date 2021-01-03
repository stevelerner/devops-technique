install pip:

sudo apt install -y python3-pip

list outdated packages

python3 -m pip list --outdated

update packages:

host:
python3 -m pip freeze --user | cut -d'=' -f1 | xargs -n1 python3 -m pip install -U

vm:
python3 -m pip freeze | cut -d'=' -f1 | xargs -n1 python3 -m pip install -U
