# Launchd wireguard service installer

Makefile for installing wireguard tunnels as launchd services on macOS. It
just wraps wg-quick script as a service and installs files to appropriate
locations. Since it uses wg-quick, multiple tunnels may be activated at a time.


## Prerequisites

Requires wg-quick script. Use Homebrew to install:

```
brew install wireguard-tools
```


## Usage

Put your tunnel interface configurations into `interfaces` directory:

```
vim interfaces/foobar.conf
vim interfaces/bazqux.conf
```

Deploy tunnel services to the system. Requires sudo:

```
sudo make
```

Activate and deactivate tunnel interface described by `foobar.conf`:

```
sudo launchctl start wg-quick.foobar
sudo launchctl stop wg-quick.foobar
```

Uninstall services from the system:

```
sudo make clean
```
