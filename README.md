# libuuid-user

Set a nologin shell for the libuuid user on Ubuntu/Debian and validate that it is correct.

This cookbook serves two purposes.

1. Remediate the issue reported in [Ubuntu](https://bugs.launchpad.net/ubuntu/+source/util-linux/+bug/1454897) and [Debian](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=785270) regarding the `libuuid` user missing a shell that disables login.
2. Provide examples that show the difference between Chef's [audit mode](https://www.chef.io/blog/2015/05/06/chef-audit-mode-introduction/) (which uses Serverspec), and "regular" Serverspec.

# Usage

Include `recipe[libuuid-user]` on any nodes that need to have this user updated to ensure that the shell is set correctly.

Include `recipe[libuuid-user::verify]` on any node where audit mode should be used to verify that the libuuid user's shell is set correctly.

The `verify` recipe can be used independently on nodes with audit mode set to `:audit_only` (`chef-client --audit-mode audit_only`) to check for non-compliant systems before using the `default` recipe.

## Audit Mode

Use the default and verify recipes and run audit mode with `:enabled`. The test validates that the policy is correct:

> The libuuid user should have its shell set to /usr/sbin/nologin

The control has a single test that the user's shell is set to `/usr/sbin/nologin`, as that is the defined policy. We want a nice message to someone attempting to `su`, which is why we use `nologin` instead of `/bin/false`, as that would simply exit with no informational message.

## Serverspec

Use test kitchen from this cookbook's [repository](https://github.com/chef-cookbooks/libuuid-user) with `kitchen test` or `kitchen verify` to run the default and verify recipes and run the tests with Serverspec.

The test verifies that the `root` user cannot `su` to the `libuuid` user. This is subtley different than the audit mode test, as the implementation of the shell is not the important part to test. It's the inability to login that is most relevant.

# Requirements

Chef 12.1.0+

Ubuntu 14.04 or Debian 7.8.

Other platforms are not supported. Older versions of Ubuntu or Debian may work with or without modification.

## License and Author

* Author: Joshua Timberman <joshua@chef.io>
* Copyright (c) 2015 Chef Software, Inc. <legal@chef.io>

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
