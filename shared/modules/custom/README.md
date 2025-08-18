# shared/modules/custom/

These modules in this directory are mostly namespaces for programs grouped by type.
Some modules like theme.nix do much more than that however.

All of these modules can be safely imported and no configuration changes will happen unless
specified options are enabled.

Home manager options are prioritized, i.e. if a home manager module is available then that is used
