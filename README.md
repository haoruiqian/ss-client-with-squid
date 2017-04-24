A shadowsocks client with squid as http(s) proxy server

# How to run it.
1. [Install docker.](https://www.docker.com/)
2. Run command in terminal.
```
docker run -d --rm --privileged -p 3128:3128 -e SERVER="<SS Server IP>" -e SERVER_PORT="<SS Server Port>" -e ENCRYPT_METHOD="<encrypt method>" -e PASSWORD="<password>" haoruiqian/ss-client-with-squid
```
3. Set proxy server to *127.0.0.1*, and port to *3128*.
4. To use it in terminal, run command
  ```
export http_proxy=http://127.0.0.1:3128
export https_proxy=http://127.0.0.1:3128
export all_proxy=http://127.0.0.1:3128
  ```