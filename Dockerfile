FROM ubuntu:latest

WORKDIR /usr/src/app
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-pip python3-venv && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY . .

RUN apt-get update && \
    xargs apt-get -y install < ./widget/requirements.system

RUN pip install --no-cache-dir -r ./widget/requirements.txt

RUN chmod +x fetch_and_run.sh

# ENTRYPOINT ["./fetch_and_run.sh"]

CMD ["tail", "-f", "/dev/null"]