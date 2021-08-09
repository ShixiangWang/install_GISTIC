# Install GISTIC2 by one line code

I have written two [Chinese blogs](https://www.jianshu.com/p/5822759a67e2) for telling readers how to install GISTIC 2.0 (a famous software for copy number analysis) step by step. Recently I realize the installation steps can be implemented automatically, so I write this program.

**Now, you can directly run GISTIC on hiplot platform, try it at <https://hiplot.com.cn/advance/gistic2>**.

> Update:
>
> - 2021-08-09: add an option to `preprocess.R` to output data to custom file.
> - 2021-04-02: add R script to clean overlap segments.
> - 2020-10-26: update README to add Hiplot link and singularity example link.
> - 2020-10-14: run GISTIC with Docker is supported as an entrypoint.
> - 2020-03-08: add system check

## Install from script (Linux Only)

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

4. Check [example script](./run_GISTIC_example.sh) to see how to run GISTIC.

## Install from docker

Two ways:

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

Click [example script](./run_docker.sh) to see how to run GISTIC in Docker.

Run the following command to go into Docker interactive terminal.

```sh
sudo docker run -it --rm --entrypoint bash shixiangwang/gistic
```

If you are using singularity, check [this example](./run_singularity.sh) to see how to run GISTIC.

## Note

`unset DISPLAY` should be added to run script for avoiding X11 related errors.

This program is tested and currently only support GISTIC 2.0.23, any suggestion or pull request is welcome.

## Q & A

1. How to handle error related to "overlap".

You can clean the overlap segments byself firstly or use my written R script [preprocess.R](preprocess.R).

```sh
# Usage: Rscript preprocess.R input.seg [minimal_prob, default 0]
#
# Example: Rscript preprocess.R input.seg 5
# Filter segments with less than 5 probes and then clean overlap segments
# by weighted multiplication
```

## Citation

If you want to thank my work, please cite my recent paper and add the link to this GitHub repo.

*Antigen presentation and tumor immunogenicity in cancer immunotherapy response prediction, **eLife***. https://doi.org/10.7554/eLife.49020

## LICENSE

MIT &copy; 2019-2020 Shixiang Wang

