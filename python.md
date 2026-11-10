# Python Cheat Sheet

**Virtual environment per project (never `pip install` into the system Python):**
```bash
python3 -m venv .venv && source .venv/bin/activate
python -m pip install -r requirements.txt
```

**uv (fast; also locks dependencies):**
```bash
brew install uv
uv venv && uv pip install -r requirements.txt
uv pip compile requirements.in --universal --python-version 3.13 -o requirements.txt   # lock
```

**List outdated packages:**
```bash
python -m pip list --outdated
```
Upgrade deliberately by editing `requirements.in` and re-locking; do not bulk-upgrade everything with `pip freeze | xargs pip install -U`.
