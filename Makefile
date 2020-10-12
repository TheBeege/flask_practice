# Thanks to https://stackoverflow.com/a/12099167
ifeq ($(OS),Windows_NT)
    OS_FAMILY = windows
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        OS_FAMILY = linux
    endif
    ifeq ($(UNAME_S),Darwin)
        OS_FAMILY = osx
    endif
endif

.PHONY: install_deps run_dev

ifeq ($(OS_FAMILY),windows)
install_deps:
	PowerShell -ExecutionPolicy RemoteSigned -Command 'if (-not [System.Environment]::GetEnvironmentVariable("PATH", "User").Contains($$(Get-ChildItem C:\ | Select-String -Pattern Python | Select -Last 1))) { [System.Environment]::SetEnvironmentVariable("PATH", "$$(Get-ChildItem "C:\" | Select-String -Pattern Python | Select -Last 1);$$([System.Environment]::GetEnvironmentVariable("PATH", "User"))", "User") }'
	pip install pipenv
	pipenv install
else
install_deps:
	pipenv install
endif

ifeq ($(OS_FAMILY),windows)
run_dev:
	PowerShell -ExecutionPolicy RemoteSigned -Command '$$Env:FLASK_APP = "example"; pipenv run flask run'
else
run_dev:
	FLASK_APP=example pipenv run flask run
endif