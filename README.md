# Install GISTIC2 by one line code

I have written two [Chinese blogs](https://www.jianshu.com/p/5822759a67e2) for telling readers how to install GISTIC 2.0 (a famous software for copy numbeer analysis) step by step. Recently I realize the installation steps can be implemented automatically, so I write this program.

## Installation

```bash
git clone https://github.com/ShixiangWang/install_GISTIC
cd install_GISTIC
chmod u+x install_GISTIC2.sh
```

## Usage

This program is a pure bash script and can be run in the following way.

```bash
./install_GISTIC2.sh args1 args2

# args1: the path to GISTIC_x_x_xx.tar.gz file
# args2: the install directory, must be absolute path, note relative path
```

This program is tested and currently only support GISTIC 2.0.23, any suggestion or pull request is welcome.

## LICENSE

MIT &copy; 2019 Shixiang Wang

