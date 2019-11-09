# 浏览器兼容

Chrome 60+|Safari 10.1+|Firefox 63+|Edge 16+|IE 11
---|:--:|---:|---:|---
true|true|true|true|true
support|support|support|polyfills|polyfills

Web组件是一组以自定义元素v1规范为中心的标准化浏览器api，这是一种定义和创建基本上新的HTML标记的跨浏览器方式，是现在已经失效的v0规范的继承者。

Chrome、Firefox和Safari（包括iOS）都支持自定义元素！目前正在开发Edge中的支持。

对于没有本机支持的浏览器，一个小的polyfill可以帮助开发人员无缝地使用自定义元素，并且性能开销很小。

模具使用动态加载程序加载自定义元素polyfill只在需要它的浏览器上。这个polyfill模板的浏览器支持是Chrome（以及所有基于Chrome的浏览器）、Safari、Firefox、Edge和IE11。

||Chrome 60+|Safari 10.1+|Firefox 63+|Edge 16+|IE 11
|---|:--:|---:|---:|---:|---:|
CSS Variables|true|true|true|true|polyfills 
Custom Elements|true|true|true|polyfills |polyfills 
Shadow Dom|true|true|true|polyfills|polyfills
ES Modules|true|true|true|true|polyfills 
es2017|true|true|true|true|polyfills 