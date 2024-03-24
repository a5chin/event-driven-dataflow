import re


def get_date(subject: str, pattern: str = r"\d{4}/\d{2}-\d{2}") -> str:
    """Returns the matched date string from the subject string.

    Args:
        subject (str): The string to search for the date.
        pattern (str, optional): The regular expression pattern to find the date. Defaults to r"[0-9]{4}/[0-9]{2}-[0-9]{2}".

    Returns:
        str: The matched date string.
    """
    try:
        target = re.search(pattern, subject)
        return target.group()
    except AttributeError:
        raise ValueError(f"No {pattern} found in {subject} string.")
