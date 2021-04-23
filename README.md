#  freenom-auto-new(免费域名自动续期)

[![GitHub Stars](https://img.shields.io/github/stars/roiding/freenom-auto-renew.svg?style=flat-square&label=Stars&logo=github)](https://github.com/roiding/freenom-auto-renew/stargazers)

[![GitHub forks](https://img.shields.io/github/forks/roiding/freenom-auto-renew.svg?style=flat-square&label=Forks&logo=github)](https://github.com/roiding/freenom-auto-renew/fork)

[![Docker Stars](https://img.shields.io/docker/stars/maodou38/freenom-auto-renew.svg?style=flat-square&label=Stars&logo=docker)](https://hub.docker.com/r/maodou38/freenom-auto-renew)

[![Docker Pulls](https://img.shields.io/docker/pulls/maodou38/freenom-auto-renew.svg?style=flat-square&label=Pulls&logo=docker)](https://hub.docker.com/r/maodou38/freenom-auto-renew) 

 [![GitHub license](https://img.shields.io/github/license/roiding/freenom-auto-renew.svg?style=flat-square&label=LICENSE)](https://github.com/roiding/freenom-auto-renew/blob/master/LICENSE)

## 项目配置

自己也使用了很久的***[luolongfei](https://github.com/luolongfei/freenom)***大神写的自动续期项目，是使用Github Actions作为的定时任务器。

但Github有个机制就是代码库几个月没有任何活动之后，action就会自动失效。自己有个主要用的freenom域名就因为Github Actions的自动失效，自己没有注意，并且也没注意freenom发来的提醒邮件，导致过期失效，重新注册就变为付费域名，等了将近一个月，最近该域名才被释放重新注册。





因为项目原理其实是使用linux的crontab，所以使用原生系统直接运行，自己觉得有些侵入，所以开始萌生使用docker之路。



### 📪  配置发信邮箱

下面分别介绍`Gmail`、`QQ邮箱`以及`163邮箱`的设置，你只用看自己需要的部分。注意，`QQ邮箱`与`163邮箱`均使用账户加授权码的方式登录，
`谷歌邮箱`使用账户加密码的方式登录，请知悉。另外还想吐槽一下，国产邮箱你得花一毛钱给邮箱提供方发一条短信才能拿到授权码。

*（点击即可展开或收起）*

<details>
    <summary>设置Gmail</summary>
<br>


1、在`设置>转发和POP/IMAP`中，勾选

- 对所有邮件启用 POP 
- 启用 IMAP

![gmail配置01](https://s2.ax1x.com/2020/01/31/13tKsg.png "gmail配置01")

然后保存更改。

2、允许不够安全的应用

登录谷歌邮箱后，访问 [谷歌权限设置界面](https://myaccount.google.com/u/0/lesssecureapps?pli=1&pageId=none) ，启用允许不够安全的应用。

![gmail配置02](https://s2.ax1x.com/2020/01/31/1392KH.png "gmail配置02")

另外，若遇到提示

> 不允许访问账户

登录谷歌邮箱后，去 [gmail的这个界面](https://accounts.google.com/b/0/DisplayUnlockCaptcha) 点击允许。这种情况较为少见。

***

</details>

<details>
    <summary>设置QQ邮箱</summary>
<br>


在`设置>账户>POP3/IMAP/SMTP/Exchange/CardDAV/CalDAV服务`下，开启`POP3/SMTP服务`

![qq邮箱配置01](https://s2.ax1x.com/2020/01/31/13cIKA.png "qq邮箱配置01")

此时坑爹的QQ邮箱会要求你用手机发送一条短信给腾讯，发送完了点一下`我已发送`

![qq邮箱配置02](https://s2.ax1x.com/2020/01/31/13c4vd.png "qq邮箱配置02")

然后你就能看到你的邮箱授权码了，使用邮箱账户加授权码即可登录，记下授权码

![qq邮箱配置03](https://s2.ax1x.com/2020/01/31/13cTbt.png "qq邮箱配置03")

![qq邮箱配置04](https://s2.ax1x.com/2020/01/31/13coDI.png "qq邮箱配置04")

***

</details>

<details>
    <summary>设置163邮箱</summary>
<br>


在`设置>POP3/SMTP/IMAP`下，开启`POP3/SMTP服务`和`IMAP/SMTP服务`并保存

![163邮箱配置01](https://s2.ax1x.com/2020/01/31/13WKZn.png "163邮箱配置01")

![163邮箱配置02](https://s2.ax1x.com/2020/01/31/13WQI0.png "163邮箱配置02")

现在点击侧边栏的`客户端授权密码`，并获取授权码，你看到画面可能和我不一样，因为我已经获取了授权码，所以只有`重置授权码`按钮，这里自己根据网站提示申请获取授权码，网易和腾讯一样恶心，需要你用手机给它发一条短信才能拿到授权码

![163邮箱配置03](https://s2.ax1x.com/2020/01/31/13WMaq.png "163邮箱配置03")

</details>

#### Telegram bot

上面介绍了三种邮箱的设置方法，如果你不想使用邮件推送，也可以使用 Telegram bot，灵活配置。在`.env`文件中，
将`TELEGRAM_BOT_ENABLE`的值改为`true`，即可启用 Telegram bot，同样的，将`MAIL_ENABLE`的值改为`false`即可关闭邮件推送方式。
Telegram bot 有两个配置项，一个是`chatID`（对应`.env`文件中的`TELEGRAM_CHAT_ID`），
通过使用你的 Telegram 账户发送`/start`给`@userinfobot`即可以获取自己的id，
另一个是`token`（对应`.env`文件中的`TELEGRAM_BOT_TOKEN`），你的 Telegram bot 令牌，你会创建 Telegram bot 就知道怎么获取，
不多赘述。如何创建一个 Telegram bot 请参考：[官方文档](https://core.telegram.org/bots#6-botfather)

### 启动方式

这里附一下我自己的dockerCompose.yml

```yml
version: "3"

services:
  freenom:
     image: maodou38/freenom-auto-renew:latest
     container_name: freenom-renew
     restart: always
     environment:
      - CRON=* 18 * * 5
     volumes:
      - /home/opc/freenom:/conf
```

***.env文件在项目中有提供***

### 🎉  鸣谢

- [PHPMailer](https://github.com/PHPMailer/PHPMailer/) （邮件发送功能依赖此库）

- [guzzle](https://github.com/guzzle/guzzle) （Curl库）

- [luolongfei](https://github.com/luolongfei/freenom) （原作大神）