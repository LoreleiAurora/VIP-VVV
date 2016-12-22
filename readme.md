## VIP-VVV

This allows [VVV](https://github.com/Varying-Vagrant-Vagrants/VVV) to provision a site for WordPress.com VIP work. It uses the new VVV provisioning system from the `develop` branch. There may be a number of changes between this and [VIP Quickstart](https://github.com/Automattic/vip-quickstart/), as it isn't a perfect replica

### Installation

To use this, modify your `vvv-custom.yml` to add the following:

```
  vip:
    repo: https://github.com/LoreleiAurora/VIP-VVV.git
    hosts:
      - vip.localhost
```

VVV will then check out this repository on provision and install all the relevant things.

You can now provision the site on it's own using:

```
vagrant provision --provision-with=site-vip
```

Or you can run `vagrant up --provision` to provision everything in VVV.

#### I don't have a `vvv-custom.yml`?

You can create this with a copy `vvv-config.yml`. Remember this was built for the new provisioning system, not the old provisioning system.

### Starter Themes

In addition to all the things that come with VVV, and the shared plugins and code Quickstart uses, this adds several other items that may aid VIP development:

 - **Minimum Viable VIP** - The smallest possible theme that passes VIP code review. It provides a 404 page, a main file, and includes the needed headers, but nothing else.
 - **_s** - A copy of underscores, a popular starter theme