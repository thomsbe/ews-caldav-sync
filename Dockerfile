FROM python:3.12.1-alpine3.19

ARG USER_UID=1000
ARG GROUP_GID=1000
ARG USERNAME=ews_sync

RUN addgroup --system --gid ${GROUP_GID} ${USERNAME} && \
    adduser --system --disabled-password --home /app \
    --uid ${USER_UID} --ingroup ${USERNAME} ${USERNAME}

COPY requirements.txt ews_calendar_sync.py /app/
WORKDIR /app

RUN --mount=type=cache,target=/root/.cache/pip pip install -r requirements.txt

USER ${USERNAME}

ENTRYPOINT ["python", "ews_calendar_sync.py"]
