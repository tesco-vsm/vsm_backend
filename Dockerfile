FROM python:3.7
ENV PYTHONUNBUFFERED 1
RUN mkdir /app
WORKDIR /app
COPY requirements.txt /app/
COPY . /app/
RUN apt-get update \ 
    && apt-get install -y default-libmysqlclient-dev \
    && pip install -r requirements.txt \
    && chmod +x wait-for-it.sh \
    && python manage.py  collectstatic --no-input --clear
EXPOSE 8000
CMD ["./wait-for-it.sh", "db:3036", "-t", "60", "--", "python", "manage.py", "runserver", "0.0.0.0:8000"]