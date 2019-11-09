# Styling Component 样式组件
#####  shadow Dom ？
 是一个内置在浏览器中的API，允许DOM封装和样式封装。shadow Dom将我们的组件与周围的环境隔离开来。这意味着我们不必担心CSS的范围是否正确，也不必担心组件之外的任何东西会干扰我们的内部DOM。 类似于vue
##### 浏览器支持
 - Chrome
 - Firefox
 - Safari
 - Opera

在不支持Shadow DOM的浏览器中，我们回到范围CSS。这为您提供了与Shadow DOM一起提供的样式封装，但没有加载到一个巨大的Shadow DOM polyfill中。
##### Shadow DOM 在Stencli 中应用
对于使用Stencli构建的web组件，默认情况下当前未启用ShadowDOM。要在使用模具构建的web组件中启用Shadow DOM，可以在组件装饰器中使用Shadow参数。下面是一个例子：
```
@Component({
  tag: 'shadow-component',
  styleUrl: 'shadow-component.css',
  shadow: true
})
export class ShadowComponent {

}
```
##### 需要注意
 - QuerySelector：当使用Shadow DOM并且要查询web组件中的元素时，必须使用这个.el.shadowRoot.QuerySelector（）。这是因为web组件中的所有DOM都在shadowdom创建的shadowRoot中。
 - 全局样式：要使用Shadow DOM对组件进行外部样式设置，必须使用CSS自定义属性或建议的CSS阴影部分。
 - 通常，您会将样式包装在组件的标记名中，如下所示

```
my-element {
  color: black;
}
my-element div {
  background: blue;
}
```
启用Shadow DOM后，根目录中的元素将被限定作用域，组件之外的样式将不适用。因此，可以简化组件中的CSS选择器，上面的示例可以是：
```
:host {
  color: black;
}
div {
  background: blue;
}
```
##### scoped css
在当前不支持Shadow DOM的浏览器中，构建的web组件将返回到使用作用域CSS，而不是加载大型Shadow DOM polyfill。作用域CSS通过在运行时为每个样式附加一个数据属性，自动将CSS作用域设置为元素。
##### Css 变量
CSS变量的一个用例是颜色。如果你的应用有一个主品牌的颜色，并在你的应用中使用，那么你可以为它创建一个变量，然后在你的应用中任何你需要的地方使用该变量，而不是在你的应用中每个你需要它的地方写出相同的颜色。此外，如果你需要改变这个颜色，你只需要改变变量，然后它将在你的应用程序中更新。
##### 使用 css 变量
 - 创建一个CSS文件来保存变量定义。我们通常建议在src/global中创建variables.css文件/
 - 然后可以将此配置全局样式:'src/global/variables.css'放入stencil.config.ts文件。
##### 定义css变量

```
/* inside our src/global/variables.css file */

:root {
  --app-primary-color: #488aff;
}
```

在本例中，我们定义了一个名为--app primary color的CSS变量，该变量设置为color#488aff。本例中的：root选择器是一个CSS伪类，它在项目的根元素（通常`<html>`）上定义变量，以便在应用程序中使用该变量。
#####  使用

```
h1 {
  color: var(--app-primary-color)
}
```
