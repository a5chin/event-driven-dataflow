from pathlib import Path


def get_folder(subject: str):
    """Get the folder from the provided subject path.

    Args:
        subject (str): The subject path.
                       (e.g. "object/2023/12-30/sample.avro")

    Returns:
        str: The folder path.
             (e.g. "2024/04-01")
    """
    p = Path(subject)

    if p.parts[0] != "objects":
        raise ValueError(f"The top level directory of the subject is {p.parts[0]} instead of 'object'.")

    folder = Path(*p.parts[1:-1]).as_posix()
    return folder
