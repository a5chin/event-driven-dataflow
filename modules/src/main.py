import os
from pathlib import Path

import requests
import functions_framework
from cloudevents.http.event import CloudEvent

from authz import get_token
from extract import get_folder, is_file_exists
from logger import get_logger


@functions_framework.cloud_event
def create_dataflow(cloud_event: CloudEvent):
    try:
        subject = Path(cloud_event.get("subject"))
    except KeyError:
        raise KeyError(f"Cannot found key 'subject' in Cloud Event attributes.")

    logger = get_logger()

    logger.info(f"Subject: {subject}")

    folder = get_folder(subject.as_posix())

    if subject.name != "spanner-export.json":
        logger.info("Skip Sync due to different file.")
        return

    if not is_file_exists(os.environ["INPUT_DIR"], folder, extension := ".avro"):
        raise FileNotFoundError(f"{extension} file is not found.")

    access_token = get_token()

    api = f"https://dataflow.googleapis.com/v1b3/projects/{os.environ['PROJECT_ID']}/locations/us-central1/templates"
    headers = {"Authorization": f"Bearer {access_token}"}
    body = {
        "jobName": os.environ["JOB_NAME"],
        "gcsPath": os.environ["GCS_PATH"],
        "parameters": {
            "instanceId": os.environ["INSTANCE_ID"],
            "databaseId": os.environ["DATABACE_ID"],
            "inputDir": f"{os.environ['INPUT_DIR']}/{folder}",
        },
        "environment": {
            "serviceAccountEmail": os.environ["SERVICE_ACCOUNT_EMAIL"],
            "tempLocation": os.environ["TEMP_LOCATION"],
        },
    }
    response = requests.post(api, json=body, headers=headers)
    logger.debug(body)

    assert response.status_code == requests.codes.ok
