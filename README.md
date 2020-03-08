# Install GISTIC2 by one line code

I have written two [Chinese blogs](https://www.jianshu.com/p/5822759a67e2) for telling readers how to install GISTIC 2.0 (a famous software for copy number analysis) step by step. Recently I realize the installation steps can be implemented automatically, so I write this program.

> Update:
>
> - 2020-03-08: add system check

## Install from script 

1. Download GISTIC 2.0 from ftp://ftp.broadinstitute.org/pub/GISTIC2.0
2. Download this repository.

```bash
git clone https://github.com/ShixiangWang/install_GISTIC
cd install_GISTIC
chmod u+x install_GISTIC2.sh
```
3. Run script.

This program is a pure bash script and can be run in the following way.

```bash
./install_GISTIC2.sh args1 args2

# args1: the path to GISTIC_x_x_xx.tar.gz file
# args2: the install directory, must be absolute path, not relative path
```

## Install from docker

Two days:

### Just pull from Docker hub <https://hub.docker.com/r/shixiangwang/gistic>.

```bash
docker pull shixiangwang/gistic
```

### Build the image by yourself.

```bash
git clone https://github.com/ShixiangWang/install_GISTIC
cd install_GISTIC
sudo docker build -t gistic:latest .
```

### Run docker image

```bash
sudo docker run -it gistic /bin/bash
```

The installed GISTIC is located at `/opt/GISTIC`.

## Note

`unset DISPLAY` is recommendly added to run script for avoiding X11 related errors.

This program is tested and currently only support GISTIC 2.0.23, any suggestion or pull request is welcome.

## LICENSE

MIT &copy; 2019-2020 Shixiang Wang

