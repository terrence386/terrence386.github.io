# 第一个Component
通过添加扩展名为.tsx的新文件（如my-first-component.tsx）并将其放置在src/components目录中，可以创建模具组件。由于模具组件是使用JSX和TypeScript构建的，因此需要.tsx扩展名。

demo:
```
import { Component, Prop, h } from '@stencil/core';

@Component({
  tag: 'my-first-component',
})
export class MyComponent {

  // Indicate that name should be a public property on the component
  @Prop() name: string;

  render() {
    return (
      <p>
        My name is {this.name}
      </p>
    );
  }
}
```
一旦编译完成，这个组件就可以像其他标签一样在HTML中使用。

```
<my-first-component name="Max"></my-first-component>
```
# 发生了什么
我们首先看到的是@Component装饰器。此装饰器向stencil编译器提供有关组件的元数据。信息，例如要使用的标记和外部样式，可以在这里设置并由编译器获取。

在@Component（）装饰器下面，我们有一个标准的JavaScript类。在这里，您将编写大量代码，使您的组件发挥作用。这里是编写函数或提供业务逻辑的地方。

为了让组件向屏幕呈现某些内容，我们必须声明一个返回JSX的呈现函数。如果您不确定JSX是什么，不用担心，我们将在[模板文档]()中详细讨论它。

快速的想法是，我们的呈现函数需要返回一个要推送到DOM的HTML的表示。

类的name属性还应用了一个@Prop（）装饰器。这个装饰器告诉编译器该属性是组件的公共属性，用户应该设置它。我们将此属性设置为：
```
<my-first-component name="Max"></my-first-component>
```
任何用@Prop（）修饰的属性也会自动监视更改。如果组件的用户要更改元素的name属性，我们的组件将再次启动其render函数，更新显示的内容
# 组件 Generator
Stencil CLI可以为您生成新组件。如果您使用其中一个启动程序，您可以在项目中简单地运行generate npm脚本，它将启动交互式生成器。
```
npm run generate
```
或者可以直接使用generate命令调用Stencil CLI（简称g）。如果没有全局安装模具，请在命令前面加上npx。
```
stencil generate
```
可以选择将组件标记名直接传递给命令。请记住，组件标记名必须小写，并且至少包含一个连字符。在第二步中，生成器将询问要生成哪些文件。这允许您引导样式表、spec和e2e测试以及组件文件。

所有组件都将在src/components文件夹中生成。在该文件夹中，将创建一个与您提供的组件标记名同名的文件夹，并在该文件夹中生成文件。也可以指定一个或多个子文件夹以在中生成组件。

例如，如果指定pages/page home作为组件标记名，则将在src/components/pages/page home中生成文件。
```
stencil generate pages/page-home
```
生成
```
src
 |- components
     |- pages
         |- page-home
             |- page-home.css
             |- page-home.e2e.ts
             |- page-home.spec.ts
             |- page-home.tsx
```
