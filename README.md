# iwannago

simple script to go places.

### uc.1 go places

`given` such map

| name | ip/address | user | identity file |
|---|---|---|---|
| order_dev | 10.98.9.2 | deployer | ~/.ssh/id_rsa_dev |
| order_prod | 10.99.9.2 | deployer |~/.ssh/id_rsa_prod |

in yaml format (see example)

`when` i say `./iwannago.sh order_dev`

`then` i should go  (ssh) to `order_dev`

### uc.2 see places

`given` such map above

`when` i say `./iwannago.sh --list`

`then` i should see `order_dev, order_prod` (in vertical list)

## Setup

- setup map file (default to `~/.iwannago_map.yaml`)
  example:

  ```yaml
  # `~/.iwannago_map.yaml`
  map:
  - name: order_dev
    address: 10.98.9.2
    user: deployer
    identity_file: ~/.ssh/id_rsa_dev
  - name: order_prod
    address: 10.99.9.2
    user: deployer
    identity_file: ~/.ssh/id_rsa_prod
  ```

## Usage

- `./iwannago.sh <destination_name>`
- `./iwannago.sh <destination_name> --map <mapfile.yaml>`
- `./iwannago.sh --list`
- `./iwannago.sh --list --map <mapfile.yaml>`
