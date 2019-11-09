# 组件装饰器
每个Stencli组件都必须使用@Stencil/core包中的@Component（）装饰器进行装饰。在最简单的情况下，开发人员必须为组件提供一个HTML标记名。通常，也会使用样式url，甚至样式url，其中可以为不同的应用程序模式/主题提供多个不同的样式表。
```
import { Component } from '@stencil/core';

@Component({
  tag: 'todo-list',
  styleUrl: 'todo-list.css'
})
export class TodoList {

}
```
# Component Options 参数
@Component（opts:ComponentOptions）接受一个包含所有组件级特性的必需对象。tag标记名是唯一必需的属性，但有很多：
```
export interface ComponentOptions {
  /**
   * Tag name of the web component. Ideally, the tag name must be globally unique,
   * so it's recommended to choose an unique prefix for all your components within the same collection.
   *
   * In addition, tag name must contain a '-'
   */
  tag: string;

  /**
   * If `true`, the component will use scoped stylesheets. Similar to shadow-dom,
   * but without native isolation. Defaults to `false`.
   */
  scoped?: boolean;

  /**
   * If `true`, the component will use native shadow-dom encapsulation, it will fallback to `scoped` if the browser
   * does not support shadow-dom natively. Defaults to `false`.
   */
  shadow?: boolean;

  /**
   * Relative URL to some external stylesheet file. It should be a `.css` file unless some
   * external plugin is installed like `@stencil/sass`.
   */
  styleUrl?: string;

  /**
   * Similar as `styleUrl` but allows to specify different stylesheets for different modes.
   */
  styleUrls?: string[] | d.ModeStyles;

  /**
   * String that contains inlined CSS instead of using an external stylesheet.
   * The performance characteristics of this feature are the same as using an external stylesheet.
   *
   * Notice, you can't use sass, or less, only `css` is allowed using `styles`, use `styleUrl` if you need more advanced features.
   */
  styles?: string;

  /**
   * Array of relative links to folders of assets required by the component.
   */
  assetsDirs?: string[];

  /**
   * @deprecated Use `assetsDirs` instead
   */
  assetsDir?: string;
}
```
# 嵌入或嵌套组件
通过将HTML标记添加到JSX代码中，可以很容易地组合组件。由于这些组件只是HTML标记，因此无需导入任何内容即可在另一个模具组件中使用模具组件。

下面是在另一个组件中使用组件的示例：
```
import { Component, Prop, h } from '@stencil/core';

@Component({
  tag: 'my-embedded-component'
})
export class MyEmbeddedComponent {
  @Prop() color: string = 'blue';

  render() {
    return (
      <div>My favorite color is {this.color}</div>
    );
  }
}
```
```
import { Component, h } from '@stencil/core';

@Component({
  tag: 'my-parent-component'
})
export class MyParentComponent {

  render() {
    return (
      <div>
        <my-embedded-component color="red"></my-embedded-component>
      </div>
    );
  }
}
```
my parent组件在render（）函数中包含对my embedded组件的引用。