### 使用verdaccio 搭建npm私有仓库

1. 为什么要搭建私有的npm仓库？
    随着公司的业务越来越复杂，项目迭代速度也越来越快，那么项目间的常用的业务代码共享变得非常之有必要。但是对于公司的业务代码是不能对外开放的，因此我们有必要搭建一个类似于 http://npmjs.org这个的一个私有平台来管理公司业务相关的组件及代码。
    更简单的描述就是我们需要在公司内部搭建一个npm仓库，管理包的同时，也可以借助npm的命令行工具快速用代码模块或业务组件。
但是在没有npm私有仓库之前，我们都是手动复制某个项目的某个模块到相关的项目中，这样操作比较繁琐，因此我们需要一个npm私有仓库存放相关公用的组件及模块。
2. npm及私有npm的工作原理？

   我们使用npm安装，共享和分发代码，npm帮助我们管理项目中的依赖关系，当我们使用 npm install 去安装一个模块时，会先检查 node_modules目录中是否已经存在这个模块，如果没有便会向远程仓库查询。
那现在如果我们搭建了私有的npm，当我们使用 npm install 后会向私有的npm发起请求，服务器会先查询所请求的这个模块是否是我们自己的私有模块或已经缓存过的公共模块，如果是则直接返回给用户，如果不是的话，那么则会继续向上查找(也就是开源的npm仓库)去查找该模块并返回给用户。
3. 如何搭建一个私有的npm仓库呢？

 搭建npm仓库一般有如下基本方法：(需要付费的这边先不写出来哦)：
 1. 使用 Sinopia
 2. 使用cnpmjs.org

 这边先不讲 第二种使用cnpmjs.org，因为它要搭建数据库比较麻烦，有兴趣的童靴可以自己去研究一下。那我们使用第一种哦，那为什么我们现在不用Sinopia呢？而使用 verdaccio 来搭建呢？那是因为 Sinopia 库作者两年前就已经停止了更新了，所以之后就出来了verdaccio(查看github地址
https://github.com/verdaccio/verdaccio)

搭建过程如下：

1. 首先需要安装node环境，反正我电脑上已经安装了，哈哈~ 这边先不介绍了。
2. 安装 verdaccio

##### 使用命令：

`npm install -g verdaccio`

如果在安装过程中报 grywarn的权限错的话，那么需要加上 --unsafe-perm, 如下命令：

`npm install -g verdaccio --unsafe-perm`

启动 verdaccio

`verdaccio`

然后在浏览器中 运行 http://localhost:4873 就可以看到用户界面

##### verdaccio配置

运行 `npm root -g`查看全局包 ，找到 verdaccio 

进入verdaccio 的 conf目录，找到 confid.yaml

`vim confid.yaml`

在底部追加 listen: 0.0.0.0:4873 ,则可以在外网访问用户界面

##### 通过pm2启动verdaccio

`npm install -g pm2`
`pm2 start which verdaccio`

##### 安装nrm来管理自己的npm代理，nrm可以快速修改，切换，增加npm镜像地址。

`npm install -g nrm`

##### npm 发布包

走正常npm流程 常用命令

```
npm publish
npm unpublish
npm login
npm adduser
npm add-user

 ```

