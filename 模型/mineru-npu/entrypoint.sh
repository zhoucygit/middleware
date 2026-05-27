#!/bin/bash
set -e

echo "Activating mineru env..."
source /opt/miniconda/etc/profile.d/conda.sh
conda activate mineru
sleep 10


exec "$@"