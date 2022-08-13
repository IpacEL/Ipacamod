# C.]Ipacamod IpacEL[4.3 
[ipowered by Dev and Our-player](https://ipacamod.cc/)  
您可以在这里提出任何问题, 或是对服务器的功能增强.  
目前缺少维护, 请等待一段时间, 之后我将推出一些更有用的东西.  

## 服务器
- [x] purpur [1.18.2-]
- [x] paper [1.18.2+]
- [x] spigot [1.18.2]
- [x] bukkit [1.18.2]
- [x] mirai [1.18.2]
- [x] pufferfish [1.18.2]
- [x] server.properties [1.18.2]

所有配置注释均由自己查文档翻译[少量机翻], 已修改的配置可能是我自己服务器使用的.  
部分注释后面带问号表示不确定翻译是否正确[配置比较多, 一部分还没有检查...]部分注释后面的值表示默认值.  

## 服务器

启动参数: https://ipacel.cc/Range/?p=%E5%BC%80%E5%8F%91%E6%96%87%E6%A1%A3
- [x] ShenandoahGC
```
启动参数: 发布版本2_beta1, 2022年8月13日更新
-server -Xms16G -Xmx16G -XX:+UnlockExperimentalVMOptions -XX:+UseShenandoahGC -XX:ShenandoahGCMode=iu -XX:+AlwaysPreTouch -XX:+UseLargePages -XX:+PerfDisableSharedMem -XX:+ParallelRefProcEnabled -XX:+DisableExplicitGC -XX:+UseNUMA -XX:ReservedCodeCacheSize=512M -XX:MaxInlineSize=256 -XX:+SegmentedCodeCache -XX:-DontCompileHugeMethods -XX:+OmitStackTraceInFastThrow -XX:ThreadPriorityPolicy=1 -XX:+TrustFinalNonStaticFields -XX:+UseFastUnorderedTimeStamps -XX:+UseXmmI2D -XX:+UseXmmI2F -XX:UseAVX=3 --add-modules=jdk.incubator.vector -XX:+UseVectorCmov -XX:+UseNewLongLShift -XX:+UseFastStosb -jar
```

