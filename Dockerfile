# 1. 가벼운 파이썬을 기반으로 시작합니다.
FROM python:3.9-slim-buster

# 2. 작업 디렉토리를 설정합니다.
WORKDIR /app

# 3. requirements.txt 파일을 먼저 복사합니다. (이 파일이 변경될 때만 라이브러리를 다시 설치하게 됩니다)
COPY requirements.txt .

# 4. CPU 전용 PyTorch 다운로드 경로를 지정하여 라이브러리를 설치합니다.
RUN pip install --no-cache-dir -r requirements.txt --index-url https://download.pytorch.org/whl/cpu

# 5. 나머지 소스 코드를 복사합니다.
COPY . .

# 6. gunicorn을 사용하여 앱을 실행합니다. Railway는 PORT 환경변수를 자동으로 설정해줍니다.
CMD ["gunicorn", "--bind", "0.0.0.0:$PORT", "app:app"] 