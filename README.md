Bootstrapper
============

Bootstrapper is a script to set up an machine for development within the
Platform R&D team.

It can be run multiple times on the same machine safely.
It installs, upgrades, or skips packages based on what is already installed on
the machine.

Requirements
------------

We support:

* OS X Yosemite (10.10)
* OS X El Capitan (10.11)

Older versions may work but aren't regularly tested. Bug reports for older
versions are welcome.

Install
-------

Download, review, then execute the script:

```sh
git clone git@github.com:concur/bootstrapper.git
cd bootstrapper
sh mac 2>&1 | tee bootstrapper.log
```

Debugging
---------

Your last bootstrapper run will be saved to `~/bootstrapper.log`.
Read through it to see if you can debug the issue yourself.
If not, copy the lines where the script failed into a
[new GitHub Issue](https://github.com/concur/bootstrapper/issues/new) for us.
Or, attach the whole log file as an attachment.

OS X El Capitan (10.11)
-----------------------

You may have problems installing Homebrew for the first time on OS X El
Capitan due to permission changes to the /usr directory (within which the Homebrew
installation is typically located). See the [Homebrew El Capitan troubleshooting instructions][homebrew-el-capitan]
for steps to resolve the permissions issues that interfere with Homebrew's
installation.

[homebrew-el-capitan]: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/El_Capitan_and_Homebrew.md

What it sets up
---------------

Mac OS X tools:

* [Homebrew] for managing operating system libraries.

[Homebrew]: http://brew.sh/

Unix tools:

* [binutils] a collection of binary tools
* [diffutils] a package of several programs related to finding differences between files
* [ed] the original text editor for Unix
* [findutils] are the basic directory searching utilities of the GNU operating system
* [gawk] to select particular records in a file and perform operations upon them
* [indent] a code prettifier
* [sed] the famous stream editor
* [tar] the famous archiving utility
* [which] the famous which utility
* [gnutls] the Transport Layer Security (TLS) Library
* [grep] search files for lines containing a match to a specified pattern, take a look at Silver Searcher as well
* [gzip] a data compression program
* [watch] executes a program periodically, showing output fullscreen
* [wdiff] displays word differences between text files
* [wget] an internet file retriever
* [Exuberant Ctags] for indexing files for vim tab completion
* [Git] for version control
* [OpenSSL] for Transport Layer Security (TLS)
* [RCM] for managing company and personal dotfiles
* [The Silver Searcher] for finding things in files
* [Emacs] for a powerful text editor with [Spacemacs]
* [Vim] for an alternative text editor
* [Tmux] for saving project state and switching between projects
* [Zsh] as your shell
* [tree] displays directories as trees (with optional color/HTML output)

[binutils]: https://www.gnu.org/software/binutils/binutils.html
[diffutils]: https://www.gnu.org/software/diffutils/
[ed]: https://www.gnu.org/software/ed/ed.html
[findutils]: http://www.gnu.org/software/findutils/
[gawk]: https://www.gnu.org/software/gawk/
[indent]: https://www.gnu.org/software/indent/
[sed]: https://www.gnu.org/software/sed/
[tar]: https://www.gnu.org/software/tar/
[which]: https://savannah.gnu.org/projects/which/
[gnutls]: http://gnutls.org/
[grep]: https://www.gnu.org/software/grep/
[gzip]: https://www.gnu.org/software/gzip
[watch]: https://gitlab.com/procps-ng/procps
[wdiff]: https://www.gnu.org/software/wdiff/
[wget]: https://www.gnu.org/software/wget/
[Exuberant Ctags]: http://ctags.sourceforge.net/
[Git]: https://git-scm.com/
[OpenSSL]: https://www.openssl.org/
[RCM]: https://github.com/thoughtbot/rcm
[The Silver Searcher]: https://github.com/ggreer/the_silver_searcher
[Emacs]: https://www.gnu.org/software/emacs/
[Spacemacs]: http://spacemacs.org/
[Vim]: http://www.vim.org/
[Tmux]: http://tmux.github.io/
[Zsh]: http://www.zsh.org/
[tree]: http://mama.indstate.edu/users/ice/tree/

Utilities:

* [httpie] for a prettier console HTTP client
* [jq] for processing JSON from the console like grep is for text

[httpie]: https://github.com/jkbrzt/httpie
[jq]: https://stedolan.github.io/jq/

GitHub tools:

* [Hub] for interacting with the GitHub API

[Hub]: http://hub.github.com/

Image tools:

* [ImageMagick] for cropping and resizing images

Testing tools:

* [Qt] for headless JavaScript testing via Capybara Webkit

[Qt]: http://qt-project.org/

Toolchain and configuration:

* [Bundler] for managing Ruby libraries
* [Node.js] and [NPM], for running apps and installing JavaScript packages
* [NVM] for managing versions of Node.js
* [Rbenv] for managing versions of Ruby
* [Ruby Build] for installing Rubies
* [Ruby] stable for writing general-purpose code
* [Python] stable for writing general-purpose code with pip and virtualenv configured
* [Elixir] stable for writing general-purpose code
* [kubectl] for controlling Kubernetes clusters
* [docker] what Virtual Machines did for Operating Systems, Docker does for processes
* [docker-compose] lets you define a multi-container application in a single file
* [terraform] for building, combining, and launching infrastructure
* [packer] a tool for creating machine and container images for multiple platforms
* [vault] a tool for managing secrets

[Bundler]: http://bundler.io/
[ImageMagick]: http://www.imagemagick.org/
[Node.js]: http://nodejs.org/
[NPM]: https://www.npmjs.org/
[NVM]: https://github.com/creationix/nvm
[Rbenv]: https://github.com/sstephenson/rbenv
[Ruby Build]: https://github.com/sstephenson/ruby-build
[Ruby]: https://www.ruby-lang.org/en/
[Python]: https://www.python.org/
[Elixir]: http://elixir-lang.org/
[kubectl]: https://cloud.google.com/container-engine/docs/kubectl/
[docker]: https://www.docker.com/
[docker-compose]: https://www.docker.com/products/docker-compose
[terraform]: https://www.terraform.io/
[packer]: https://www.packer.io/
[vault]: https://www.vaultproject.io/

It should take less than 15 minutes to install (depends on your machine).

Customize in `~/.bootstrapper.local`
------------------------------

Your `~/.bootstrapper.local` is run at the end of the bootstrapper script.
Put your customizations there.
For example:

```sh
#!/bin/sh

brew_install_or_upgrade 'ranger'
brew_install_or_upgrade 'tig'

fancy_echo "Cleaning up old Homebrew formulae ..."
brew cleanup
brew cask cleanup

if [ -r "$HOME/.rcrc" ]; then
  fancy_echo "Updating dotfiles ..."
  rcup
fi
```

Write your customizations such that they can be run safely more than once.
See the `mac` script for examples.

Bootstrapper functions such as `fancy_echo`,
`brew_install_or_upgrade`,
`brew_tap`,
`brew_launchctl_restart`, and
`gem_install_or_update`
can be used in your `~/.bootstrapper.local`.

Contributing
------------

Edit the `mac` file.
Document in the `README.md` file.
Follow shell style guidelines by using [ShellCheck] and [Syntastic].

```sh
brew install shellcheck
```

[ShellCheck]: http://www.shellcheck.net/about.html
[Syntastic]: https://github.com/scrooloose/syntastic

Thanks
----------------

This repo and script was heavily inspired by [Thoughtbot's][thoughtbot]
[Laptop][laptop] script.

[thoughtbot]: https://thoughtbot.com/
[laptop]: https://github.com/thoughtbot/laptop
