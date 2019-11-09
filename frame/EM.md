# Ember
Ember中使用Stencil组件非常容易，这要感谢`ember-cli-stencil`。
它处理：
 - 将所需文件导入vendor.js
 - 将组件定义复制到assets目录中 
 - 可选）生成包装组件以改进与旧成员版本的兼容性

首先安装`ember-cli-stencil`插件
```
ember install ember-cli-stencil
```
现在，当您构建应用程序时，依赖项中的模具集合将自动被发现并拉入您的应用程序。您只需开始使用hbs文件中的自定义元素，无需进一步工作。有关更多信息，请查看`ember-cli-stencil`文档。