[![License: GPL 3](https://img.shields.io/badge/license-GPL_3-green.svg)](http://www.gnu.org/licenses/gpl-3.0.txt)
<!-- [![GitHub release](https://img.shields.io/github/release/lordpretzel/edit-variable-value.svg?maxAge=86400)](https://github.com/lordpretzel/edit-variable-value/releases) -->
<!-- [![MELPA Stable](http://stable.melpa.org/packages/edit-variable-value-badge.svg)](http://stable.melpa.org/#/edit-variable-value) -->
<!-- [![MELPA](http://melpa.org/packages/edit-variable-value-badge.svg)](http://melpa.org/#/edit-variable-value) -->
[![Build Status](https://secure.travis-ci.org/lordpretzel/edit-variable-value.png)](http://travis-ci.org/lordpretzel/edit-variable-value)


# edit-variable-value

Small library for adding and removing advice to functions.

## Usage

Allows to edit the value of a variable in an elisp buffer. run `counsel-describe-variable` and use optional action (`M-o`) `e` for edit.

## Installation

<!-- ### MELPA -->

<!-- Symbol’s value as variable is void: $1 is available from MELPA (both -->
<!-- [stable](http://stable.melpa.org/#/edit-variable-value) and -->
<!-- [unstable](http://melpa.org/#/edit-variable-value)).  Assuming your -->
<!-- ((melpa . https://melpa.org/packages/) (gnu . http://elpa.gnu.org/packages/) (org . http://orgmode.org/elpa/)) lists MELPA, just type -->

<!-- ~~~sh -->
<!-- M-x package-install RET edit-variable-value RET -->
<!-- ~~~ -->

<!-- to install it. -->

### Quelpa

Using [use-package](https://github.com/jwiegley/use-package) with [quelpa](https://github.com/quelpa/quelpa).

~~~elisp
(use-package
:quelpa ((edit-variable-value
:fetcher github
:repo "lordpretzel/edit-variable-value")
:upgrade t)
)
~~~

### straight

Using [use-package](https://github.com/jwiegley/use-package) with [straight.el](https://github.com/raxod502/straight.el)

~~~elisp
(use-package edit-variable-value
:straight (edit-variable-value :type git :host github :repo "lordpretzel/edit-variable-value")
~~~

### Source

Alternatively, install from source. First, clone the source code:

~~~sh
cd MY-PATH
git clone https://github.com/lordpretzel/edit-variable-value.git
~~~

Now, from Emacs execute:

~~~
M-x package-install-file RET MY-PATH/edit-variable-value
~~~

Alternatively to the second step, add this to your Symbol’s value as variable is void: \.emacs file:

~~~elisp
(add-to-list 'load-path "MY-PATH/edit-variable-value")
(require 'edit-variable-value)
~~~
