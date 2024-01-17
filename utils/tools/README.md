## /tools

### [port-shifter.sh](../tools/port-shifter.sh)

This script is useful if you quickly want to replace the ports in the `client.toml`, `config.toml` and `app.toml` files. It uses the script(s) from the [`port-shifter`](https://github.com/zenodeapp/port-shifter/tree/v1.0.1) repository (`v1.0.1`). If in doubt whether this is safe, you could always check the repository to see how it works.

```
sh tools/port-shifter.sh <port_increment_value>
```

> <port_increment_value> is how much you would like to increment the value of the ports based on the default port values.
