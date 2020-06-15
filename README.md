# `crond-stdout-example`

`crond` で実行するプロセスが吐き出す内容を `crond` プロセス自身にする方法

- `stdout` って言ってるけどバッファリングされるとだるいのでリダイレクトして `stderr` 使ってます
- [Docker で node.js を動かすときは PID 1 にしてはいけない - ngzmのブログ](https://ngzm.hateblo.jp/entry/2017/08/22/185224) を解決するために [krallin/tini: A tiny but valid `init` for containers](https://github.com/krallin/tini) 入れてます

```ShellSession
mpyw@host: ~$ docker build -t crond-stdout-example .
Sending build context to Docker daemon  41.47kB
Step 1/4 : FROM alpine:latest
latest: Pulling from library/alpine
df20fa9351a1: Pull complete
Digest: sha256:185518070891758909c9f839cf4ca393ee977ac378609f700f60a771a2dfe321
Status: Downloaded newer image for alpine:latest
 ---> a24bb4013296
Step 2/4 : COPY script.sh /bin/
 ---> 8eca16dddc70
Step 3/4 : RUN echo '* * * * * /bin/script.sh 1>&2' >> /var/spool/cron/crontabs/root
 ---> Running in 79c038c709a3
Removing intermediate container 79c038c709a3
 ---> efaddf8e76ec
Step 4/4 : CMD ["crond", "-f"]
 ---> Running in b4dbc60a6b6e
Removing intermediate container b4dbc60a6b6e
 ---> 48172760d8b3
Successfully built 48172760d8b3
Successfully tagged crond-stdout-example:latest

mpyw@host: ~$ docker run --rm crond-stdout-example
Hello I'm stdout
Hello I'm stderr
Hello I'm stdout
Hello I'm stderr
...
```
