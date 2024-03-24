import pytest
import sys
from pathlib import Path


current_dir = Path(__file__).resolve().parent
sys.path.append((current_dir / "../").as_posix())

from extract import get_folder


@pytest.mark.parametrize(
    "subject, folder",
    [
        ("objects/2024/04-01/sample.json", "2024/04-01"),
        ("objects/2024/12-31/sample.avro", "2024/12-31"),
        ("objects/2024/02-29/spanner-export.json", "2024/02-29"),
    ],
)
def test__get_date(subject: str, folder: str):
    assert get_folder(subject) == folder
