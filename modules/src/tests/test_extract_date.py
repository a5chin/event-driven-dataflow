import pytest
import sys
from pathlib import Path


current_dir = Path(__file__).resolve().parent
sys.path.append((current_dir / "../").as_posix())

from extract import get_date


@pytest.mark.parametrize(
    "val, expected",
    [
        ("object/2024/04-01/sample.json", "2024/04-01"),
        ("object/2024/12-31/sample.avro", "2024/12-31"),
        ("object/2024/02-29/spanner-export.json", "2024/02-29"),
    ],
)
def test__get_date(val: str, expected: str):
    assert get_date(val) == expected
