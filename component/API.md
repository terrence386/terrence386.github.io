# 组件 API
Stencli提供的整个API可以压缩为一组decorator(装饰器)、生命周期钩子(lifecycles hooks )和渲染(rendering)方法。
##### 装饰器 Decorators
Decorators是一个纯编译器(compiler-time)时结构，模具使用它来收集有关组件、组件可能公开的属性、属性和方法、组件可能发出的事件甚至相关样式表的所有元数据。收集完所有元数据后，将从输出中删除所有decorator，这样它们就不会产生任何运行时开销。
 - @Component（）声明一个新的web组件
 - @Prop（）声明一个公开的属性
 - @State（）声明组件的内部状态
 - @Watch（）声明当属性或状态更改时运行的挂钩
 - @Element（）声明对宿主元素的引用
 - @Method（）声明公开的公共方法
 - @Event（）声明组件可能发出的DOM事件
 - @Listen（）侦听DOM事件
##### 生命周期 hooks
 - connectedCallback()
 - disconnectedCallback()
 - componentWillLoad()
 - componentDidLoad()
 - componentWillRender()
 - componentDidRender()
 - componentWillUpdate()
 - componentDidUpdate()
 - render()
##### 其他
 - Host
 - getAssetPath
 - readTask
 - writeTask
 - setMode()
 - getMode()
 - getElement()
 - JSX

