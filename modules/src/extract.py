from pathlib import Path

from google.cloud import storage


def get_folder(subject: str):
    """Get the folder from the provided subject path.

    Args:
        subject (str): The subject path.
                       (e.g. "object/2023/12-30/sample.avro")

    Returns:
        str: The folder path.
             (e.g. "2024/04-01")
    """
    parts = Path(subject).parts

    if parts[0] != "objects":
        raise ValueError(
            f"The top level directory of the subject is {parts[0]} instead of 'object'."
        )

    return Path(*parts[1:-1]).as_posix()


def is_file_exists(bucket: str, folder: str, extension: str = ".avro") -> bool:
    storage_client = storage.Client()
    blobs = storage_client.list_blobs(bucket, prefix=folder)

    return not any(blob.name.endswith(extension) for blob in blobs)
