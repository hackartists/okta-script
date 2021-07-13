# Okta Setup Script
## Initial setup script

```
USER=luffy.choi sh -c "$(curl -fsSL https://raw.githubusercontent.com/luffy-choi/okta-script/master/setup.sh)"
```

## Updating AWS profile
- You can set one of `default`, `service-dev` and `service-prod` to `PROFILE`.

```
PROFILE=default sh -c "$(curl -fsSL https://raw.githubusercontent.com/luffy-choi/okta-script/master/update.sh)"
```
