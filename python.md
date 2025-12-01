# Python Cheat Sheet

## Installation
**Install pip:**
```bash
sudo apt install -y python3-pip
```

## Package Management
**List outdated packages:**
```bash
python3 -m pip list --outdated
```

**Update packages:**

*Host:*
```bash
python3 -m pip freeze --user | cut -d'=' -f1 | xargs -n1 python3 -m pip install -U
```

*VM:*
```bash
python3 -m pip freeze | cut -d'=' -f1 | xargs -n1 python3 -m pip install -U
```
