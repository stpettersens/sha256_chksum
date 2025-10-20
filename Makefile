uname := $(shell uname)
sha256sumA=sha256sum sha256_chksum.py > sha256_cksum_sha256.txt
sha256sumB=sha256sum sha256_chksum_win64.zip > sha256_chksum_win64_sha256.txt
sha256sumC=sha256sum sha256_chksum-setup.ps1 > sha256_chksum-setup_sha256.txt

ifeq ($(uname),Windows)
	sha256sumA=uv run sha256_chksum.py sha256_chksum.py
	sha256sumB=uv run sha256_chksum.py sha256_chksum_win64.zip
	sha256sumC=uv run sha256_chksum.py sha256_chksum-setup.ps1
endif

check:
	uv pip install mypy
	uv run mypy sha256_chksum.py
	$(sha256sumA)

executable:
	uv pip install pyinstaller
	uv run pyinstaller -F sha256_chksum.py
	7z u -tzip sha256_chksum_win64.zip .\dist\sha256_chksum.exe LICENSE
	$(sha256sumB)

upload:
	$(sha256sumC)
	@echo
	@copyparty_sync
