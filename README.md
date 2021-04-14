# NooBaa's Homebrew Tap
This brew tap provides tools for NooBaa users/developers:
- `noobaa` is the noobaa-operator CLI for managing NooBaa S3 service on Kubernetes/Openshift - see [noobaa-operator](https://github.com/noobaa/noobaa-operator)
- `noobaa-core` is the noobaa-core program that includes multiple core commands - see [Standalone-noobaa-core](https://github.com/noobaa/noobaa-core/wiki/Standalone-noobaa-core)

## Usage

#### Tap and Install:
```
brew tap noobaa/noobaa
brew install noobaa
brew install noobaa-core
```

#### Upgrade:
```
brew upgrade noobaa
brew upgrade noobaa-core
```

#### Uninstall and Untap:
```
brew uninstall noobaa
brew uninstall noobaa-core
brew untap noobaa/noobaa
```

### Info

- **About**: NooBaa is an object data service for hybrid and multi cloud environments
- **Repository**: https://github.com/noobaa/noobaa-core
- **Operator + CLI**: https://github.com/noobaa/noobaa-operator


## For Maintainers

### New release

1. Update the formula url section to the new release tag and revision

For example: https://github.com/noobaa/homebrew-noobaa/blob/5ec5108b18a6e8ea1bb58e47b0fc3cae63641e11/Formula/noobaa.rb#L4-L6
```
  url "https://github.com/noobaa/noobaa-operator.git",
      :tag      => "v5.7.0",
      :revision => "054bc35207d5c3cae70838052b76b55149c1c260"
```

2. Build bottle locally

```
$ brew uninstall noobaa
$ brew install noobaa --build-bottle
$ brew bottle noobaa
==> Determining noobaa/noobaa/noobaa bottle rebuild...
==> Bottling noobaa--5.7.0.big_sur.bottle.1.tar.gz...
==> Detecting if noobaa--5.7.0.big_sur.bottle.1.tar.gz is relocatable...
./noobaa--5.7.0.big_sur.bottle.1.tar.gz
  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur: "35745610631857420a1dc66f0ba752b5e825611e15c5e54f981f9bb6b7a330db"
  end
```

3. Edit the release and upload the bottle tar file to the release assets.

See example release - https://github.com/noobaa/noobaa-operator/releases/tag/v5.7.0

4. Update the formula `bottle do` section to the new release download url and the sha256 as provided from brew bottle before.

For example: https://github.com/noobaa/homebrew-noobaa/blob/193e23780131ab3db2d3eb39ddb971f7e5e6f04a/Formula/noobaa.rb#L9-L13
```
  bottle do
    root_url "https://github.com/noobaa/noobaa-operator/releases/download/v5.7.0"
    sha256 cellar: :any_skip_relocation, mojave: "35745610631857420a1dc66f0ba752b5e825611e15c5e54f981f9bb6b7a330db"
    rebuild 1
  end
```


5. Test that the bottle works:

```
$ brew reinstall noobaa
==> Downloading https://github.com/noobaa/noobaa-operator/releases/download/v5.7.0/noobaa-5.7.0.mojave.bottle.1.tar.gz
==> Downloading from https://github-releases.githubusercontent.com/194805859/...
######################################################################## 100.0%
==> Reinstalling noobaa/noobaa/noobaa
==> Pouring noobaa-5.7.0.mojave.bottle.1.tar.gz
🍺  /usr/local/Cellar/noobaa/5.7.0: 3 files, 55.7MB
```

For more information on bottles see https://docs.brew.sh/Bottles.
