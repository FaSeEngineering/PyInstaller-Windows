FROM mcr.microsoft.com/windows/server:ltsc2022

# Install reqired packages
RUN mkdir "C:\TEMP\"
WORKDIR "C:\TEMP"
ADD https://www.python.org/ftp/python/3.12.4/python-3.12.4-amd64.exe "C:\TEMP\python-installer.exe"
RUN powershell -Command \
   $ErrorActionPreference = 'Stop'; \
   Start-Process C:\TEMP\python-installer.exe -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1' -Wait ;
RUN python -m pip install --upgrade pip

# Install pyinstaller
RUN pip install pyinstaller

# Create GitLab Environment
RUN mkdir "C:\builds"
WORKDIR "C:\builds"

# Entrypoint
COPY "entrypoint.ps1" "C:/entrypoint.ps1"
ENTRYPOINT ["powershell", "C:/entrypoint.ps1"]
