FROM python:3.10-bullseye
# cannot use slim as it removes needed packages
LABEL maintainer="Craig Stanton"
WORKDIR /code
ENV PYTHONUNBUFFERED 1

# install opencv dependencies typically on local machine
RUN apt-get update && apt-get install libgl1 -y

EXPOSE 8000
EXPOSE 5454

RUN python -m pip install pip --upgrade

# copy the requirements file only for now
COPY ./requirements.txt /code
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# copying the code after the installtion of the dependencies ensures we use the dependency cache if possible
# this makes building faster
COPY . /code/

CMD python netgear.py