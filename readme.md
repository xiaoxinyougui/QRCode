1.花了点时间总结了一下QRCode二维码，除了zbar（已经停止维护很久了。。）没碰。
2.最先是系统原生的扫描和生成，iOS7.0以上才能适配。所以支持7.0及一下的就不能用了。
3.libqrencode.生成二维码，导入工程也很顺利，没什么报错
4.ZXingObjc 识别和生成这个就有点呵呵了，手动导入报错很多，后来干脆就pod了一个，错误集锦存在http://blog.sina.com.cn/s/blog_1608342570102wun9.html
5.LBXScan 集成了系统原生和ZXingObjc,在弄到ZXingObjc的时候我就在想，ZXing没有对摄像头的封装，只有对图片的识别，那么用系统的AVFoundation去取得图片然后来识别也是可以的嘛，然后就看到了LBXScan很强大。但是他用的是系统和zxing就没有再去细看。
