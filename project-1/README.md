# Shell Script Project

This project is based on linux shell scripting. Developed for user and group management.

## Prerequisite

Need knowledge on user and group management in linux, shell scripting. If not please go through following links

- [User and Group management](https://hashnode.com/post/clsg68jyi000109jp5tvxh916)
- [Linux shell script](https://hashnode.com/post/clspwola1000108jl9p346wpj)

## Getting started

Please [clone](../README.md#getting-started) this repository.

```bash
cd project-1
```

---

```bash
./main.sh [options]
```

| options      | description                       |
| :----------- | :-------------------------------- |
| -c, --create | Create new user or group.         |
| -d, --delete | Delete new user or group.         |
| -l, --list   | List all users or groups.         |
| -r, --reset  | Reset password for existing user. |
| -aG          | Add user to group                 |
| -h, --help   | Display this help and exit.       |

- `-c, --create`

  ```bash
  ./main.sh -c [options]
  ```

  | options     | description                |
  | :---------- | :------------------------- |
  | -u, --user  | Create User                |
  | -g, --group | Create Group               |
  | -h, --help  | Display this help and exit |

- `-d, --delete`

  ```bash
  ./main.sh -d [options]
  ```

  | options     | description                |
  | :---------- | :------------------------- |
  | -u, --user  | Delete User                |
  | -g, --group | Delete Group               |
  | -h, --help  | Display this help and exit |

- `-l, --list`

   ```bash
  ./main.sh -l [options]
  ```

  | options     | description                |
  | :---------- | :------------------------- |
  | -u, --user  | List all users             |
  | -g, --group | List all groups            |
  | -h, --help  | Display this help and exit |
