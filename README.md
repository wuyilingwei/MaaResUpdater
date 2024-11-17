# MaaResUpdater

## Maa资源更新程序

仅支持Win10 1803+的版本，curl和tar命令在此版本中加入windows

采用无额外支持库设计，全部命令均由windows自带支持，不需要其他exe/dll。

使用github的下载仓库压缩包功能进行资源更新，以尽可能减少请求数量（cf worker以请求数量计算）。

下载：[Github](https://raw.githubusercontent.com/wuyilingwei/MaaResUpdater/main/MAAResUpdater.bat)，[个人网盘](pan.wuyilingwei.com/api/MAAResUpdater.bat)

最早发布于2024-08-15，B站视频 https://www.bilibili.com/video/BV13w4m1k7j3/ 评论区。简单快速手搓项目，可能异常处理不完善。

## 另，Cloudflare Worker镜像项目

通过Cloudflare+自带域名实现稳定github访问。采用直接下载设计，以减少按次计算的限制（1次/每次更新）。单个账号日免费100'000次Worker请求

用户 - 自带域名 - Cloudflare Workers(Worker - github)

相关代码在[Worker.js](/worker.js)
