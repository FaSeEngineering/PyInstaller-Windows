FROM mcr.microsoft.com/windows/server:ltsc2022

# Install powershell core packages
RUN powershell -Command \
    $ErrorActionPreference = 'Stop'; \
    Invoke-WebRequest -Uri https://github.com/PowerShell/PowerShell/releases/download/v7.2.5/PowerShell-7.2.5-win-x64.msi -OutFile C:\powershell.msi; \
    Start-Process msiexec.exe -ArgumentList '/i', 'C:\powershell.msi', '/quiet', '/norestart' -NoNewWindow -Wait; \
    Remove-Item -Force C:\powershell.msi; \
    $env:PATH += ';C:\Program Files\PowerShell\7\'

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
