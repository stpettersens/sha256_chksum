import sys
import hashlib

from pathlib import Path

def sha256sum(filename: str) -> str:
    with open(filename, 'rb', buffering=0) as f:
        return hashlib.file_digest(f, 'sha256').hexdigest()

if __name__ == "__main__":
    try:
        filename: str = sys.argv[1]
        with open(f'{Path(filename).stem}_sha256.txt', 'w') as chksum:
            chksum.write(f"{sha256sum(filename)} *{filename}")

    except IndexError:
        print("sha256_chksum: Please provide a filename.")
        sys.exit(-1)

    sys.exit(0)
